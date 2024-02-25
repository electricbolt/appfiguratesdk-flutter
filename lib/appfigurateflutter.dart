// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:collection';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppfigurateLibrary {
  /// You must invoke [AppfigurateLibrary.initialize] method as soon as
  /// practicable from the app's [main] method. You must not invoke any other
  /// methods exported by the Appfigurate Flutter Plugin before this method
  /// completes. e.g.
  ///
  /// ```dart
  /// void main() async {
  ///   await AppfigurateLibrary.initialize();
  ///   runApp(const MyApp());
  /// }
  /// ```

  static Future<void> initialize() async {
    if (!_libraryInitialized) {
      WidgetsFlutterBinding.ensureInitialized();
      _channel = const MethodChannel('appfiguratelibrary')
        ..setMethodCallHandler((MethodCall call) async {
          if (call.method == 'configurationupdated') {
            await _read();
            for (var updatedListener in _updatedListeners) {
              if (call.arguments != null) {
                updatedListener(call.arguments as String);
              } else {
                updatedListener(null);
              }
            }
            if (_instance != null) {
              if (call.arguments != null) {
                _instance!.actionExecuted(call.arguments as String);
              }
            }
          }
        });
      await _read();
      _libraryInitialized = true;
    }
  }

  static Future<void> _read() async {
    Map result = await _channel.invokeMethod("read");
    _cachedVersion = result['version'] as String;
    _cachedDescription = result['description'] as String;
    _cachedModifications = result['modifications'] as String;
    _cachedConfiguration = result['configuration'] as Map;
  }
}

bool _libraryInitialized = false;
APLNativeConfiguration? _instance;
final Set<APLConfigurationUpdatedListener> _updatedListeners = HashSet();
late MethodChannel _channel;
late Map _cachedConfiguration;
late String _cachedVersion;
late String _cachedDescription;
late String _cachedModifications;

/// Subclass [APLNativeConfiguration] to provide read only introspection of the
/// properties implemented in the native app's [APLConfiguration] (iOS) /
/// [nz.co.electricbolt.appfiguratelibrary.Configuration] (Android) subclass.
///
/// For any properties that you with to introspect in Dart, implement as
/// follows depending on the type declared in Obj-C / Swift / Java / Kotlin:
///
/// ```
/// -- Boolean --
///
/// Dart:  bool get propertyName => nativeBool('propertyName');
///
/// Obj-C:  BOOL_PROPERTY(propertyName, ...);
/// Swift:  @BoolProperty(...) var propertyName: Bool
/// Java:   @BooleanProperty(...) boolean propertyName;
/// Kotlin: @BooleanProperty(...) var propertyName = false
///
/// -- String / Encrypted String --
///
/// Dart:  String get propertyName => nativeString('propertyName');
///
/// Obj-C:  STRING_PROPERTY_EDIT(propertyName, ...);
///         STRING_PROPERTY_LIST(propertyName, ...);
///         STRING_PROPERTY_LIST_EDIT(propertyName, ...);
///         ENCRYPTED_STRING_PROPERTY_LIST_EDIT(propertyName, ...);
/// Swift:  @StringPropertyEdit(...) var propertyName: String
///         @StringPropertyList(...) var propertyName: String
///         @StringPropertyListEdit(...) var propertyName: String
///         @EncryptedStringPropertyListEdit(...) var propertyName: String
/// Java:   @StringPropertyEdit(...) String propertyName;
///         @StringPropertyList(...) String propertyName;
///         @StringPropertyListEdit(...) String propertyName;
///         @EncryptedStringPropertyListEdit(...) String propertyName;
/// Kotlin: @StringPropertyEdit(...) var propertyName: String? = null
///         @StringPropertyList(...) var propertyName: String? = null
///         @StringPropertyListEdit(...) var propertyName: String? = null
///         @EncryptedStringPropertyListEdit(...) var propertyName: String? = null
///
/// -- Integer --
///
/// Dart:  int get propertyName => nativeInt('propertyName');
///
/// Obj-C:  INT_PROPERTY_SLIDER(propertyName, ...);
///         INT_PROPERTY_EDIT(propertyName, ...);
///         INT_PROPERTY_LIST(propertyName, ...);
///         INT_PROPERTY_LIST_EDIT(propertyName ...);
/// Swift:  @IntPropertySlider(...) var propertyName: Int
///         @IntPropertyEdit(...) var propertyName: Int
///         @IntPropertyList(...) var propertyName: Int
///         @IntPropertyListEdit(...) var propertyName: Int
/// Java:   @IntPropertySlider(...) int propertyName;
///         @IntPropertyEdit(...) int propertyName;
///         @IntPropertyList(...) int propertyName;
///         @IntPropertyListEdit(...) int propertyName;
/// Kotlin: @IntPropertySlider(...) var propertyName = 0
///         @IntPropertyEdit(...) var propertyName = 0
///         @IntPropertyList(...) var propertyName = 0
///         @IntPropertyListEdit(...) var propertyName = 0
///
/// -- Float / Double --
///
/// Dart:  double get propertyName => nativeDouble('propertyName');
///
/// Obj-C:  FLOAT_PROPERTY_SLIDER(propertyName, ...);
///         FLOAT_PROPERTY_EDIT(propertyName, ...);
///         FLOAT_PROPERTY_LIST(propertyName, ...);
///         FLOAT_PROPERTY_LIST_EDIT(propertyName, ...);
///         DOUBLE_PROPERTY_SLIDER(propertyName, ...);
///         DOUBLE_PROPERTY_EDIT(propertyName, ...);
///         DOUBLE_PROPERTY_LIST(propertyName, ...);
///         DOUBLE_PROPERTY_LIST_EDIT(propertyName, ...);
/// Swift:  @FloatPropertySlider(...) var propertyName: Float
///         @FloatPropertyEdit(...) var propertyName: Float
///         @FloatPropertyList(...) var propertyName: Float
///         @FloatPropertyListEdit(...) var propertyName: Float
///         @DoublePropertySlider(...) var propertyName: Double
///         @DoublePropertyEdit(...) var propertyName: Double
///         @DoublePropertyList(...) var propertyName: Double
///         @DoublePropertyListEdit(...) var propertyName: Double
/// Java:   @FloatPropertySlider(...) float propertyName;
///         @FloatPropertyEdit(...) float propertyName;
///         @FloatPropertyList(...) float propertyName;
///         @FloatPropertyListEdit(...) float propertyName;
///         @DoublePropertySlider(...) double propertyName;
///         @DoublePropertyEdit(...) double propertyName;
///         @DoublePropertyList(...) double propertyName;
///         @DoublePropertyListEdit(...) double propertyName;
/// Kotlin: @FloatPropertySlider(...) var propertyName = 0.0f
///         @FloatPropertyEdit(...) var propertyName = 0.0f
///         @FloatPropertyList(...) var propertyName = 0.0f
///         @FloatPropertyListEdit(...) var propertyName = 0.0f
///         @DoublePropertySlider(...) var propertyName = 0.0
///         @DoublePropertyEdit(...) var propertyName = 0.0
///         @DoublePropertyList(...) var propertyName = 0.0
///         @DoublePropertyListEdit(...) var propertyName = 0.0
/// ```

