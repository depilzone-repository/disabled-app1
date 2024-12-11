import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kGradiantHorizontalColor = LinearGradient(
  colors: [
    Color(0xff03b7f9),
    Color(0xff3f5efb),
    // Color(0xff7e3ffb)
  ],
  stops: [
    0.25,
    0.75,
    // 0.87,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight
);
const kGradiantVerticalColor = LinearGradient(
  colors: [Color(0xff03b7f9), Color(0xff3f5efb)],
  stops: [0.25, 0.75],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);


const kGray50Color = Color(0xFFF8F8F8);
const kGray100Color =  Color(0xFFF9F9F9);
const kGray200Color =  Color(0xFFF1F1F2);
const kGray300Color =  Color(0xFFDBDFE9);
const kGray400Color =  Color(0xFFB5B5C3);
const kGray500Color =  Color(0xFF99A1B7);
const kGray600Color =  Color(0xFF78829D);
const kGray700Color =  Color(0xFF4B5675);
const kGray800Color =  Color(0xFF252F4A);
const kGray900Color =  Color(0xFF071437);

const kDepilColor100 = Color(0xFFCAF0FF); //#CAF0FF
const kDepilColor300 = Color(0xFF0099D2);
const kDepilColor700 = Color(0xFF059DD8); //#059DD8
const kDepilColor = Color(0xFF03B7F9);
const kDepilLightColor = Color(0xFF9AE3FF);

const kWarningColor = Color(0xFFFD6C63);

const kIndigo = Color(0xff607ec9);

const double defaultPadding = 16.0;
const kIndigo10Color = Color(0xFFF0F5FF); //#F0F5FF
const kIndigo20Color = Color(0xFFF0F2F9); //#F0F2F9
const kIndigo50Color = Color(0xFF6167FF); //#6167FF
const kIndigo100Color = Color(0xFF5359E8); //#5359E8

const dPrimaryColor = Color(0XFF02b4F9); //#02B4F9
const dLightColor = Color(0XFFE0E0E0); //#E0E0E0
const dSecondaryColor = Color(0XFF8D9DB5); //#8D9DB5
const dDarkColor = Color(0XFF63748E); //#63748E
const dBlackColor = Color(0XFF293446); //#293446

const double dMaxTitle = 30.0;
const double dTitle = 20.0;
const double dSubTitle = 16.0;
const double dText = 14.0;
const double dSmall = 12.0;