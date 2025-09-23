import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    // Todo: authenticate using firebase
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      Navigator.pushReplacementNamed(context, "/navigation_screen");
    }
    else{
      Navigator.pushReplacementNamed(context, "/login_screen");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              padding: EdgeInsets.fromLTRB(16, 37, 16, 105),
              decoration: BoxDecoration(
                  gradient: customGradient(primaryColor, secondaryColor),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: SizedBox(
                width: 204,
                height: 93,
                child: Text("Business Helper",
                  softWrap: true,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                    fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "InstrumentSans"
                  ),
                ),
              )
            ),
            Spacer(),
            Text("v.1.0.0", style: TextStyle(
              fontSize: 20, color: Colors.black.withOpacity(0.5)
            ),)
          ],
        ),
      ),
    );
  }
}
