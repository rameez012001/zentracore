namespace zentracore.orders;


entity Consignment  {
    key id : Integer;
    order: Association to Order;
    status: String;
    shipping_address: Association to Address;
    consignment_entries: Association to ConsignmentEntries;
}

entity ConsignmentEntries {
    key id : Integer;
    
}

entity Order  {
    key id: Integer;
    total_price: Double;
    line_items: Association to many OrderEntries on line_items.order = $self;
    consignment: Association to many Consignment on consignment.order = $self;
}

entity OrderEntries{
    key id: Integer;
    order: Association to Order;
}

entity Address {
    key id: Integer;
    
}