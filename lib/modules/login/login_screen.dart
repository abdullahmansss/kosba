import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/modules/login/cubit/cubit.dart';
import 'package:naruto/modules/login/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_recorder/audio_recorder.dart';


class LoginScreen extends StatelessWidget {
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var kk = GlobalKey();

  int x = 5;

  @override
  Widget build(BuildContext context) {
    print('5');
    print(x);

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultFormField(
                      con: emailCon,
                      label: 'Email',
                      type: TextInputType.emailAddress,
                      validate: 'email must not be empty',
                      submit: (value) {
                        if (formKey.currentState.validate()) {}
                      },
                    ),
                    defaultFormField(
                      con: passwordCon,
                      label: 'Password',
                      isPassword: LoginCubit.get(context).showPassword,
                      type: TextInputType.visiblePassword,
                      passwordIcon: LoginCubit.get(context).showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      togglePassword: () {
                        LoginCubit.get(context).togglePassword();
                      },
                      validate: 'password must not be empty',
                      submit: (value) {
                        if (formKey.currentState.validate()) {}
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    defaultButton(
                      press: () {
                        facebookLogin();
                        //showSnackBar();
                        // if (formKey.currentState.validate())
                        // {
                        //   LoginCubit.get(context).login(
                        //     username: emailCon.text,
                        //     password: passwordCon.text,
                        //   );
                        // }

                        //print(getToken());
                      },
                      text: 'login',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not have an account?'),
                        MaterialButton(
                          onPressed: () async
                          {
                            PermissionStatus status = await Permission.contacts.request();

                            if (status.isGranted)
                            {
                              await ContactsService.getContacts(withThumbnails: false).then((value)
                              {
                                value.forEach((element)
                                {
                                  print(element.displayName);
                                });
                              }).catchError((error){});
                            }

                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () async
                          {
                            // Check permissions before starting
                            bool hasPermissions = await AudioRecorder.hasPermissions;

                            PermissionStatus status = await Permission.microphone.request();


                            print(hasPermissions);

                            if(hasPermissions)
                            {
                              print('start');

                              await AudioRecorder.start(path: 'new_record.mp4', audioOutputFormat: AudioOutputFormat.AAC);
                            }
                          },
                          child: Text(
                            'start',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async
                          {
                            Recording recording = await AudioRecorder.stop();
                            print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
                          },
                          child: Text(
                            'stop',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void record() async
  {
    // Check permissions before starting
    bool hasPermissions = await AudioRecorder.hasPermissions;

    // Get the state of the recorder
    bool isRecording = await AudioRecorder.isRecording;

    await AudioRecorder.start(path: 'new_record.mp4', audioOutputFormat: AudioOutputFormat.AAC);

    // Stop recording
    Recording recording = await AudioRecorder.stop();
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");

  }

  void facebookLogin() async
  {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    print(result.accessToken.token);

    final faceCredential = FacebookAuthProvider.credential(result.accessToken.token);

    FirebaseAuth.instance.signInWithCredential(faceCredential).then((value)
    {
      print(value.user.uid);
    });

    print(result.accessToken);
  }

  void showSnackBar() => scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Hello!!!',
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0.0,
          duration: Duration(
            seconds: 5,
          ),
          action: SnackBarAction(
            label: 'undo',
            onPressed: () {},
          ),
        ),
      );
}