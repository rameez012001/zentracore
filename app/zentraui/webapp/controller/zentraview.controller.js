sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("zentraui.controller.zentraview", {
        onInit() {
            const oModel = this.getOwnerComponent().getModel();
            this.getView().setModel(oModel);
        }
    });
});
