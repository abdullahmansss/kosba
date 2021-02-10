import 'package:flutter/material.dart';
import 'package:naruto/modules/login/login_screen.dart';
import 'package:naruto/shared/components/components.dart';
import 'package:naruto/shared/network/remote/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  initApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Naruto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}