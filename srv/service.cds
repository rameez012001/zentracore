using {zentracore.orders as db} from '../db/model';

service OrderService @(path: '/orders') {

    entity Orders @(restrict: [{
            grant: 'READ',
            to   : 'ZenViewer'
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : 'ZenManager'
        },
        {
            grant: 'DELETE',
            to   : 'ZenAdmin'
        }
    ]) as projection on db.Order;

    entity OrderItems @(restrict: [{
            grant: 'READ',
            to   : 'ZenViewer'
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : 'ZenManager'
        },
        {
            grant: 'DELETE',
            to   : 'ZenAdmin'
        }
    ]) as projection on db.OrderItem;

    entity Consignments @(restrict: [{
            grant: 'READ',
            to   : 'ZenViewer'
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : 'ZenManager'
        },
        {
            grant: 'DELETE',
            to   : 'ZenAdmin'
        }
    ]) as projection on db.Consignment;

    entity ConsignmentItems @(restrict: [{
            grant: 'READ',
            to   : 'ZenViewer'
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : 'ZenManager'
        },
        {
            grant: 'DELETE',
            to   : 'ZenAdmin'
        }
    ]) as projection on db.ConsignmentItem;

    entity Addresses @(restrict: [{
            grant: 'READ',
            to   : 'ZenViewer'
        },
        {
            grant: [
                'CREATE',
                'UPDATE'
            ],
            to   : 'ZenManager'
        },
        {
            grant: 'DELETE',
            to   : 'ZenAdmin'
        }
    ]) as projection on db.Address;

}
