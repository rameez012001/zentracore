sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"zentraui/test/integration/pages/OrdersList",
	"zentraui/test/integration/pages/OrdersObjectPage",
	"zentraui/test/integration/pages/OrderItemsObjectPage"
], function (JourneyRunner, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('zentraui') + '/test/flp.html#app-preview',
        pages: {
			onTheOrdersList: OrdersList,
			onTheOrdersObjectPage: OrdersObjectPage,
			onTheOrderItemsObjectPage: OrderItemsObjectPage
        },
        async: true
    });

    return runner;
});

