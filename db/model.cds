namespace zentracore.db;

using {managed,cuid} from '@sap/cds/common';

entity TechnicalObject {
    key id                            : Integer;
        technicalobject : String;
        technicaltype                 : String @asset.range enum {
            EQUIPMENT;
            TOOLS;
        };
        objecttype                    : String;
        maintenanceplant              : String;
        location                      : String;
        plantsection                  : String;
        superiortechnicalobject       : String;
        manufacturer                  : String;
        plannergroup                  : String;
        mainworkcenter                : String;
        systemstatus                  : String @asset.range enum {
            ACTIVE;
            UNDERMAINTENANCE;
            INACTIVE;
        };
        technicalidentificationnumber : String;
        maintenancerequest            : Composition of MaintenanceRequest
                                            on maintenancerequest.technicalobject = $self;
}

entity MaintenanceRequest : managed, cuid {
    // key id              : Integer;
        technicalobject : Association to TechnicalObject;
        title           : String;
        description     : String;
        priority        : String @asset.range enum {
            HIGH;
            MID;
            LOW;
        };
        status          : String @asset.range enum {
            OPEN;
            INPROGRESS;
            FIXED;
        } default 'OPEN';
}
