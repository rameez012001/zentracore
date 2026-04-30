using {zentracore.orders as db} from '../db/model';

service OrderService @(path: '/orders') {
    @odata.draft.enabled
    entity Orders as projection on db.Order;

    entity OrderItems as projection on db.OrderItem;

    entity Consignments as projection on db.Consignment; 

    entity ConsignmentItems  as projection on db.ConsignmentItem;

    entity Addresses as projection on db.Address;

    action createConsignment();
}
