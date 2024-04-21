import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    callDelay(context);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.lightBlueAccent, Color(0xffA3ECFF)],
            ),
          ),
          child: const Center(
            child: Text(
              "Ariuka's mini app",
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          )),
    );
  }

  Future callDelay(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, "/onboarding");
  }
}
