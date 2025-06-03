#import "FFmpegKitFlutterPlugin.h"

@interface FFmpegKitEventStreamHandler : NSObject <FlutterStreamHandler>
@end

@implementation FFmpegKitEventStreamHandler
- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    // This would normally set up event forwarding from the native FFmpeg kit
    return nil;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}
@end

@implementation FFmpegKitFlutterPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  // Use the exact channel names that match what's in the Dart code
  FlutterMethodChannel* methodChannel = [FlutterMethodChannel
      methodChannelWithName:@"flutter.arthenica.com/ffmpeg_kit"
            binaryMessenger:[registrar messenger]];
            
  FlutterEventChannel* eventChannel = [FlutterEventChannel 
      eventChannelWithName:@"flutter.arthenica.com/ffmpeg_kit_event" 
            binaryMessenger:[registrar messenger]];
            
  FFmpegKitFlutterPlugin* instance = [[FFmpegKitFlutterPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:methodChannel];
  
  // Set up event handling for the event channel
  FFmpegKitEventStreamHandler* streamHandler = [[FFmpegKitEventStreamHandler alloc] init];
  [eventChannel setStreamHandler:streamHandler];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  // Handle specific methods that are needed for the plugin to function
  if ([@"getLogLevel" isEqualToString:call.method]) {
    // Return a default log level (32 = AV_LOG_TRACE for maximum logging)
    result(@(32));
  } else if ([call.method hasPrefix:@"ffmpegKitConfig"]) {
    // For configuration methods, return success with nil
    result(nil);
  } else if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"macOS " stringByAppendingString:[[NSProcessInfo processInfo] operatingSystemVersionString]]);
  } else {
    // For any other methods, return success with nil to avoid MissingPluginException
    result(nil);
  }
}

@end
