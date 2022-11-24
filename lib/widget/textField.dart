import 'package:flutter/cupertino.dart';

Widget textWithStyle(text, weight, size, color, fontFamily){
  return Text(text, style: TextStyle(fontSize: size,fontWeight: weight, fontFamily: fontFamily,color: color),);
}