using { zentracore.srv.MyService as service } from '../../srv/service';

annotate service.MaintenanceRequest with actions {

    // ======================================================
    // MARK AS REPAIRED (Enabled only when status = 'INPROGRESS')
    // ======================================================
    markAsRepaired @(
        Core.OperationAvailable : {
            $edmJson : {
                $Eq : [
                    { $Path : 'status' },
                    'INPROGRESS'
                ]
            }
        },

        Common.SideEffects : {
            TargetProperties : ['status'],
            TargetEntities   : ['technicalobject']
        }
    );


    // ======================================================
    // ASSIGN TECHNICIAN (Enabled only when status = 'OPEN')
    // ======================================================
    assignTechnician @(
        Core.OperationAvailable : {
            $edmJson : {
                $Eq : [
                    { $Path : 'status' },
                    'OPEN'
                ]
            }
        },

        Common.SideEffects : {
            TargetProperties : ['status', 'technician_ID'],
            TargetEntities   : ['technician', 'technicalobject']
        }
    );

};
