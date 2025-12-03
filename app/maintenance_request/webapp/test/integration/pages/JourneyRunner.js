sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"maintenancerequest/test/integration/pages/MaintenanceRequestList",
	"maintenancerequest/test/integration/pages/MaintenanceRequestObjectPage"
], function (JourneyRunner, MaintenanceRequestList, MaintenanceRequestObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('maintenancerequest') + '/test/flp.html#app-preview',
        pages: {
			onTheMaintenanceRequestList: MaintenanceRequestList,
			onTheMaintenanceRequestObjectPage: MaintenanceRequestObjectPage
        },
        async: true
    });

    return runner;
});

