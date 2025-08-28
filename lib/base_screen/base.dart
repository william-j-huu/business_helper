import 'package:buisnesshelper/constants.dart';
import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  final Widget child;
  const Base({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: customGradient(Colors.orange, Colors.green)
              ),
              height: 60,
            ),

            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: child,
                )
            )
          ],
        )
    );;
  }
}

