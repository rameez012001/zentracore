namespace zentracore.srv;

using {zentracore.db as model} from '../db/model';

service MyService @(require: 'authenticated-user') {

    entity Equipment as projection on model.Equipment;

    entity MaintenanceRequest as
        projection on model.MaintenanceRequest {
            *,
            assignedTo.name as Technician
        }
        actions {
            action selfAssign(technician_id: Integer);
            action fixed();
        };

    entity Schedule           as projection on model.Schedule;
    entity Technician         as projection on model.Technician;


}
