using {zentracore.srv.MyService as service} from '../../srv/service';
using from './annotations';


annotate service.TechnicalObject with {
    imageUrl @UI.IsImageURL: true
};

annotate service.TechnicalObject with @(
    UI.SelectionPresentationVariant #tableView: {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem',// which view line items to execute
            ],
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [],
        },
        Text               : 'Assets',
    },

    UI.LineItem                   : [
        {
            $Type: 'UI.DataField',
            Value: imageUrl,
            Label: 'Asset',
        },
        {
            $Type: 'UI.DataField',
            Value: technicalobject,
            Label: 'Asset Name',
        },
        {
            $Type: 'UI.DataField',
            Value: technicalidentificationnumber,
            Label: 'Technical Identification Number',
        },
        {
            $Type: 'UI.DataField',
            Value: systemstatus,
            Label: 'Status',
            Criticality: systemstatusCriticality
        },
        {
            $Type: 'UI.DataField',
            Value: objecttype,
            Label: 'Asset Type',
        },
    ],

    UI.HeaderInfo                              : {
        TypeName      : 'Technical Object',
        TypeNamePlural: 'Technical Objects',
        ImageUrl      : imageUrl,
        Title         : {
            $Type: 'UI.DataField',
            Value: technicalobject,
        },
    },
    UI.Facets                                  : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Technical Assets',
            ID    : 'TechnicalAssets',
            Target: '@UI.Identification',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Maintenance Request',
            ID    : 'MaintenanceRequest',
            Target: 'maintenancerequests/@UI.LineItem#MaintenanceRequest',
        },
    ],

    UI.Identification                          : [
        {
            $Type: 'UI.DataField',
            Value: maintenanceplant,
            Label: 'maintenanceplant',
        },
        {
            $Type: 'UI.DataField',
            Value: mainworkcenter,
            Label: 'mainworkcenter',
        },
        {
            $Type: 'UI.DataField',
            Value: manufacturer,
            Label: 'manufacturer',
        },
        {
            $Type: 'UI.DataField',
            Value: objecttype,
            Label: 'objecttype',
        },
        {
            $Type: 'UI.DataField',
            Value: plannergroup,
            Label: 'plannergroup',
        },
        {
            $Type: 'UI.DataField',
            Value: plantsection,
            Label: 'plantsection',
        },
        {
            $Type: 'UI.DataField',
            Value: superiortechnicalobject,
            Label: 'superiortechnicalobject',
        },
        {
            $Type: 'UI.DataField',
            Value: systemstatus,
            Label: 'systemstatus',
            Criticality: systemstatusCriticality,
            CriticalityRepresentation : #WithoutIcon
        },
        {
            $Type: 'UI.DataField',
            Value: technicalidentificationnumber,
            Label: 'technicalidentificationnumber',
        },
        {
            $Type        : 'UI.DataFieldForAction',
            Action       : 'zentracore.srv.MyService.raisetTicket',
            Label        : 'Raise Ticket',
            Criticality  : 3,
            ![@UI.Hidden]: {$edmJson: {$Eq: [
                {$Path: 'systemstatus'},
                'ACTIVE'
            ]}}
        },
    ],

);