abstract class APLNativeConfiguration {
  static APLNativeConfiguration sharedConfiguration() => _instance!;

  APLNativeConfiguration() {
    assert(_libraryInitialized);
    _instance = this;
  }

  /// Introspect the native app's [APLConfiguration] (iOS) /
  /// [nz.co.electricbolt.appfiguratelibrary.Configuration] (Android) subclass
  /// for the `NSString` (Obj-C), `String` (Swift, Java, Kotlin) with the
  /// [propertyName] specified.

  String nativeString(String propertyName) {
    Object? object = _cachedConfiguration[propertyName];
    if (object != null && object is String) {
      return object;
    }
    return '';
  }

  /// Introspect the native app's [APLConfiguration] (iOS) /
  /// [nz.co.electricbolt.appfiguratelibrary.Configuration] (Android) subclass
  /// for the `NSInteger` (Obj-C), `Int` (Swift, Kotlin), `int` (Java) with the
  /// [propertyName] specified.

  int nativeInt(String propertyName) {
    Object? object = _cachedConfiguration[propertyName];
    if (object != null && object is int) {
      return object;
    }
    return 0;
  }

  /// Introspect the native app's [APLConfiguration] (iOS) /
  /// [nz.co.electricbolt.appfiguratelibrary.Configuration] (Android) subclass
  /// for the `BOOL` (Obj-C), `Bool` (Swift), `boolean` (Java),
  /// `Boolean` (Kotlin) with the [propertyName] specified.

  bool nativeBool(String propertyName) {
    Object? object = _cachedConfiguration[propertyName];
    if (object != null && object is bool) {
      return object;
    }
    return false;
  }

  /// Introspect the native app's [APLConfiguration] (iOS) /
  /// [nz.co.electricbolt.appfiguratelibrary.Configuration] (Android) subclass
  /// for the `float` / `double` (Obj-C, Java), `Float` / `Double`
  /// (Swift, Kotlin) with the [propertyName] specified.

  double nativeDouble(String propertyName) {
    Object? object = _cachedConfiguration[propertyName];
    if (object != null && object is double) {
      return object;
    }
    return 0.0;
  }

  /// Returns the textual representation of all properties.
  ///
  /// Property names are shortened to camel case and appended with the value,
  /// except for `NSString` (Obj-C) / `String` (Swift, Java, Kotlin) properties
  /// which omit the property name.
  ///
  /// e.g. `debugLog=5` would be returned as `DL=5`.

  String description() {
    return _cachedDescription;
  }

