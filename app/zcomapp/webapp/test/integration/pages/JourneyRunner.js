sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"zcomapp/test/integration/pages/PersonList",
	"zcomapp/test/integration/pages/PersonObjectPage"
], function (JourneyRunner, PersonList, PersonObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('zcomapp') + '/test/flp.html#app-preview',
        pages: {
			onThePersonList: PersonList,
			onThePersonObjectPage: PersonObjectPage
        },
        async: true
    });

    return runner;
});

