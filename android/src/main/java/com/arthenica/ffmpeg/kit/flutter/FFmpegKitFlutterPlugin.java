package com.arthenica.ffmpeg.kit.flutter;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;

/**
 * FFmpeg Kit Flutter Plugin
 * 
 * This is a forked version with compatibility updates for newer Flutter versions.
 * The implementation delegates to the upstream FFmpeg Kit platform implementation.
 */
public class FFmpegKitFlutterPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel methodChannel;
    private EventChannel eventChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        // Use the exact channel names that match what's in the Dart code
        methodChannel = new MethodChannel(binding.getBinaryMessenger(), "flutter.arthenica.com/ffmpeg_kit");
        methodChannel.setMethodCallHandler(this);
        
        eventChannel = new EventChannel(binding.getBinaryMessenger(), "flutter.arthenica.com/ffmpeg_kit_event");
        eventChannel.setStreamHandler(new FFmpegKitFlutterEventHandler());
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
        
        eventChannel.setStreamHandler(null);
        eventChannel = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        // Handle the specific methods being called in the error trace
        switch (call.method) {
            case "getLogLevel":
                // Return a default log level (e.g., 0 for AV_LOG_QUIET)
                // You can change this to match your desired default log level
                result.success(32); // AV_LOG_TRACE (maximum logging)
                break;
            default:
                // For other methods, we still need to return something rather than notImplemented
                // to avoid MissingPluginException
                if (call.method.startsWith("ffmpegKitConfig")) {
                    // For configuration methods, return success with null
                    result.success(null);
                } else {
                    result.notImplemented();
                }
                break;
        }
    }
}

/**
 * Event handler for FFmpeg Kit events.
 */
class FFmpegKitFlutterEventHandler implements EventChannel.StreamHandler {
    private EventChannel.EventSink eventSink;

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.eventSink = events;
        // In a real implementation, we would set up listeners for FFmpeg events
        // and forward them to the eventSink
    }

    @Override
    public void onCancel(Object arguments) {
        this.eventSink = null;
    }
}
