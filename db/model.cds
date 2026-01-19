namespace zentracore.db;

using {managed, cuid} from '@sap/cds/common';

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

entity TechnicalObject : cuid{
        technicalobject               : String;
        technicaltype                 : String enum {
            EQUIPMENT;
            TOOLS;
        };
        manufacturer                  : String;
        systemstatus                  : String enum {
            ACTIVE;
            UNDERMAINTENANCE;
            INACTIVE;
        };
        maintenancerequests            : Association to  many MaintenanceRequest
                                            on maintenancerequests.technicalobject = $self;
        imageUrl        : String;                                        
}

entity Technician : cuid {
        name               : String;
        technicianUserName : String;
        workload           : Integer;
}

entity Priority{
    key code: String;
        name: String;
}

entity Status{
    key code: String;
        name: String;
}