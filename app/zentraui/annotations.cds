using OrderService as service from '../../srv/service';
annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orderNumber',
                Value : orderNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalPrice',
                Value : totalPrice,
            },
            {
                $Type : 'UI.DataField',
                Label : 'currency',
                Value : currency,
            },
            {
                $Type : 'UI.DataField',
                Label : 'shippingAddress_ID',
                Value : shippingAddress_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'billingAddress_ID',
                Value : billingAddress_ID,
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
            Label : 'ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'orderNumber',
            Value : orderNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'totalPrice',
            Value : totalPrice,
        },
        {
            $Type : 'UI.DataField',
            Label : 'currency',
            Value : currency,
        },
    ],
);

annotate service.Orders with {
    shippingAddress @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Addresses',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : shippingAddress_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'fullName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'line1',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'line2',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'city',
            },
        ],
    }
};

annotate service.Orders with {
    billingAddress @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Addresses',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : billingAddress_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'fullName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'line1',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'line2',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'city',
            },
        ],
    }
};

