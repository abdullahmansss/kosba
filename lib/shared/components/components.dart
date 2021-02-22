import 'package:flutter/material.dart';
import 'package:naruto/models/courses/courses_model.dart';
import 'package:naruto/shared/network/remote/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences preferences;

Future<void> initApp() async
{
  DioHelper();
  await initPref();
}

Future<void> initPref() async
{
  return await SharedPreferences.getInstance().then((value)
  {
    preferences = value;
    print('done =>');
  }).catchError((error){
    print('error => ${error.toString()}');

  });
}

Future<bool> saveToken(String token) => preferences.setString('myToken', token);

String getToken() => preferences.getString('myToken');

Future<bool> clearToken() => preferences.remove('myToken');

Widget progressIndicator() => Center(child: CircularProgressIndicator());

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);

Widget courseItem(Data data) => Padding(
  padding: const EdgeInsets.all(
    20.0,
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10.0,
          ),
          border: Border.all(
            width: 1.0,
            color: Colors.grey[300],
          ),
          image: DecorationImage(
            image: NetworkImage(
              data.image,),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(
              data.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              data.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '${data.price} L.E',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

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
  double radius = 5,
}) => Container(
  width: double.infinity,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
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
