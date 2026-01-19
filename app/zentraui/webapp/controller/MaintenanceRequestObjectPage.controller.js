sap.ui.define([
    "sap/ui/core/mvc/Controller"
], function (Controller) {
    "use strict";

    return Controller.extend("zentraui.controller.MaintenanceRequestObjectPage", {
        onInit: function (oEvent) {

            this.getOwnerComponent()
                .getRouter()
                .getRoute("MaintenanceObjectPage")
                .attachPatternMatched(this._onMatched, this);

            this._formFragments = {};
        },

        _onMatched: function (oEvent) {
            const sId = oEvent.getParameter("arguments").id;

            this.getView().bindElement({
                path: `/MaintenanceRequest(${sId})`,
                events: {
                    change: function () {
                        this.byId("edit").setEnabled(true);
                    }.bind(this)
                }
            });

            this._showFormFragment("MaintenanceObject");
        },

        handleEditPress: function () {

            this._oMaintenanceRequest = Object.assign(
                {},
                this.getView().getBindingContext().getObject()
            );

            this._toggleButtonsAndView(true);

        },

        handleCancelPress: function () {

            //Restore the data
            this.getView().getModel().resetChanges();
            this._toggleButtonsAndView(false);

        },

        handleSavePress: function () {

            this._toggleButtonsAndView(false);

        },

        _toggleButtonsAndView: function (bEdit) {
            var oView = this.getView();

            oView.byId("edit").setVisible(!bEdit);
            oView.byId("save").setVisible(bEdit);
            oView.byId("cancel").setVisible(bEdit);

            this._showFormFragment(bEdit ? "Request" : "MaintenanceObject");
        },

        _getFormFragment: function (sFragmentName) {
            var oView = this.getView();

            if (!this._formFragments[sFragmentName]) {
                this._formFragments[sFragmentName] = sap.ui.xmlfragment(oView.getId(),
                    "zentraui.view.fragments." + sFragmentName, this);
            }

            return this._formFragments[sFragmentName];
        },

        _showFormFragment: function (sFragmentName) {
            var oPage = this.byId("page");

            oPage.removeAllContent();
            oPage.addContent(this._getFormFragment(sFragmentName));
        },

        handleAssignTechnician: function () {
            if (!this._oAssignDialog) {
                this._oAssignDialog = sap.ui.xmlfragment(
                    this.getView().getId(),
                    "zentraui.view.fragments.AssignTechnicianDialog",
                    this
                );
                this.getView().addDependent(this._oAssignDialog);
            }

            this._oAssignDialog.open();
        },

        handleAssignConfirm: function () {
            var sTechId = sap.ui.core.Fragment
                .byId(this.getView().getId(), "technicianInput")
                .getValue();

            this.getView()
                .getBindingContext()
                .setProperty("technician_ID", sTechId);

            this._oAssignDialog.close();
        },

        handleAssignCancel: function () {
            this._oAssignDialog.close();
        }


    });
});
