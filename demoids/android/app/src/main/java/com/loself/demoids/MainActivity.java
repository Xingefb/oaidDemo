package com.loself.demoids;

import android.os.Bundle;

import com.appsflyer.oaid.OaidClient;

import java.util.concurrent.TimeUnit;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "com.ids.lib/oaid";

  private String OAID;
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    MethodChannel channel = new MethodChannel(getFlutterView(), CHANNEL);
    channel.setMethodCallHandler(this::handleMethod);
    try {
      OAID = new OaidClient(this, 1, TimeUnit.SECONDS).fetch().getId();
    } catch (Error error) {

    }

  }

  private void handleMethod(MethodCall methodCall, MethodChannel.Result result) {
    switch (methodCall.method) {
      case "oaid":
        result.success(OAID);
        break;
      default:
        result.notImplemented();
    }
  }

}
