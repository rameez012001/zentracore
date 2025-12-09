using zentracore.srv.MyService as service from '../../srv/service';

annotate service.MaintenanceRequest with @(
    UI.HeaderInfo : {
        $Type           : 'UI.HeaderInfoType',
        TypeName        : 'Maintenance Request',
        TypeNamePlural  : 'Maintenance Requests',
        TypeImageUrl    : 'sap-icon://wrench',

        Title : {
            $Type : 'UI.DataField',
            Value : title
        },

        Description : {
            $Type : 'UI.DataField',
            Value : technicalobject.technicalobject
        }
    },

    UI.HeaderFacets : [
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#HeaderInfo',
            Label  : 'Request Details'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Priority',
            Label  : 'Priority'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Target : '@UI.DataPoint#Status',
            Label  : 'Status'
        }
    ],

    UI.FieldGroup #HeaderInfo : {
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Title'
            },
            {
                $Type       : 'UI.DataField',
                Value       : status,
                Label       : 'Status',
                Criticality : statusCriticality
            },
            {
                $Type       : 'UI.DataField',
                Value       : priority,
                Label       : 'Priority',
                Criticality : priorityCriticality
            }
        ]
    },

    UI.FieldGroup #GeneralInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : description,
            },
            {
                $Type       : 'UI.DataField',
                Label       : 'Priority',
                Value       : priority,
                Criticality : priorityCriticality
            },
            {
                $Type                     : 'UI.DataField',
                Label                     : 'Status',
                Value                     : status,
                Criticality               : statusCriticality,
                CriticalityRepresentation : #WithIcon
            },
            {
                $Type : 'UI.DataField',
                Label : 'Technician',
                Value : technician.name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Technical Object',
                Value : technicalobject.technicalobject,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Technical Type',
                Value : technicalobject.technicaltype,
            },
            {
                $Type                     : 'UI.DataField',
                Label                     : 'System Status',
                Value                     : technicalobject.systemstatus,
                Criticality               : technicalobject.systemstatusCriticality,
                CriticalityRepresentation : #WithIcon
            }
        ],
    },

    UI.Facets : [
        {
            $Type  : 'UI.CollectionFacet',
            ID     : 'RequestDetails',
            Label  : 'Request Information',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'GeneralInfoFacet',
                    Label  : 'General Information',
                    Target : '@UI.FieldGroup#GeneralInfo',
                },
                // {
                //     $Type  : 'UI.ReferenceFacet',
                //     ID     : 'TechnicalObjectFacet',
                //     Label  : 'Technical Object Details',
                //     Target : '@UI.FieldGroup#TechnicalObjectInfo',
                // },
                // {
                //     $Type  : 'UI.ReferenceFacet',
                //     ID     : 'TechnicanInfoFacet',
                //     Label  : 'Technical Info Details',
                //     Target : '@UI.FieldGroup#TechnicianInfo',
                // }
            ]
        }
    ],

    UI.LineItem : [
        {
            $Type             : 'UI.DataField',
            Label             : 'Title',
            Value             : title,
            ![@UI.Importance] : #High
        },
        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description,
            ![@UI.Importance] : #High
        },
        {
            $Type       : 'UI.DataField',
            Label       : 'Priority',
            Value       : priority,
            Criticality : priorityCriticality,
            ![@UI.Importance] : #High
        },
        {
            $Type                     : 'UI.DataField',
            Label                     : 'Status',
            Value                     : status,
            Criticality               : statusCriticality,
            CriticalityRepresentation : #WithIcon,
            ![@UI.Importance]         : #High
        },
        {
            $Type : 'UI.DataField',
            Label : 'Technical Object',
            Value : technicalobject.technicalobject,
            ![@UI.Importance] : #High
        },
        {
            $Type : 'UI.DataField',
            Label : 'Technician',
            Value : technician.name,
            ![@UI.Importance] : #High
        },
        {
            $Type      : 'UI.DataFieldForAction',
            Action     : 'zentracore.srv.MyService.assignTechnician',
            Label      : 'Assign Technician',
            Criticality: 3,
            ![@UI.Hidden]: {$edmJson: {$Eq: [
                {$Path: 'status'},
                'FIXED'
            ]}},
            ![@UI.Importance] : #High
        },
    ],

    UI.Identification : [
        {
            $Type       : 'UI.DataFieldForAction',
            Action      : 'zentracore.srv.MyService.markAsRepaired',
            Label       : 'Mark as Repaired',
            Criticality : 3,
            ![@UI.Hidden]: {$edmJson: {$Eq: [
                {$Path: 'status'},
                'FIXED'
            ]}}
        },
        {
            $Type      : 'UI.DataFieldForAction',
            Action     : 'zentracore.srv.MyService.assignTechnician',
            Label      : 'Assign Technician',
            Criticality: 2,
            ![@UI.Hidden]: {$edmJson: {$Eq: [
                {$Path: 'status'},
                'FIXED'
            ]}},
            ![@UI.Importance] : #High
        },
    ],

    UI.DataPoint #Priority : {
        Value        : priority,
        Title        : 'Priority',
        Visualization: #Number,
        Criticality  : priorityCriticality
    },

    UI.DataPoint #Status : {
        Value       : status,
        Title       : 'Status',
        Criticality : statusCriticality
    }
);