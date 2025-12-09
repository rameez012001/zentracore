namespace zentracore.db;

using {managed, cuid} from '@sap/cds/common';

entity TechnicalObject {
    key id                            : Integer;
        technicalobject               : String;
        technicaltype                 : String enum {
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
        systemstatus                  : String enum {
            ACTIVE;
            UNDERMAINTENANCE;
            INACTIVE;
        };
        technicalidentificationnumber : String;
        maintenancerequests            : Composition of many MaintenanceRequest
                                            on maintenancerequests.technicalobject = $self;
}

entity MaintenanceRequest : managed, cuid {
        technicalobject : Association to TechnicalObject;
        title           : String;
        description     : String;
        priority        : String enum {
            HIGH;
            MID;
            LOW;
        };
        status          : String enum {
            OPEN;
            INPROGRESS;
            FIXED;
        } default 'OPEN';
        technician      : Association to Technician;
}

entity Technician : cuid {
        name               : String;
        technicianUserName : String;
        workload           : Integer;
}