package com.littlefishapp.littlefish_smartpos_plugin;

import com.pax.poslink.CommSetting;
import com.pax.poslink.POSLinkCommon;
import com.pax.poslink.PaymentRequest;
import com.pax.poslink.PaymentResponse;
import com.pax.poslink.PosLink;
import com.pax.poslink.ProcessTransResult;
import com.pax.poslink.entity.MultiMerchant;

public class A920ProHandler extends  SmartPOSDevice {

    PosLink posLink;

    @Override
    public void initialize(String merchantId) {
        super.initialize(merchantId);

        if (posLink == null) {
            posLink = new PosLink(context);
        }

        final CommSetting settings = new CommSetting();
        settings.setType(CommSetting.USB);
        settings.setTimeOut("20000");
        settings
                .setEnableProxy(false);

        posLink.SetCommSetting(settings);
    }

    @Override
    public Object makePayment(String referenceNumber, String transactionType, double amount, String tenderType) throws Exception {
        super.makePayment(referenceNumber, transactionType, amount, tenderType);
        if (posLink == null) {
            throw new Exception("POS has not been initialized");
        }

        POSLinkThreadPool.getInstance().runInSingleThread(() -> {

            PosLink link = new PosLink(this.context);


            final CommSetting settings = new CommSetting();
            settings.setType(CommSetting.AIDL);
            settings.setTimeOut("20000");
            settings
                    .setEnableProxy(false);


            Boolean isSetConfig = link.SetCommSetting(settings);
            CommSetting s2 = link.GetCommSetting();

            link.PaymentRequest = new PaymentRequest();

            //ToDo: this should be passed and converted.
            link.PaymentRequest.TenderType = POSLinkCommon.PAX_TENDER_CREDIT;
            link.PaymentRequest.TransType = link.PaymentRequest.ParseTransType("SALE");
            link.PaymentRequest.MultiMerchant = new MultiMerchant();
            link.PaymentRequest.MultiMerchant.Id = merchantId;
            link.PaymentRequest.ECRRefNum = referenceNumber;
            link.BatchRequest = null;
            link.ManageRequest = null;
//        posLink.PaymentRequest.Amount  = amount.ToString();

//            The ProcessTransResult response tells the caller if the POSLink library was properly processed and is not to be confused
//            with the PaymentResponse, ManageResponse, BatchResponse or ReportResponse. The ProcessTransResult only reports whether
//            or not POSLink library processed properly, timed out or resulted in an error.

            final ProcessTransResult result = link.ProcessTrans();
            PaymentResponse res = link.PaymentResponse;

            int c = 22;

        });


        //ToDo: we need to handle the result and determine if it was successful or not and then send back to the simplified client.
        //ToDo: we need to handle the result and determine if it was successful or not and then send back to the simplified client.

        return null;
    }

    @Override
    public Object voidPayment(String originalReference, String referenceNumber, String transactionType, double amount, String tenderType) throws Exception {
        super.voidPayment(originalReference, referenceNumber, transactionType, amount, tenderType);


        if(posLink == null) {
            throw new Exception("POS has not been initialized");
        }


        return null;
    }
}
