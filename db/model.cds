namespace zentracore.db;

entity Equipment {
    key id           : Integer;
        name         : String(80);
        serialNumber : String(40);
        category     : String(40);
        location     : String(80);
        status       : String(20);
}

entity Technician {
    key id       : Integer;
        name     : String(80);
        skill    : String(60);
        workload : Integer;
        phone    : String(30);
}

entity MaintenanceRequest {
    key id          : Integer;
        title       : String(120);
        description : String(500);
        priority    : String(20);
        status      : String(20) default 'Open';
        requestedAt : DateTime default current_timestamp;
        closedAt    : DateTime;
        equipment   : Association to Equipment;
        assignedTo  : Association to Technician;
}

entity Schedule {
    key id             : Integer;
        maintenanceReq : Association to MaintenanceRequest;
        technician     : Association to Technician;
        startAt        : DateTime;
        endAt          : DateTime;
}