  /// Returns the textual representation of all properties that have non default
  /// (overridden) values.
  ///
  /// Property names are shortened to camel case and appended with the
  /// non default value, except for `NSString` (Obj-C)  / `String` (Swift, Java,
  /// Kotlin) properties which omit the property name.
  ///
  /// e.g. `userInteractionTimeout=60.0` would be returned as `UIT=60.0`.

  String modifications() {
    return _cachedModifications;
  }

  /// Called when an [action] is executed.

  void actionExecuted(String action) {}
}

//------------------------------------------------------------------------------

/// Returns the version of the Appfigurate library in the format
/// `major.minor.patch`. e.g. `5.1.2`

String APLVersion() {
  assert(_libraryInitialized);
  return _cachedVersion;
}

//------------------------------------------------------------------------------

typedef APLConfigurationUpdatedListener = void Function(String? action);

/// Registers a callback that will be invoked every time Appfigurate has updated
/// the configuration of the app. e.g.
///
/// ```dart
/// @override
/// void initState() {
///   super.initState();
///   APLAddConfigurationUpdatedListener(configurationUpdated);
/// }
///
/// @override
/// void dispose() {
///   APLRemoveConfigurationUpdatedListener(configurationUpdated);
///   super.dispose();
/// }
///
/// void configurationUpdated(String? action) {
///     setState(() {});
/// }
/// ```
///
/// See also [APLRemoveConfigurationUpdatedListener].

void APLAddConfigurationUpdatedListener(
    APLConfigurationUpdatedListener listener) {
  assert(_libraryInitialized);
  _updatedListeners.add(listener);
}

//------------------------------------------------------------------------------

/// Unregisters a callback that was previously registered via
/// [APLAddConfigurationUpdatedListener].

void APLRemoveConfigurationUpdatedListener(
    APLConfigurationUpdatedListener listener) {
  assert(_libraryInitialized);
  _updatedListeners.remove(listener);
}

//------------------------------------------------------------------------------

/// When true, Appfigurate library debugging messages will be output to the
/// console. The default is false.
///
/// It is best practice to distribute applications via TestFlight / App Store /
/// Google Play with logging set to false. See also 'APLLogging' key in the
/// (iOS, watchOS) Info.plist file or (Android) meta-data in AndroidManifest.xml
/// file.

Future<void> APLSetLogging(bool logging) async {
  assert(_libraryInitialized);
  await _channel.invokeMethod('setlogging', logging);
}

//------------------------------------------------------------------------------

/// Saves the configuration persisted in the Keychain (iOS) / SharedPreferences
/// (Android) into temporary storage.
///
/// Some apps have functionality to erase the Keychain / SharedPreferences to
/// reset apps back to *factory defaults*, which has the side effect of
/// *removing* any Appfigurate configuration persisted in the Keychain / shared
/// preferences.
///
/// See also [APLRestoreConfiguration].

Future<void> APLSaveConfiguration() async {
  assert(_libraryInitialized);
  await _channel.invokeMethod('saveconfiguration');
}

//------------------------------------------------------------------------------

/// Restores the configuration from temporary storage back into the Keychain
/// (iOS) / SharedPreferences (Android).
///
/// See also [APLSaveConfiguration]

Future<void> APLRestoreConfiguration() async {
  assert(_libraryInitialized);
  await _channel.invokeMethod('restoreconfiguration');
}

//------------------------------------------------------------------------------

/// Overlays an 'overridden configuration' label on top of the provided [child]
/// widget.
///
/// The widget is positioned on the left hand side of the parent widget and
/// text is rotated 270° (displayed in a vertical orientation).
///
/// Uses the [APLNativeConfiguration.modifications] method to compute the labels
/// text. See appfiguratesdk-flutter ‣ example ‣ lib ‣ main.dart ‣
/// [build(BuildContext)] for usage.

class APLConfigurationLabel extends StatefulWidget {
  final Widget child;

  APLConfigurationLabel({Key? key, required this.child}) : super(key: key) {
    assert(_libraryInitialized);
  }

  @override
  State<StatefulWidget> createState() {
    return _APLConfigurationLabelState();
  }
}

class _APLConfigurationLabelState extends State<APLConfigurationLabel> {
  @override
  void initState() {
    super.initState();
    _configurationUpdated(null);
    _updatedListeners.add(_configurationUpdated);
  }

  @override
  void dispose() {
    _updatedListeners.remove(_configurationUpdated);
    super.dispose();
  }

  void _configurationUpdated(String? action) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Stack(textDirection: TextDirection.ltr, children: [
      widget.child,
      _cachedModifications.isEmpty
          ? Container()
          : Container(
              padding: EdgeInsets.only(
                  left: media.padding.left,
                  right: media.padding.left,
                  top: 32.0,
                  bottom: 32.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
                          decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            _cachedModifications,
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )))))
    ]);
  }
}
