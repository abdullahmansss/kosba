import 'package:flutter/material.dart';
import 'package:naruto/shared/network/remote/dio_helper.dart';
// 123123123123123213

//SharedPreferences preferences;

void initApp() {
  DioHelper();
  //initPref();
}

// Future<void> initPref() async
// {
//   return await SharedPreferences.getInstance().then((value)
//   {
//     preferences = value;
//     print('done =>');
//   }).catchError((error){
//     print('error => ${error.toString()}');
//
//   });
// }
//
// Future<bool> saveToken(String token) => preferences.setString('myToken', token);
//
// String getToken() => preferences.getString('myToken');

Widget defaultFormField({
  @required TextEditingController con,
  @required TextInputType type,
  @required String validate,
  @required String label,
  bool isPassword = false,
  Function submit,
  Function togglePassword,
  IconData passwordIcon,
}) =>
    TextFormField(
      controller: con,
      keyboardType: type,
      obscureText: isPassword,
      validator: (value) {
        if (value.isEmpty) {
          return validate;
        }
        return null;
      },
      onFieldSubmitted: submit,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: passwordIcon != null
            ? GestureDetector(
                onTap: togglePassword,
                child: Icon(
                  passwordIcon,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );

Widget defaultButton({
  @required Function press,
  @required String text,
}) =>
    Container(
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        color: Colors.blue,
      ),
      child: MaterialButton(
        height: 40.0,
        onPressed: press,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
