sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"zentraequipment/test/integration/pages/EquipmentList",
	"zentraequipment/test/integration/pages/EquipmentObjectPage"
], function (JourneyRunner, EquipmentList, EquipmentObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('zentraequipment') + '/test/flp.html#app-preview',
        pages: {
			onTheEquipmentList: EquipmentList,
			onTheEquipmentObjectPage: EquipmentObjectPage
        },
        async: true
    });

    return runner;
});

