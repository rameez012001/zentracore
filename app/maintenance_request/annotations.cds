using zentracore.srv.MyService as service from '../../srv/service';
annotate service.MaintenanceRequest with @(
    UI.HeaderInfo : {
        $Type  : 'UI.HeaderInfoType',
        TypeName        : 'Maintenance Request',
        TypeNamePlural  : 'Maintenance Requests',

        Title : {
            $Type : 'UI.DataField',
            Value : title
        },

        Description : {
            $Type : 'UI.DataField',
            Value : TechnicalObject
        }
    },
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'technicalobject_id',
                Value : technicalobject_id,
            },
            {
                $Type : 'UI.DataField',
                Label : 'title',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'priority',
                Value : priority,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'TechnicalObject',
                Value : TechnicalObject,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'title',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Label : 'description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'priority',
            Value : priority,
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'technicalobject_id',
            Value : technicalobject_id,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'zentracore.srv.MyService.markAsRepaired',
            Label : 'Mark as Repaired',
        },
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'zentracore.srv.MyService.markAsRepaired',
            Label : 'markAsRepaired',
        },
    ],
);

annotate service.MaintenanceRequest with {
    technicalobject @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'TechnicalObject',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : technicalobject_id,
                ValueListProperty : 'id',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'technicalobject',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'technicaltype',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'objecttype',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'maintenanceplant',
            },
        ],
    }
};

