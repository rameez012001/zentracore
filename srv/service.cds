namespace zentracore.srv;

using {zentracore.db as model} from '../db/model';

service MyService {
    entity TechnicalObject    as projection on model.TechnicalObject {
        *,
        case systemstatus
            when 'ACTIVE' then 3
            when 'UNDERMAINTENANCE' then 2
            when 'INACTIVE' then 2
            else 0
        end as systemstatusCriticality : Integer
    }actions{
        action raisetTicket(title: String, priority: String, desc: String);
    };


    entity MaintenanceRequest as
        projection on model.MaintenanceRequest {
            *,
            technicalobject.technicalobject as TechnicalObject : String,
            technician.name                 as Technician       : String,
            technician.technicianUserName as username : String,
            technician.workload as workload: String,
            case priority
                when 'HIGH' then 1
                when 'MID'  then 2
                when 'LOW'  then 3
                else 0
            end                             as priorityCriticality : Integer,
            case status
                when 'OPEN'       then 1
                when 'INPROGRESS' then 2
                when 'FIXED'      then 3
                else 0
            end                             as statusCriticality : Integer
        }
        actions {
            action markAsRepaired();
            action assignTechnician(username: String);
        };

    entity Technician         as projection on model.Technician;

    entity Priority as projection on model.Priority;

    entity Status as projection on model.Status;
}