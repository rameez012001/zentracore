sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"zentratechnician/test/integration/pages/TechnicianList",
	"zentratechnician/test/integration/pages/TechnicianObjectPage"
], function (JourneyRunner, TechnicianList, TechnicianObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('zentratechnician') + '/test/flp.html#app-preview',
        pages: {
			onTheTechnicianList: TechnicianList,
			onTheTechnicianObjectPage: TechnicianObjectPage
        },
        async: true
    });

    return runner;
});

