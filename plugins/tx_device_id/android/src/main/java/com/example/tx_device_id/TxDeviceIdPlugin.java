package com.example.tx_device_id;

import android.content.Context;
import androidx.annotation.NonNull;

import com.bun.miitmdid.core.JLibrary;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** TxDeviceIdPlugin */
public class TxDeviceIdPlugin implements FlutterPlugin, MethodCallHandler {
  private final static TxDeviceIdPlugin plugin = new TxDeviceIdPlugin();
  private final static MsaHelper helper = new MsaHelper();
  private MethodChannel channel;

  private void initializePlugin(Context context, BinaryMessenger messenger) {
      this.channel = new MethodChannel(messenger, "tx_device_id");
      channel.setMethodCallHandler(this);
      try {
          JLibrary.InitEntry(context);
          helper.getDeviceIds(context);
      } catch (Exception e) {
          e.printStackTrace();
      }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    initializePlugin(flutterPluginBinding.getApplicationContext(), flutterPluginBinding.getBinaryMessenger());
  }

  
  public static void registerWith(Registrar registrar) {
    plugin.initializePlugin(registrar.context(), registrar.messenger());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
          result.success("Android " + android.os.Build.VERSION.RELEASE);
          break;
      case "isSupport":
          result.success(helper.isSupport());
          return;
      case "getOAID":
          result.success(helper.getOAID());
          return;
      default:
          result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
