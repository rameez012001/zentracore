namespace zentracore.srv;

using {zentracore.db as model} from '../db/model';

service MyService @(require: 'authenticated-user') {

    entity TechnicalObject  as projection on model.TechnicalObject;

    @odata.draft.enabled : true
    entity MaintenanceRequest as
        projection on model.MaintenanceRequest {
            *,
            technicalobject.technicalobject as TechnicalObject,
        }
        actions {
            action markAsRepaired();         
        };
}