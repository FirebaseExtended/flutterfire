package io.flutter.plugins.firebase_core_web;

import android.support.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FirebaseCoreWebPlugin */
public class FirebaseCoreWebPlugin implements FlutterPlugin, MethodCallHandler {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {}

  public static void registerWith(Registrar registrar) {}

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {}

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {}
}
