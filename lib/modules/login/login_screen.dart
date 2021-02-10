import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/modules/login/cubit/cubit.dart';
import 'package:naruto/modules/login/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var emailCon = TextEditingController();
  var passwordCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
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
                      press: ()
                      {
                        if (formKey.currentState.validate())
                        {
                          LoginCubit.get(context).login(
                            username: emailCon.text,
                            password: passwordCon.text,
                          );
                        }

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
                          onPressed: ()
                          {

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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
