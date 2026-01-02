sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("zentraui.controller.MaintenanceRequestObjectPage", {
        onInit() {
            this.getOwnerComponent()
                .getRouter()
                .getRoute("MaintenanceObjectPage")
                .attachPatternMatched(this._onMatched, this);

        },
        _onMatched(oEvent) {
            const sPath = decodeURIComponent(
                oEvent.getParameter("arguments").path
            );

            this.getView().bindElement({
                path: sPath
            });
        }


    });
});