import 'dart:io' as io;
import 'dart:math';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppBody extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  AppBody({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => AppBodyState();
}

class AppBodyState extends State<AppBody> {
  Recording _recording = Recording();
  bool _isRecording = false;
  Random random = Random();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: _isRecording ? null : _start,
                  child: Text("Start"),
                  color: Colors.green,
                ),
                FlatButton(
                  onPressed: _isRecording ? _stop : null,
                  child: Text("Stop"),
                  color: Colors.red,
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter a custom path',
                  ),
                ),
                Text("File path of the record: ${_recording.path}"),
                Text("Format: ${_recording.audioOutputFormat}"),
                Text("Extension : ${_recording.extension}"),
                Text(
                    "Audio recording duration : ${_recording.duration.toString()}")
              ]),
        ),
      ),
    );
  }

  _start() async {
    try {
      if (await AudioRecorder.hasPermissions) {
        if (_controller.text != null && _controller.text != "") {
          String path = _controller.text;
          if (!_controller.text.contains('/')) {
            io.Directory appDocDirectory =
            await getApplicationDocumentsDirectory();
            path = appDocDirectory.path + '/' + _controller.text;
          }
          print("Start recording: $path");
          await AudioRecorder.start(
              path: path, audioOutputFormat: AudioOutputFormat.AAC);
        } else {
          await AudioRecorder.start();
        }
        bool isRecording = await AudioRecorder.isRecording;
        setState(() {
          _recording = Recording(duration: Duration(), path: "");
          _isRecording = isRecording;
        });
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _stop() async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = widget.localFileSystem.file(recording.path);
    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
    });
    _controller.text = recording.path;
  }
}