import 'package:buisnesshelper/constants.dart';
import 'package:buisnesshelper/base_screen/base.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Base(
        child: Column(
          children: [
            TitleCard(
              leading: CircleAvatar(
                radius: 32, backgroundImage: AssetImage("assets/userprofile.jpg"),
              ),
              title: 'Welcome, William!',
              body: 'Your AI assistant is here to help grow your business and community impact.',
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                gradient: customGradient(primaryColor, secondaryColor),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Text("Today's Overview", style: CardTitle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardItem("100", "Revenue"),
                      CardItem("99", "Customers"),
                      CardItem("98", "Task")
                    ],
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.smart_toy, color: Colors.orange, size: 24,),
                          SizedBox(width: 5,),
                          Text("Ask AI Assistant", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 24),)
                        ],
                      )
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                color: CardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text("Total Impact", style: titleStyle,),
                  DataBar(text: "Total Revenue", number: "5", color: Colors.green),
                  DataBar(text: "Total Customers", number: "6", color: Colors.blue),
                  DataBar(text: "Total Tasks", number: "7", color: Colors.orange)
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

class TitleCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final String body;
  final bool verify;
  const TitleCard({super.key, required this.leading, required this.title, required this.body, this.verify = false});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leading,
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                title,
                style: titleStyle,
              ),
              Text(
                body,
                style: subtitleStyle,
              ),
              if(verify)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 18,),
                    Text("Verified Business", style: TextStyle(color: Colors.green, fontSize: 18),)
                  ],
                )
            ],
          ),
        )
      ],
    );
  }
}

class DataBar extends StatelessWidget {
  final String text;
  final String number;
  final Color color;
  const DataBar({super.key, required this.text, required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 18),),
          Spacer(),
          Text(number, style: TextStyle(fontSize: 18, color: color))
        ],),
    );
  }
}


