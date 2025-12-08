const cds = require('@sap/cds');

module.exports = async function (srv) {
    const { TechnicalObject, MaintenanceRequest } = srv.entities;
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

    // srv.on(getPendingRequests, async req => {
    //     return SELECT
    //         .from(MaintenanceRequest)
    //         .where({ status: ['OPEN', 'INPROGRESS'] });
    // });


};