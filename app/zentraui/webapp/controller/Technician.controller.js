sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("zentraui.controller.Technician", {
        onInit() {

        },

        onCreateRowTechnician: function (oEvent) {
            var oContext = this.byId("Technician").getBinding("items").create({
                LifecycleStatusDesc: "New"
            }),
                that = this;

            oContext.created().then(function () {
                MessageToast.show("Maintenance Request created: " + oContext.getProperty("ID"));
                oContext.setKeepAlive(true, undefined, true);
            }, function () {
                // creation canceled
                UIComponent.getRouterFor(that).navTo("MaintenanceObjectPage");
            });
            this.selectSalesOrder(oContext);
        },

        onListItemPressed: function (oEvent) {

        }

    });
});
