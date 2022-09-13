import 'package:flutter/material.dart';

const Color clrBlack000 = Color(0xff010710);
const Color clrBlack100 = Color(0xff717578);
const Color clrWhite000 = Color(0xffFBFBFB);
const Color clrWhite100 = Color(0xffF4F4F4);
const Color clrPrimary = Color(0xffF58A5B);

const FontWeight fontMedium = FontWeight.w500;

myfont(double? size, [Color? clr, FontWeight? fw]) {
  return TextStyle(
    fontSize: size,
    color: clr == null ? clrBlack000 : clr,
    fontWeight: fw == null ? fontMedium : fw,
  );
}
