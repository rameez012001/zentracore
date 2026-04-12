sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/ColumnListItem",
    "sap/m/Input"
], (Controller, JSONModel, ColumnListItem, Input) => {
    "use strict";

    return Controller.extend("zentraui.controller.MaintenanceList", {
        onInit: function () {
            this.oUIModel = new JSONModel({
                oContext: null,
                iMessages: 0
            });
            this.getView().setModel(this.oUIModel, "MaintenanceRequest");
        },
        onSaveReq: function () {
            this.getView()
                .getModel()
                .submitBatch("maintenanceBatch");
        },
        onListItemPressed: function (oEvent) {
            const oItem = oEvent.getSource();
            const oCtx = oItem.getBindingContext();
            const sId = oCtx.getProperty("ID");

            this.getOwnerComponent()
                .getRouter()
                .navTo("MaintenanceObjectPage", { id: sId });

        },
        onCreateMaintenanceRequest: function (oEvent) {
            const oTable = this.byId("MaintenanceRequest");

            const oBinding = oTable.getBinding("items");

            oBinding.create({
                title: "",
                description: "",
                priority: "LOW",
                status: "OPEN"
            });

        },

        formatStatusState: function (sStatus) {
            switch (sStatus.toUpperCase()) {
                case "OPEN":
                    return "Error";
                case "INPROGRESS":
                    return "Warning";
                case "FIXED":
                    return "Success";
                default:
                    return "None";
            }
        },
        formatPriorityState: function (sStatus) {
            switch (sStatus.toUpperCase()) {
                case "HIGH":
                    return "Error";
                case "MID":
                    return "Warning";
                case "LOW":
                    return "None";
                default:
                    return "Success";
            }
        },
        onBeforeExport: function (oEvt) {
            const mExcelSettings = oEvt.getParameter("exportSettings");
            // GW export
            if (mExcelSettings.url) {
                return;
            }
            // For UI5 Client Export --> The settings contains sap.ui.export.SpreadSheet relevant settings that be used to modify the output of excel

            // Disable Worker as Mockserver is used in Demokit sample --> Do not use this for real applications!
            mExcelSettings.worker = false;
        },
        onExit: function () {
            this._oMockServer.destroy();
        }


    });
});
