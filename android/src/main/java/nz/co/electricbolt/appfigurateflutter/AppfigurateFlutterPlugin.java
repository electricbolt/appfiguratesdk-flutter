package nz.co.electricbolt.appfigurateflutter;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import nz.co.electricbolt.appfiguratelibrary.Appfigurate;
import nz.co.electricbolt.appfiguratelibrary.Configuration;
import nz.co.electricbolt.appfiguratelibrary.Log;

public class AppfigurateFlutterPlugin implements FlutterPlugin, MethodCallHandler, Appfigurate.ConfigurationUpdated {

  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "appfiguratelibrary");
    channel.setMethodCallHandler(this);
    Appfigurate.addConfigurationUpdatedListener(this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    Appfigurate.removeConfigurationUpdatedListener(this);
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("read")) {
      Log.log("Plugin: read");
      Map<String, Object> response = new HashMap<>();
      response.put("version", Appfigurate.version());
      response.put("description", Configuration.sharedConfiguration().description());
      response.put("modifications", Configuration.sharedConfiguration().modifications());
      response.put("configuration", Configuration.sharedConfiguration()._dictionaryFromConfiguration());
      result.success(response);
    } else if (call.method.equals("saveconfiguration")) {
      Log.log("Plugin: saveconfiguration");
      Appfigurate.saveConfiguration();
      result.success(null);
    } else if (call.method.equals("restoreconfiguration")) {
      Log.log("Plugin: restoreconfiguration");
      Appfigurate.restoreConfiguration();
      result.success(null);
    } else if (call.method.equals("setlogging")) {
      Log.log("Plugin: setlogging");
      Appfigurate.setLogging((Boolean) call.arguments);
      result.success(null);
    } else {
      Log.log("Plugin: flutter method " + call.method + " not implemented in Java");
      result.notImplemented();
    }
  }

  public void configurationUpdated(String action) {
    channel.invokeMethod("configurationupdated", action);
  }

}
