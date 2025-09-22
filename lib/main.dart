import 'package:buisnesshelper/home_page.dart';
import 'package:buisnesshelper/login_screen.dart';
import 'package:buisnesshelper/navigation_screen.dart';
import 'package:buisnesshelper/signup_screen.dart';
import 'package:buisnesshelper/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
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
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/":(context) => SplashScreen(),
        "/login_screen":(context) => LoginScreen(),
        "/signup_screen":(context) => SignupScreen(),
        "/navigation_screen":(context) => NavigationScreen()
      },
    );
  }
}