import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_03/screens/home/home.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: const Color(0xff1B1B1B),
        systemNavigationBarColor: const Color(0xff1B1B1B),
        statusBarIconBrightness: Brightness.light));

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: const Home(),
    );
  }
}
