import 'package:flutter/material.dart';

import '../constants.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Center(child: Text("Technical Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: customGradient(primaryColor, secondaryColor)
          ),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/business-helper-f9467.firebasestorage.app/o/images%2FAccounting.png?alt=media&token=977f8d77-3888-4016-8114-7956cd53e5b7",
                  fit: BoxFit.cover,
                ),
              )
            ),

          )
        ],
      ),
    );
  }
}
