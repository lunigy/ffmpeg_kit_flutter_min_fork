import 'package:flutter/material.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_min/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter_min/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FFmpeg Kit Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FFmpeg Kit Flutter Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _ffmpegOutput = 'FFmpeg output will appear here';
  bool _isProcessing = false;

  Future<void> _executeFFmpegCommand() async {
    if (_isProcessing) return;
    
    setState(() {
      _isProcessing = true;
      _ffmpegOutput = 'Processing...';
    });
    
    try {
      // Get application documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final outputPath = '${appDir.path}/output.mp4';
      
      // Create a simple video from a color source
      // This is a simple command that should work on most devices
      await FFmpegKit.executeAsync(
        '-f lavfi -i color=c=blue:s=320x240:d=5 -c:v libx264 $outputPath',
        (session) async {
          final returnCode = await session.getReturnCode();
          
          setState(() {
            _isProcessing = false;
            if (ReturnCode.isSuccess(returnCode)) {
              _ffmpegOutput = 'Success! Created video at: $outputPath';
            } else {
              _ffmpegOutput = 'Error! FFmpeg process failed with code: ${returnCode?.getValue() ?? 'unknown'}';
            }
          });
        },
        (log) {
          // This will be called for each log message
          print('FFmpeg Log: ${log.getMessage()}');
        },
        (statistics) {
          // This will be called with progress statistics
          print('FFmpeg Progress: ${statistics.getTime()} ms');
        }
      );
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _ffmpegOutput = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Press the button to run an FFmpeg command:',
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _ffmpegOutput,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isProcessing ? null : _executeFFmpegCommand,
        tooltip: 'Run FFmpeg',
        child: _isProcessing
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.play_arrow),
      ),
    );
  }
}
