
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
myFontStyle(double Fs,[FontWeight? Fw, Color? clr]){
  return GoogleFonts.poppins(
    fontSize:Fs ,
    fontWeight: Fw,
    color:clr ,
  );
}
late Size mq;
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
