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
};
