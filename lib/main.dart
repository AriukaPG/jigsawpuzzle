import 'package:flutter/material.dart';
import 'Screens/splash_screen.dart';
import 'Screens/onboarding.dart';
import 'Screens/register_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/myAccount_screen.dart';
import 'package:jigsawpuzzle/Screens/jigsawPuzzle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Utils/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Зураг эвлүүлэх тоглоом',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoarding(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/jigsaw': (context) => const JigsawPuzzle(),
        '/account': (context)=> const MyAccountScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}
