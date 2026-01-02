sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("zentraui.controller.MaintenanceList", {
        onInit() {

        },
        onListItemPressed: function (oEvent) {
            const oItem = oEvent.getSource();
            const oCtx = oItem.getBindingContext();
            const sPath = oCtx.getPath();

            this.getOwnerComponent()
                .getRouter()
                .navTo("MaintenanceObjectPage", {
                    path: encodeURIComponent(sPath)
                });

        }

    });
});
