import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dark.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_bt5wpygx/loading_data.json'),
        ),
      ),
    );
  }
}
