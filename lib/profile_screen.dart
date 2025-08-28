import 'package:buisnesshelper/base_screen/base.dart';
import 'package:buisnesshelper/constants.dart';
import 'package:buisnesshelper/home_page.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              title: "William's Business",
              body: 'Local Cafe',
              verify: true,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24),
              margin: EdgeInsets.only(top: 25),
              decoration: BoxDecoration(
                gradient: customGradient(Colors.orange, Colors.green),
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                children: [
                  Text("Business Performance", style: CardTitle,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CardItem("48", "Annual Revenue"),
                          CardItem("150", "Customers"),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("4.5", style: CardTitle,),
                                  Icon(Icons.star, size: 24, color: Colors.white,),
                                ],
                              ),
                              Text("Rating", style: CardSubtitle)
                            ],
                          ),
                          CardItem("5", "Employees"),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
            //   margin: EdgeInsets.only(top: 25),
            //   decoration: BoxDecoration(
            //     color: CardColor,
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Column(
            //     children: [
            //       Text("Total Impact", style: titleStyle,),
            //       DataBar(text: "Total Revenue", number: "5", color: Colors.green),
            //       DataBar(text: "Total Customers", number: "6", color: Colors.blue),
            //       DataBar(text: "Total Tasks", number: "7", color: Colors.orange)
            //     ],
            //   ),
            // )
          ],
        ),
      )
    );
  }
}
