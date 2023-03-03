package com.littlefishapp.littlefish_smartpos_plugin;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

/** LittlefishSmartposPlugin */
public class LittlefishSmartposPlugin implements FlutterPlugin, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Activity activity;

  private POSHandler methodCallHandler;

  private FlutterPluginBinding flutterPluginBinding;

  private BinaryMessenger messenger;

  private  Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.context = flutterPluginBinding.getApplicationContext();

    this.flutterPluginBinding = flutterPluginBinding;
    this.messenger = flutterPluginBinding.getBinaryMessenger();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();

    channel = new MethodChannel(messenger, "littlefish_smartpos_plugin");

    if (this.methodCallHandler == null) {
      this.methodCallHandler = new POSHandler(activity, context);
    }

    channel.setMethodCallHandler(this.methodCallHandler);


    if(this.methodCallHandler != null) {
      this.methodCallHandler.activity = binding.getActivity();
    }
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }
}
