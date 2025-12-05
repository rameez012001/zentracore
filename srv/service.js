const cds = require('@sap/cds');

module.exports = async function (srv) {
    const { MaintenanceRequest, Technician, Equipment } = srv.entities;
    const { selfAssign, fixed } = MaintenanceRequest.actions;
    srv.after('CREATE', MaintenanceRequest, async (data, req) => {
        if (data.equipment_id) {
            await UPDATE('Equipment')
                .set({ status: 'Inactive' })
                .where({ id: data.equipment_id });
        }
    });

    srv.on(selfAssign, async req => {
        const { technician_id } = req.data;
        const { id } = req.params[0];
        console.log(`${id} and ${technician_id}`)
        console.log('clicked')
        await UPDATE(MaintenanceRequest)
            .set({
                assignedTo_id: technician_id,
                status: 'InProgress'
            })
            .where({ id });

        const tech = await SELECT.one.from(Technician)
            .columns('workload')
            .where({ id: technician_id });

        const newLoad = (tech?.workload ?? 0) + 1;

        await UPDATE(Technician)
            .set({ workload: newLoad })
            .where({ id: technician_id });

        return;
    });

    //   Fixed

    srv.on(fixed, async req => {
        const { id } = req.params[0];

        const reqRow = await SELECT.one.from(MaintenanceRequest)
            .columns('assignedTo_id', 'equipment_id')
            .where({ id });

        const technician_id = reqRow.assignedTo_id;

        await UPDATE(MaintenanceRequest)
            .set({
                status: 'Completed'
            })
            .where({ id });

        await UPDATE(Equipment)
            .set({ status: 'Active' })
            .where({ id: reqRow.equipment_id });

        const tech = await SELECT.one.from(Technician)
            .columns('workload')
            .where({ id: technician_id });

        const newLoad = (tech?.workload ?? 0) - 1;

        await UPDATE(Technician)
            .set({ workload: newLoad })
            .where({ id: technician_id });
    });

};