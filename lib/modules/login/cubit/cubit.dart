import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naruto/modules/login/cubit/states.dart';
import 'package:naruto/shared/components/components.dart';
import 'package:naruto/shared/end_points.dart';
import 'package:naruto/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginStateInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;

  togglePassword()
  {
    showPassword = !showPassword;

    emit(LoginStateTogglePassword());
  }

  login({
    String username,
    String password,
  }) {
    emit(LoginStateLoading());

    DioHelper.postData(
      path: LOGIN_END_POINT,
      data: {
        'grant_type': 'password',
        'client_id': '1',
        'client_secret': 'UFj2FJ7X2jQfSjtptUIadua4rb0yeZjKvVaS55T9',
        'username': username,
        'password': password,
      },
    ).then((value)
    {
      print(jsonDecode(value.toString())['access_token']);

      String token = jsonDecode(value.toString())['access_token'] as String;

      saveToken(token).then((value)
      {
        print('success => ');
      }).catchError((error)
      {
        print('error => ${error.toString()}');
      });

      emit(LoginStateSuccess());
    }).catchError((error)
    {
      print(error.toString());
      emit(LoginStateError(error.toString()));
    });
  }
}