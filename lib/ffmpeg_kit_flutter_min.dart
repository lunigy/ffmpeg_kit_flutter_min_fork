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

/// This is a forked version of ffmpeg_kit_flutter_min with compatibility 
/// updates for newer Flutter versions.
library ffmpeg_kit_flutter_min;

// Re-export all the main classes from the original package
export 'ffmpeg_kit.dart';
export 'ffmpeg_kit_config.dart';
export 'ffmpeg_session.dart';
export 'ffprobe_kit.dart';
export 'ffprobe_session.dart';
export 'media_information.dart';
export 'media_information_session.dart';
export 'log.dart';
export 'statistics.dart';
export 'session.dart';
export 'session_state.dart';
export 'log_callback.dart';
export 'statistics_callback.dart';
export 'ffmpeg_session_complete_callback.dart';
export 'ffprobe_session_complete_callback.dart';
export 'media_information_session_complete_callback.dart';
export 'log_redirection_strategy.dart';

// Version information
const String FFMPEG_KIT_VERSION = '6.0.4';  // Our updated version
