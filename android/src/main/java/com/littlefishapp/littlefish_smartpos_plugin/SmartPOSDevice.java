package com.littlefishapp.littlefish_smartpos_plugin;

import android.app.Activity;
import android.content.Context;

public abstract class SmartPOSDevice {

    String merchantId;

    Context context;

    Activity activity;

    public void initialize(String merchantId) {
        this.merchantId = merchantId;
    }

    public Object makePayment(String referenceNumber, String transactionType, double amount, String tenderType) throws Exception {

        return null;
    }

    public Object voidPayment(String originalReference, String referenceNumber, String transactionType, double amount, String tenderType) throws Exception {

        return null;
    }
}
