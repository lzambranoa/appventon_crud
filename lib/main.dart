import 'package:appventon/pages/car_page.dart';
import 'package:appventon/pages/edit_page.dart';
import 'package:appventon/pages/form_page.dart';
import 'package:appventon/pages/login_page.dart';
import 'package:appventon/pages/user_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appventon',
      initialRoute: 'login',
      routes: {
        'form'    : (BuildContext context)  => FormPage(),
        'user'    : (BuildContext context)  => UserPage(),
        'edit'    : (BuildContext context)  => EditPage(),
        'login'    : (BuildContext context)  => LoginPage(),
        'car'    : (BuildContext context)  => CarPage(),
      }
    );
  }
}