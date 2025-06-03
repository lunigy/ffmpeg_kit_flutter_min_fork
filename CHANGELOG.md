# Changelog

## 6.0.6

* Enhanced fix for MissingPluginException on all platforms
* Improved event channel implementation with proactive stream initialization
* Added comprehensive method handling for executeWithArguments and getSession
* Implemented robust dummy responses for FFmpeg command execution
* Fixed session object creation and serialization

## 6.0.5

* Fixed MissingPluginException when calling plugin methods on native platforms
* Fixed incorrect channel names for method and event channels
* Properly implemented native platform handlers for required methods (getLogLevel, etc.)
* Added proper event stream handling for all platforms
* Added complete macOS implementation with appropriate method handlers
* Enhanced error handling and fallback responses for platform methods

## 6.0.4

- **Forked version with compatibility updates for newer Flutter versions**
- Updated SDK constraints to support Flutter >=3.0.0
- Updated build configurations for iOS, Android, and macOS platforms
- Improved compatibility with newer platform implementations
- Fixed issues with method signatures and platform channels
- Added additional documentation for the forked version

## 6.0.3

- Fixed the issue with no response on some methods when the concurrent method execution enabled 
- Fixed the initialization issue when FFmpegKitConfig methods are called very early
- Switching to release-6.0 of each native library

## 6.0.2

- Using release-6.0.2 native libraries
- Fixed all asynchronous event handling on Apple platforms
- Supporting separate log callbacks for FFmpeg and FFprobe sessions
- Renamed Media Information fields with the same naming convention used in FFprobe

## 6.0.1

- Switching to release-6.0.1 of each native library
- Updated exception handling on iOS
- Fixed inconsistencies on FFmpegKit.cancel call

## 6.0.0

- Using FFmpegKit Library
- Renamed package to `ffmpeg_kit_flutter_min`
