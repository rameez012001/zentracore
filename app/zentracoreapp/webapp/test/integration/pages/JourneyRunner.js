sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"zentracoreapp/test/integration/pages/PersonList",
	"zentracoreapp/test/integration/pages/PersonObjectPage"
], function (JourneyRunner, PersonList, PersonObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('zentracoreapp') + '/test/flp.html#app-preview',
        pages: {
			onThePersonList: PersonList,
			onThePersonObjectPage: PersonObjectPage
        },
        async: true
    });

    return runner;
});

