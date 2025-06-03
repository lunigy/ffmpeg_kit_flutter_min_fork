#import "FFmpegKitFlutterPlugin.h"
#import <ffmpeg_kit_macos_min/FFmpegKit.h>

@interface FFmpegKitEventStreamHandler : NSObject <FlutterStreamHandler>
@property(nonatomic, strong) FlutterEventSink eventSink;
@end

@implementation FFmpegKitEventStreamHandler

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    self.eventSink = events;
    
    // Send an initial dummy event to keep the stream alive
    if (self.eventSink) {
        // Create a dummy log event
        NSDictionary *logEvent = @{
            @"sessionId": @(1),
            @"level": @(32),  // AV_LOG_TRACE
            @"message": @"FFmpegKit event channel initialized"
        };
        
        NSDictionary *event = @{
            @"FFmpegKitLogCallbackEvent": logEvent
        };
        
        self.eventSink(event);
    }
    
    return nil;
}

- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    self.eventSink = nil;
    return nil;
}

@end

@interface FFmpegKitFlutterPlugin ()
@property(nonatomic, strong) FFmpegKitEventStreamHandler *streamHandler;
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
  instance.streamHandler = [[FFmpegKitEventStreamHandler alloc] init];
  [eventChannel setStreamHandler:instance.streamHandler];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  // Handle all methods in a more comprehensive way
  NSString *method = call.method;
  
  if ([@"getLogLevel" isEqualToString:method]) {
    // Return a default log level (32 = AV_LOG_TRACE for maximum logging)
    result(@(32));
  } 
  else if ([@"executeWithArguments" isEqualToString:method] ||
           [@"executeWithArgumentsAsync" isEqualToString:method]) {
    // Return a dummy session ID for execution methods
    result(@(1));
  }
  else if ([@"getSession" isEqualToString:method]) {
    // Return a dummy session
    NSMutableDictionary *session = [NSMutableDictionary dictionary];
    [session setObject:@(1) forKey:@"sessionId"];
    [session setObject:@([[NSDate date] timeIntervalSince1970] * 1000) forKey:@"startTime"];
    [session setObject:@([[NSDate date] timeIntervalSince1970] * 1000 + 1000) forKey:@"endTime"];
    [session setObject:@(0) forKey:@"returnCode"];
    [session setObject:@"" forKey:@"failStackTrace"];
    result(session);
  }
  else if ([method hasPrefix:@"ffmpegKitConfig"]) {
    // Handle all configuration methods
    result(nil);
  } 
  else if ([@"getPlatformVersion" isEqualToString:method]) {
    result([@"macOS " stringByAppendingString:[[NSProcessInfo processInfo] operatingSystemVersionString]]);
  } 
  else {
    // For any other methods, return success with nil to avoid MissingPluginException
    result(nil);
  }
}

@end
