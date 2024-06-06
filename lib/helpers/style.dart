import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFFFEFFFA),
    fontFamily: 'NotoSansJP',
    appBarTheme: AppBarTheme(
      color: Color(0xFFFEFFFA),
      elevation: 3.0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: Colors.black54,
        fontSize: 20.0,
      ),
      iconTheme: IconThemeData(color: Colors.black54),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black54),
      bodyMedium: TextStyle(color: Colors.black54),
      bodySmall: TextStyle(color: Colors.black54),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

const BoxDecoration kLoginDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4DB6AC),
      Color(0xFF009688),
    ],
  ),
);

const BoxDecoration kWorkButtonDecoration = BoxDecoration(
  color: Color(0xFFFEFFFA),
  boxShadow: [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 4.0,
      offset: Offset(4.0, 4.0),
    ),
  ],
);

const BoxDecoration kTopBorderDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
      width: 1.0,
      color: Color(0xFFE0E0E0),
    ),
  ),
);

const BoxDecoration kBottomBorderDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 1.0,
      color: Color(0xFFE0E0E0),
    ),
  ),
);

const TextStyle kTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
);

const TextStyle kSubTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 24.0,
);

const TextStyle kDateTextStyle = TextStyle(
  fontSize: 40.0,
  letterSpacing: 4.0,
);

const TextStyle kTimeTextStyle = TextStyle(
  fontSize: 80.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 8.0,
);

const TextStyle kHomeTextStyle = TextStyle(
  fontSize: 26.0,
);

const TextStyle kKeypadTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 8.0,
);

const TextStyle kKeypad2TextStyle = TextStyle(
  color: Colors.black26,
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  letterSpacing: 8.0,
);

const ANDROID_APP_ID = 'com.agoracreation.hatarakujikan_tablet';
const IOS_BUNDLE_ID = 'com.agoracreation.hatarakujikanTablet';
