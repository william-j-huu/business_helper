import 'package:buisnesshelper/assistant_screen.dart';
import 'package:buisnesshelper/constants.dart';
import 'package:buisnesshelper/home_page.dart';
import 'package:buisnesshelper/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState(){
    super.initState();
    _screens = [
      HomePage(),
      AssistantScreen(),
      ProfileScreen()
    ];
  }

  void _onItemtapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemtapped,
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "Assistant"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Profile"),
        ],
      ),
    );
  }
}
