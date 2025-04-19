/*
 * Copyright (c) 2019-2022 Taner Sener
 * Updated 2025 for compatibility with newer Flutter versions
 *
 * This file is part of FFmpegKit.
 *
 * FFmpegKit is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FFmpegKit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FFmpegKit.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:io';
import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';

/// Platform adapter class that handles compatibility with different Flutter versions
class FFmpegKitPlatformAdapter {
  /// Creates platform-specific implementations based on Flutter version
  static FFmpegKitPlatform getPlatformInstance() {
    // Return the existing platform instance, which should be compatible with modern Flutter
    return FFmpegKitPlatform.instance;
  }

  /// Checks if the current configuration is compatible with the running environment
  static bool isCompatibleWithCurrentPlatform() {
    // Check for compatibility with the current platform
    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      return true;
    }
    
    // This fork only supports platforms that the original package supported
    print('Warning: FFmpeg Kit may not be compatible with ${Platform.operatingSystem}');
    return false;
  }
}
