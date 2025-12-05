using zentracore.srv.MyService as service from '../../srv/service';

annotate service.MaintenanceRequest with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'id',
                Value: id,
            },
            {
                $Type: 'UI.DataField',
                Label: 'title',
                Value: title,
            },
            {
                $Type: 'UI.DataField',
                Label: 'description',
                Value: description,
            },
            {
                $Type: 'UI.DataField',
                Label: 'priority',
                Value: priority,
            },
            {
                $Type: 'UI.DataField',
                Label: 'status',
                Value: status,
            },
            {
                $Type: 'UI.DataField',
                Label: 'requestedAt',
                Value: requestedAt,
            },
            {
                $Type: 'UI.DataField',
                Label: 'dueAt',
                Value: dueAt,
            },
            {
                $Type: 'UI.DataField',
                Label: 'equipment_id',
                Value: equipment_id,
            },
            {
                $Type: 'UI.DataField',
                Label: 'assignedTo_id',
                Value: assignedTo_id,
            },
        ],
    },
    UI.Facets                    : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup',

        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet2',
            Label : 'Technician',
            Target: 'assignedTo/@UI.LineItem',
        }
    ],
    UI.HeaderInfo                : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Maintenance Request',
        TypeNamePlural: 'Maintenance Requests'
    },

    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Label: 'id',
            Value: id,
        },
        {
            $Type: 'UI.DataField',
            Label: 'title',
            Value: title,
        },
        {
            $Type: 'UI.DataField',
            Label: 'description',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Label: 'priority',
            Value: priority,
        },
        {
            $Type: 'UI.DataField',
            Label: 'status',
            Value: status,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Technician',
            Value: Technician,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Self Assign',
            Action: 'zentracore.srv.MyService.selfAssign',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Fixed',
            Action: 'zentracore.srv.MyService.fixed',
        }
    ],

);

annotate service.MaintenanceRequest with {
    equipment @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Equipment',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: equipment_id,
                ValueListProperty: 'id',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'serialNumber',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'category',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'location',
            },
        ],
    }
};

annotate service.MaintenanceRequest with {
    assignedTo @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Technician',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: assignedTo_id,
                ValueListProperty: 'id',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'skill',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'workload',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'phone',
            },
        ],
    }
};

annotate service.Technician with @(
    UI.HeaderInfo: {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Technician',
        TypeNamePlural: 'Technicians'
    },
    UI.LineItem  : [
        {
            $Type: 'UI.DataField',
            Label: 'id',
            Value: id,
        },
        {
            $Type: 'UI.DataField',
            Label: 'name',
            Value: name,
        },
        {
            $Type: 'UI.DataField',
            Label: 'skill',
            Value: skill,
        },
        {
            $Type: 'UI.DataField',
            Label: 'workload',
            Value: workload,
        },
        {
            $Type: 'UI.DataField',
            Label: 'phone',
            Value: phone,
        },
    ],
);