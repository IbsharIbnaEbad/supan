import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supan/home_screen.dart';
import 'package:supan/login_screen.dart';
import 'package:supan/main.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after a delay
    Timer(const Duration(seconds: 2), () {
      final user = supabase.auth.currentUser;
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FlutterLogo(size: size.width * 0.5), // Responsive logo size
      ),
    );
  }
}