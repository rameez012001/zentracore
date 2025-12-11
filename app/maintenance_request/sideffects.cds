using { zentracore.srv.MyService as service } from '../../srv/service';
using from './annotations';


annotate service.MaintenanceRequest with actions {
    
    markAsRepaired @(
        Core.OperationAvailable : {
            $edmJson : {
                $Eq : [
                    { $Path : 'status' },
                    'INPROGRESS'
                ]
            }
        },

        Common.SideEffects : {
            TargetProperties : ['status'],
            TargetEntities   : ['technicalobject']
        }
    );


    assignTechnician @(
        Core.OperationAvailable : {
            $edmJson : {
                $Eq : [
                    { $Path : 'status' },
                    'OPEN'
                ]
            }
        },

        Common.SideEffects : {
            TargetProperties : ['status', 'technician_ID'],
            TargetEntities   : ['technician', 'technicalobject']
        }
    );

};
annotate service.MaintenanceRequest with @(
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Maintentance Request',
    },
    UI.LineItem #MaintenanceRequest : [
        {
            $Type : 'UI.DataField',
            Value : priority,
            Label : 'priority',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : 'status',
        },
        {
            $Type : 'UI.DataField',
            Value : TechnicalObject,
            Label : 'TechnicalObject',
        },
        {
            $Type : 'UI.DataField',
            Value : technicalobject_id,
            Label : 'technicalobject_id',
        },
        {
            $Type : 'UI.DataField',
            Value : Technician,
            Label : 'Technician',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Title',
            Value : title,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Priority',
            Value : priority,
            Criticality : priorityCriticality,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
            Criticality : statusCriticality,
            CriticalityRepresentation : #WithIcon,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Technical Object',
            Value : technicalobject.technicalobject,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Technician',
            Value : technician.name,
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'zentracore.srv.MyService.assignTechnician',
            Label : 'Assign Technician',
            Criticality : 3,
            @UI.Hidden,
            @UI.Importance : #High,
        },
    ],
    UI.SelectionFields : [
        status,
        priority,
    ],
);

annotate service.TechnicalObject with @(
    UI.HeaderInfo : {
        TypeName : 'TechnicalObject',
        TypeNamePlural : 'TechnicalObjects',
        ImageUrl: imageUrl,
        Title : {
            $Type : 'UI.DataField',
            Value : technicalobject,
        },
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Technical Assets',
            ID : 'TechnicalAssets',
            Target : '@UI.Identification',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Maintenance Request',
            ID : 'MaintenanceRequest',
            Target : 'maintenancerequests/@UI.LineItem#MaintenanceRequest',
        },
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View TechnicalObject',
    },
    UI.LineItem #tableView1 : [
        {
            $Type : 'UI.DataField',
            Value : imageUrl,
            Label : 'imageUrl',
        },
        {
            $Type : 'UI.DataField',
            Value : technicalobject,
            Label : 'technicalobject',
        },
        {
            $Type : 'UI.DataField',
            Value : technicalidentificationnumber,
            Label : 'technicalidentificationnumber',
        },
        {
            $Type : 'UI.DataField',
            Value : systemstatus,
            Label : 'systemstatus',
        },
        {
            $Type : 'UI.DataField',
            Value : objecttype,
            Label : 'objecttype',
        },
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView1',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Assets',
    },
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : maintenanceplant,
            Label : 'maintenanceplant',
        },
        {
            $Type : 'UI.DataField',
            Value : mainworkcenter,
            Label : 'mainworkcenter',
        },
        {
            $Type : 'UI.DataField',
            Value : manufacturer,
            Label : 'manufacturer',
        },
        {
            $Type : 'UI.DataField',
            Value : objecttype,
            Label : 'objecttype',
        },
        {
            $Type : 'UI.DataField',
            Value : plannergroup,
            Label : 'plannergroup',
        },
        {
            $Type : 'UI.DataField',
            Value : plantsection,
            Label : 'plantsection',
        },
        {
            $Type : 'UI.DataField',
            Value : superiortechnicalobject,
            Label : 'superiortechnicalobject',
        },
        {
            $Type : 'UI.DataField',
            Value : systemstatus,
            Label : 'systemstatus',
        },
        {
            $Type : 'UI.DataField',
            Value : technicalidentificationnumber,
            Label : 'technicalidentificationnumber',
        },
        {
            $Type       : 'UI.DataFieldForAction',
            Action      : 'zentracore.srv.MyService.raisetTicket',
            Label       : 'Raise Ticket',
            Criticality : 3,
            ![@UI.Hidden]: {$edmJson: {$Eq: [
                {$Path: 'systemstatus'},
                'ACTIVE'
            ]}}
        },
    ],
    
);

annotate service.TechnicalObject with {
    imageUrl @UI.IsImageURL : true
};

annotate service.MaintenanceRequest with {
    status @(
        Common.Label : 'status',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Status with {
    code @Common.Text : name
};

annotate service.MaintenanceRequest with {
    priority @(
        Common.Label : 'priority',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Priority',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : priority,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Priority',
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Priority with {
    code @Common.Text : name
};

