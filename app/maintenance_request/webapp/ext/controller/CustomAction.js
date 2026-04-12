sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        onTestAction: function(oEvent) {
            MessageToast.show("Custom action clicked!");
            
            var oContext = oEvent.getSource().getBindingContext();
            var sID = oContext.getProperty("ID");
            
            MessageToast.show("You clicked on ID: " + sID);
        }
    };
});