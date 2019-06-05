package com.xzkj.flutter_paypal;


import android.util.Log;

import com.xzkj.flutter_paypal.handler.TPaypalHandler;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * FlutterPaypalPlugin
 */
public class FlutterPaypalPlugin implements MethodCallHandler {


    private String Tag = "Pay";
    private Registrar mContext;

    private FlutterPaypalPlugin(Registrar mContext) {
        this.mContext = mContext;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.xzkj/flutter_paypal");
        channel.setMethodCallHandler(new FlutterPaypalPlugin(registrar));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("registerPayPal")) {
            TPaypalHandler.instance(mContext).register();
            Tag = "Pay";
            Log.e(Tag,"registerPayPal");
        } else if (call.method.equals("sendPayPal")) {
            String moneys = call.argument("moneys");
            String currentcy = call.argument("currentcy");
            String shotDesc = call.argument("shotDesc");
            TPaypalHandler.instance(mContext).pay(moneys,currentcy,shotDesc);
            Log.e(Tag,"sendPayPal");
        } else if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
            Log.e(Tag,"getPlatformVersion");
        } else {
            result.notImplemented();
            Log.e(Tag,"notImplemented");
        }
    }
}
