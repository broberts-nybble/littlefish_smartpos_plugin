package com.littlefishapp.littlefish_smartpos_plugin;

import android.app.Activity;
import android.content.Context;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;

import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;

public class POSHandler implements MethodCallHandler {

    private Handler uiThreadHandler = new Handler(Looper.getMainLooper());

    public Activity activity;

    public Context context;

    POSHandler(Activity activity, Context context) {
        this.activity = activity;
        this.context = context;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String deviceType = call.argument("deviceType");
        String merchantId = call.argument("merchantId");

        Log.w("POS Handler", "method call invoked");

        if (!call.hasArgument("deviceType")) {
            Log.w("POS Handler", "device type not provided");

            result.notImplemented();
            return;
        }

        if (!call.hasArgument("merchantId")) {
            Log.w("POS Handler", "merchant Id not provided");

            result.notImplemented();
            return;
        }


        Log.w("POSHandler", "DeviceType: " + deviceType);
        Log.w("POSHandler", "MerchantId: " + merchantId);


        SmartPOSDevice device;

        switch (deviceType) {
            case "A920PRO":
                device = new A920ProHandler();

                break;
            default:
                result.notImplemented();
                return;
        }

        device.activity = activity;
        device.context = context;

        //we now have the device, so we need to determine what action is required for this device.
        device.initialize(merchantId);

        switch (call.method) {
            case "getPlatformVersion":
                uiThreadHandler.post(() -> {

                    result.success("Android XX" + Build.VERSION.RELEASE);

                });
                return;
            case "makePayment":


                Runnable runnable = new Runnable() {
                    @Override
                    public void run() {
                        try {
                            Object r = device.makePayment(
                                    call.argument("reference"),
                                    call.argument("transactionType"),
                                    call.argument("amount"),
                                    call.argument("tenderType")
                            );
                            result.success(r);
                            return;

                        } catch (Exception e) {
                            e.printStackTrace();
                            result.error("-1", e.getMessage(), e.getStackTrace());
                        }
                    }
                };

                activity.runOnUiThread(runnable);


                return;
            case "voidPayment":
                result.success("void payment");

                return;
            default:
                result.notImplemented();
                return;
        }

    }
}
