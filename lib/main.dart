import 'package:flutter/material.dart';
import 'package:mofakera/Screen/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.courgetteTextTheme(),
      ),
      home: AnimatedSplashScreen(
        duration: 4000,
        splash: Image.asset("images/todo-list.jpg", fit: BoxFit.cover,),
        nextScreen: const HomeScreen(),
        backgroundColor: Colors.black,
        splashIconSize: double.infinity,
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}
