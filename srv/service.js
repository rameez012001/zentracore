const cds = require("@sap/cds");

module.exports = async function (srv) {
  const { Orders, OrderItem, Consignment, ConsignmentItem, Address } =
    srv.entities;

  srv.before("CREATE", Orders, async (req) => {
    if (req.data.shippingAddress_ID==null || req.data.billingAddress_ID==null) {
      req.reject(
        400,
        "Only one shippingAddress and one billingAddress are allowed",
      );
    }
    if (req.data.items?.length) {
      req.data.items = req.data.items.map((obj, index) => ({
        ID: obj.ID,
        productCode: obj.productCode,
        productName: obj.productName,
        quantity: obj.quantity || 1,
        unitPrice: obj.unitPrice || 0.0,
        totalPrice: (obj.quantity || 1) * (obj.unitPrice || 0.0),
      }));
      req.data.totalPrice = req.data.items.reduce((sum,obj)=>sum+obj.totalPrice,0)
    }else{
      req.reject(400, "Add Products");
    }
    
  });

  srv.on("createConsignment", async (req) => {
    const tx = cds.tx;

    // 1. Fetch all orders with items
    const orders = await tx.run(
      SELECT.from(Orders).columns(
        "ID",
        "customerName",
        "status",
        "totalPrice",
        { items: ["ID", "productCode", "productName", "quantity"] }
      )
    );

    if (!orders.length) {
      return {
        message: "No orders found",
        totalOrders: 0,
        createdCount: 0,
        skippedCount: 0,
      };
    }

    let createdCount = 0;
    let skippedCount = 0;

    for (const order of orders) {
      // 2. Skip if consignment already exists for this order
      const existingConsignment = await tx.run(
        SELECT.one.from(Consignment).where({ order_ID: order.ID })
      );

      if (existingConsignment) {
        skippedCount++;
        continue;
      }

      // 3. Create consignment header
      const consignmentId = cds.utils.uuid();

      await tx.run(
        INSERT.into(Consignment).entries({
          ID: consignmentId,
          order_ID: order.ID,
          status: "CREATED",
        })
      );

      // 4. Create consignment items from order items
      if (order.items?.length) {
        const consignmentItems = order.items.map((item) => ({
          ID: cds.utils.uuid(),
          consignment_ID: consignmentId,
          productCode: item.productCode,
          productName: item.productName,
          quantity: item.quantity,
        }));

        await tx.run(
          INSERT.into(ConsignmentItem).entries(consignmentItems)
        );
      }

      // 5. Optional: update order status
      await tx.run(
        UPDATE(Orders)
          .set({ status: "CONSIGNMENT_CREATED" })
          .where({ ID: order.ID })
      );

      createdCount++;
    }

    return {
      message: "Consignment creation completed",
      totalOrders: orders.length,
      createdCount,
      skippedCount,
    };
  });

};
