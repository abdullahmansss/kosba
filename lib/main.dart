// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:naruto/modules/login/login_screen.dart';
// import 'package:naruto/modules/test.dart';
// import 'package:naruto/shared/components/components.dart';
//
// void main() async
// {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();
//
//   initApp();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget
// {
//   @override
//   Widget build(BuildContext context)
//   {
//     return MaterialApp(
//       title: 'Naruto',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

import 'dart:io' as io;
import 'dart:math';

import 'package:audio_recorder/audio_recorder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //initApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin audio recorder'),
        ),
        body: new AppBody(),
      ),
    );
  }
}

class AppBody extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  AppBody({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  State<StatefulWidget> createState() => new AppBodyState();
}

class AppBodyState extends State<AppBody> {
  Recording _recording = new Recording();
  bool _isRecording = false;
  Random random = new Random();
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new FlatButton(
                onPressed: _isRecording ? null : _start,
                child: new Text("Start"),
                color: Colors.green,
              ),
              new FlatButton(
                onPressed: _isRecording ? _stop : null,
                child: new Text("Stop"),
                color: Colors.red,
              ),
              new TextField(
                controller: _controller,
                decoration: new InputDecoration(
                  hintText: 'Enter a custom path',
                ),
              ),
              new Text("File path of the record: ${_recording.path}"),
              new Text("Format: ${_recording.audioOutputFormat}"),
              new Text("Extension : ${_recording.extension}"),
              new Text(
                  "Audio recording duration : ${_recording.duration.toString()}")
            ]),
      ),
    );
  }

  _start() async {
    //await Permission.storage.request();

    // try {
    //   if (await AudioRecorder.hasPermissions) {
    //     if (_controller.text != null && _controller.text != "") {
    //       String path = _controller.text;
    //       if (!_controller.text.contains('/')) {
    //         io.Directory appDocDirectory =
    //         await getApplicationDocumentsDirectory();
    //         path = appDocDirectory.path + '/' + _controller.text;
    //       }
    //       print("Start recording: $path");
    //       await AudioRecorder.start(
    //           path: path, audioOutputFormat: AudioOutputFormat.AAC);
    //     } else {
    //       await AudioRecorder.start();
    //     }
    //     bool isRecording = await AudioRecorder.isRecording;
    //     setState(() {
    //       _recording = new Recording(duration: new Duration(), path: "");
    //       _isRecording = isRecording;
    //     });
    //   } else {
    //     Scaffold.of(context).showSnackBar(
    //         new SnackBar(content: new Text("You must accept permissions")));
    //   }
    // } catch (e) {
    //   print(e);
    // }

    await AudioPlayer().play('https://firebasestorage.googleapis.com/v0/b/experts-hub.appspot.com/o/users%2F1613597034727.m4a?alt=media&token=ae4dd436-506d-4baa-8d52-b440d0433cf4');
  }

  _stop() async {
    var recording = await AudioRecorder.stop();
    print("Stop recording: ${recording.path}");
    bool isRecording = await AudioRecorder.isRecording;
    File file = widget.localFileSystem.file(recording.path);

    uploadFile(file);

    print("  File length: ${await file.length()}");
    setState(() {
      _recording = recording;
      _isRecording = isRecording;
    });
    _controller.text = recording.path;
  }

  uploadFile(File image)
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .onComplete
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc('123')
            .set({
          'audio_path': value.toString(),
        }).then((value) {
          //getData();
          print('success uploading to firebase');
        }).catchError((error) {
          print(error.toString());
        });
      });
    });
  }
}