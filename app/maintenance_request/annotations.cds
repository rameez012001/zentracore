using zentracore.srv.MyService as service from '../../srv/service';

annotate service.MaintenanceRequest with {
    status @(
        Common.Label                   : 'status',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Status',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: status,
                ValueListProperty: 'code',
            }, ],
            Label         : 'Status',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Status with {
    code @Common.Text: name
};

annotate service.MaintenanceRequest with {
    priority @(
        Common.Label                   : 'priority',
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Priority',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: priority,
                ValueListProperty: 'code',
            }, ],
            Label         : 'Priority',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Priority with {
    code @Common.Text: name
};

annotate service.MaintenanceRequest with @(
    // Tab for multitable
    UI.SelectionPresentationVariant #tableView: {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem',
            // which view line items to execute
            ],
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [],
        },
        Text               : 'Maintentance Requests',
    },

    UI.LineItem                    : [
        {
            $Type            : 'UI.DataField',
            Label            : 'Title',
            Value            : title,
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataField',
            Label            : 'Description',
            Value            : description,
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataField',
            Label            : 'Priority',
            Value            : priority,
            Criticality      : priorityCriticality,
            ![@UI.Importance]: #High
        },
        {
            $Type                    : 'UI.DataField',
            Label                    : 'Status',
            Value                    : status,
            Criticality              : statusCriticality,
            CriticalityRepresentation: #WithoutIcon,
            ![@UI.Importance]        : #High
        },
        {
            $Type            : 'UI.DataField',
            Label            : 'Technical Object',
            Value            : technicalobject.technicalobject,
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataField',
            Label            : 'Technician',
            Value            : technician.name,
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataFieldForAction',
            Action           : 'zentracore.srv.MyService.assignTechnician',
            Label            : 'Assign Technician',
            Criticality      : 3,
            ![@UI.Hidden]    : {$edmJson: {$Eq: [
                {$Path: 'status'},
                'FIXED'
            ]}},
            ![@UI.Importance]: #High
        },
    ],

    UI.SelectionFields                        : [
        status,
        priority,
    ],

    UI.HeaderInfo                             : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Maintenance Request',
        TypeNamePlural: 'Maintenance Requests',
        TypeImageUrl  : 'sap-icon://wrench',

        Title         : {
            $Type: 'UI.DataField',
            Value: title
        },

        Description   : {
            $Type: 'UI.DataField',
            Value: technicalobject.technicalobject
        }
    },

    UI.HeaderFacets                           : [
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.FieldGroup#HeaderInfo',
            Label : 'Request Details'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.DataPoint#Priority',
            Label : 'Priority'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: '@UI.DataPoint#Status',
            Label : 'Status'
        }
    ],

    UI.DataPoint #Priority                    : {
        Value      : priority,
        Title      : 'Priority',
        Criticality: priorityCriticality
    },

    UI.DataPoint #Status                      : {
        Value      : status,
        Title      : 'Status',
        Criticality: statusCriticality
    },

    UI.FieldGroup #HeaderInfo                 : {Data: [
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Title'
        },
        {
            $Type      : 'UI.DataField',
            Value      : status,
            Label      : 'Status',
            Criticality: statusCriticality
        },
        {
            $Type      : 'UI.DataField',
            Value      : priority,
            Label      : 'Priority',
            Criticality: priorityCriticality
        }
    ]},

    UI.Identification                         : [
        {
            $Type        : 'UI.DataFieldForAction',
            Action       : 'zentracore.srv.MyService.markAsRepaired',
            Label        : 'Mark as Repaired',
            Criticality  : 3,
            ![@UI.Hidden]: {$edmJson: {$Eq: [
                {$Path: 'status'},
                'FIXED'
            ]}}
        },
        {
            $Type            : 'UI.DataFieldForAction',
            Action           : 'zentracore.srv.MyService.assignTechnician',
            Label            : 'Assign Technician',
            Criticality      : 2,
            ![@UI.Hidden]    : {$edmJson: {$Eq: [
                {$Path: 'status'},
                'FIXED'
            ]}},
            ![@UI.Importance]: #High
        },
    ],

    UI.Facets                                 : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInfoFacet',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneralInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInfoFacet1',
            Label : 'Technical Asset',
            Target: 'technicalobject/@UI.LineItem',
        }
    ],

    UI.FieldGroup #GeneralInfo                : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Title',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: description,
            },
            {
                $Type      : 'UI.DataField',
                Label      : 'Priority',
                Value      : priority,
                Criticality: priorityCriticality
            },
            {
                $Type                    : 'UI.DataField',
                Label                    : 'Status',
                Value                    : status,
                Criticality              : statusCriticality,
                CriticalityRepresentation: #WithoutIcon
            },
            {
                $Type: 'UI.DataField',
                Label: 'Technician',
                Value: technician.name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Technical Object',
                Value: technicalobject.technicalobject,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Technical Type',
                Value: technicalobject.technicaltype,
            },
            {
                $Type                    : 'UI.DataField',
                Label                    : 'System Status',
                Value                    : technicalobject.systemstatus,
                Criticality              : technicalobject.systemstatusCriticality,
                CriticalityRepresentation: #WithIcon
            }
        ],
    },

    // Line item for technical object page
    UI.LineItem #MaintenanceRequest           : [
        {
            $Type      : 'UI.DataField',
            Value      : priority,
            Label      : 'priority',
            Criticality: priorityCriticality
        },
        {
            $Type      : 'UI.DataField',
            Value      : status,
            Label      : 'status',
            Criticality: statusCriticality
        },
        {
            $Type: 'UI.DataField',
            Value: TechnicalObject,
            Label: 'TechnicalObject',
        },
        {
            $Type: 'UI.DataField',
            Value: technicalobject_id,
            Label: 'technicalobject_id',
        },
        {
            $Type: 'UI.DataField',
            Value: Technician,
            Label: 'Technician',
        },
    ],
);

// Side Effects
annotate service.MaintenanceRequest with actions {

    markAsRepaired   @(
        Core.OperationAvailable: {$edmJson: {$Eq: [
            {$Path: 'status'},
            'INPROGRESS'
        ]}},

        Common.SideEffects     : {
            TargetProperties: ['status'],
            TargetEntities  : ['technicalobject']
        }
    );


    assignTechnician @(
        Core.OperationAvailable: {$edmJson: {$Eq: [
            {$Path: 'status'},
            'OPEN'
        ]}},

        Common.SideEffects     : {
            TargetProperties: [
                'status',
                'technician_ID'
            ],
            TargetEntities  : [
                'technician',
                'technicalobject'
            ]
        }
    );

};