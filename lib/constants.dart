import 'package:flutter/material.dart';

Color primaryColor = Colors.orange;
Color secondaryColor = Colors.green;

LinearGradient ygGradient = LinearGradient(
  colors: [
    primaryColor, secondaryColor
  ]
);

LinearGradient customGradient(Color color1, Color color2){
  return LinearGradient(colors: [color1, color2]);
}

TextStyle titleStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle subtitleStyle = TextStyle(
  fontSize: 18,
  color: Colors.black.withOpacity(0.6)
);

TextStyle CardTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white
);

TextStyle CardSubtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white.withOpacity(0.7)
);

Color CardColor = Colors.black.withOpacity(0.04);

Column CardItem(String title, String subtitle)
{
  return Column(
    children: [
      Text(title, style: CardTitle,),
      Text(subtitle, style: CardSubtitle)
    ],
  );
}