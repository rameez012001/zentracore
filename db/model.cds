namespace zentracore.orders;

using { managed } from '@sap/cds/common';

entity Order : managed {
    key ID           : UUID;
    orderNumber      : String(30);
    status           : String(20);
    totalPrice       : Decimal(15,2);
    currency         : String(3);

    shippingAddress  : Composition of one Address;
    billingAddress   : Composition of one Address;

    items            : Composition of many OrderItem
                         on items.order = $self;

    consignments     : Composition of many Consignment
                         on consignments.order = $self;
}

entity OrderItem : managed {
    key ID           : UUID;
    order            : Association to Order;
    productCode      : String(50);
    productName      : String(100);
    quantity         : Integer;
    unitPrice        : Decimal(15,2);
    totalPrice       : Decimal(15,2);
}

entity Consignment : managed {
    key ID           : UUID;
    order            : Association to Order;
    consignmentCode  : String(30);
    status           : String(20);
    trackingNumber   : String(50);

    shippingAddress  : Association to Address;

    items            : Composition of many ConsignmentItem
                         on items.consignment = $self;
}

entity ConsignmentItem : managed {
    key ID           : UUID;
    consignment      : Association to Consignment;
    orderItem        : Association to OrderItem;
    productCode      : String(50);
    quantity         : Integer;
}

entity Address : managed {
    key ID           : UUID;
    fullName         : String(100);
    line1            : String(255);
    line2            : String(255);
    city             : String(100);
    region           : String(100);
    postalCode       : String(20);
    country          : String(20);
    phone            : String(20);
}