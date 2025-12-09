const cds = require('@sap/cds');
const { CREATE } = require('@sap/cds/lib/ql/cds-ql');

module.exports = async function (srv) {
    const { TechnicalObject, MaintenanceRequest, Technician } = srv.entities;
    const { markAsRepaired, getPendingRequests } = MaintenanceRequest.actions;
    srv.after('CREATE', MaintenanceRequest, async (data, req) => {
        if (data.technicalobject_id) {
            await UPDATE(TechnicalObject)
                .set({ systemstatus: 'INACTIVE' })
                .where({ id: data.TechnicalObject_id });
        }
    });



    srv.on(markAsRepaired, async req => {
        const { ID } = req.params[0];
        console.log(TechnicalObject)
        const reqRow = await SELECT.one.from(MaintenanceRequest)
            .where({ ID });

        await UPDATE(MaintenanceRequest)
            .set({
                status: 'FIXED'
            })
            .where({ ID });

        await UPDATE(TechnicalObject)
            .set({ systemstatus: 'ACTIVE' })
            .where({ id: reqRow.technicalobject_id });
    });

    srv.on('assignTechnician', async req => {

        // ID comes from params → same as your markAsRepaired style
        const { ID } = req.params[0];

        // username comes from body
        const { username } = req.data;

        // 1. Get the Maintenance Request
        const reqRow = await SELECT.one.from(MaintenanceRequest)
            .where({ ID });

        if (!reqRow) return req.error(404, 'Maintenance Request not found');

        // 2. Only assign when status = OPEN
        if (reqRow.status !== 'OPEN') {
            return req.error(400, 'Cannot assign technician unless status is OPEN');
        }

        // 3. Get technician by username
        const techRow = await SELECT.one.from(Technician)
            .where({ technicianUserName: username });

        if (!techRow) return req.error(404, 'Technician not found');

        // 4. Update workload (+1)
        await UPDATE(Technician)
            .set({ workload: techRow.workload + 1 })
            .where({ ID: techRow.ID });

        // 5. Assign technician + change status to INPROGRESS
        await UPDATE(MaintenanceRequest)
            .set({
                technician_ID: techRow.ID,
                status: 'INPROGRESS'
            })
            .where({ ID });

        return {
            message: `Technician ${techRow.name} assigned successfully`,
            newStatus: 'INPROGRESS'
        };
    });

    srv.on('raisetTicket', async (req) => {

        const { id } = req.params[0];       // TechnicalObject ID
        const { title, desc, priority } = req.data;
        console.log(id);
        // Check if TechnicalObject exists and is inactive
        const tech = await SELECT.one.from(TechnicalObject)
            .where({ id });

        if (!tech) return req.error(404, 'TechnicalObject not found');

        if (tech.systemstatus !== 'INACTIVE') {
            return req.error(400, 'Maintenance can only be raised for INACTIVE objects');
        }

        // Create new Maintenance Request linked to the TechnicalObject
        const newReq = await INSERT.into(MaintenanceRequest).entries({
            technicalobject_id: id,
            title: title,
            description: desc,
            priority: priority,
            status: 'OPEN'
        });

        return newReq;
    });
};