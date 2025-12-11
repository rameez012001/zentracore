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
        maintenancerequests            : Association to  many MaintenanceRequest
                                            on maintenancerequests.technicalobject = $self;
        imageUrl        : String;                                        
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

entity Priority{
    key code: String;
        name: String;
}

entity Status{
    key code: String;
        name: String;
}

entity Technician : cuid {
        name               : String;
        technicianUserName : String;
        workload           : Integer;
}