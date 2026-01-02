sap.ui.define([
    "sap/ui/core/UIComponent",
    "zentraui/model/models",
    "sap/ui/model/json/JSONModel"
], (UIComponent, models, JSONModel) => {
    "use strict";

    return UIComponent.extend("zentraui.Component", {
        metadata: {
            manifest: "json",
            interfaces: ["sap.ui.core.IAsyncContentCreation"]
        },

        init() {
            // call the base component's init function
            UIComponent.prototype.init.apply(this, arguments);
            
            // set the device model
            this.setModel(models.createDeviceModel(), "device");

            const oDataModel = new JSONModel(
                sap.ui.require.toUrl("zentraui/model/data.json")
            );
            this.setModel(oDataModel); // default model

            // enable routing
            this.getRouter().initialize();
        }
    });
});
