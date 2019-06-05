package com.xzkj.flutter_paypal.handler;

import android.text.TextUtils;

import io.flutter.plugin.common.PluginRegistry;

public class TPaypalHandler{



    private PluginRegistry.Registrar mActivity;

    private static TPaypalHandler payPalHelper;

    private TPaypalHandler(PluginRegistry.Registrar context) {
        mActivity = context;
    }

    public static TPaypalHandler instance(PluginRegistry.Registrar context) {
        if (payPalHelper == null) {
            payPalHelper = new TPaypalHandler(context);
        }
        return payPalHelper;
    }

    public void register() {
        PayPalHelper.getInstance().startPayPalService(mActivity.context());
    }

    public void pay(String moneys, String currentcy, String shotDesc) {
        //支付
        PayPalHelper.getInstance().doPayPalPay(mActivity.activity(), TextUtils.isEmpty(moneys) ? "0.01" : moneys,currentcy,shotDesc);
    }
}
