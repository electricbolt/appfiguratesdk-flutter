// AppfigurateFlutterPlugin.m
// Appfigurate™ Copyright© 2022-2025; Electric Bolt Limited.

#import "AppfigurateFlutterPlugin.h"
@import AppfigurateLibrary;

@interface AppfigurateFlutterPlugin () <APLConfigurationUpdated> {
    FlutterMethodChannel* channel;
}

@end;

@implementation AppfigurateFlutterPlugin

#pragma mark AppfigurateFlutterPlugin

+ (AppfigurateFlutterPlugin*) sharedInstance {
    static AppfigurateFlutterPlugin* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AppfigurateFlutterPlugin new];
    });
    return instance;
}

- (instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (void) registerWithRegistrar: (nonnull NSObject<FlutterPluginRegistrar>*) registrar {
    APLDEBUG(@"Plugin: +registerWithRegistrar:");
    [[AppfigurateFlutterPlugin sharedInstance] registerWithRegistrar: registrar];
}

- (void) registerWithRegistrar: (NSObject<FlutterPluginRegistrar>*) registrar {
    APLDEBUG(@"Plugin: registerWithRegistrar:");
    channel = [FlutterMethodChannel methodChannelWithName: @"appfiguratelibrary" binaryMessenger: [registrar messenger]];
    [registrar addMethodCallDelegate: [AppfigurateFlutterPlugin sharedInstance] channel: channel];
    [registrar addApplicationDelegate: self];
    [registrar addSceneDelegate: self];
}

#pragma mark FlutterPlugin

- (BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions {
    APLDEBUG(@"Plugin: application:didFinishLaunchingWithOptions:");
    APLApplicationDidFinishLaunchingWithOptions(launchOptions);
    APLAddConfigurationUpdatedListener(self);
    return YES;
}

/// For apps not using UIApplicationSceneManifest, whilst app is running.

- (BOOL) application:(UIApplication*) application openURL: (NSURL*) url options: (NSDictionary<UIApplicationOpenURLOptionsKey, id>*) options {
    APLDEBUG(@"Plugin: application:openURL:options:");
    return APLApplicationOpenURL(url);
}

/// For apps using UIApplicationSceneManifest, whilst app is running.

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts {
    APLDEBUG(@"Plugin: openURLContexts:");
    NSURL* url = [[[URLContexts allObjects] firstObject] URL];
    APLApplicationOpenURL(url);
}

/// For apps using UIApplicationSceneManifest, at app startup.

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    APLDEBUG(@"Plugin: scene:willContentToSession:options:");
    NSURL* url = [[[connectionOptions.URLContexts allObjects] firstObject] URL];
    APLApplicationOpenURL(url);
}

- (void) handleMethodCall: (FlutterMethodCall*) call result: (FlutterResult) result {
    if ([call.method isEqualToString: @"read"]) {
        APLDEBUG(@"Plugin: read");
        result(@{@"version": APLVersion(),
                 @"description": [[APLConfiguration sharedConfiguration] description],
                 @"modifications": [[APLConfiguration sharedConfiguration] modifications],
                 @"configuration": [[APLConfiguration sharedConfiguration] dictionaryFromConfiguration]
               });
    } else if ([call.method isEqualToString: @"saveconfiguration"]) {
        APLDEBUG(@"Plugin: saveconfiguration");
        APLSaveConfiguration();
        result(nil);
    } else if ([call.method isEqualToString: @"restoreconfiguration"]) {
        APLDEBUG(@"Plugin: restoreconfiguration");
        APLRestoreConfiguration();
        result(nil);
    } else if ([call.method isEqualToString: @"setlogging"]) {
        APLDEBUG(@"Plugin: setlogging");
        APLSetLogging((NSNumber*) call.arguments);
        result(nil);
    } else {
        APLDEBUG(@"Plugin: flutter method %@ not implemented in Objective-C", call.method);
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark APLConfigurationUpdated

- (void) configurationUpdated: (NSNotification* _Nullable) notification {
    APLDEBUG(@"Plugin: configurationUpdated");
    [channel invokeMethod: @"configurationupdated" arguments: notification.userInfo[APLConfigurationUpdatedAction]];
}

@end
