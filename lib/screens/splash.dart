import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            decoration: kLoginDecoration,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 180.0,
                      height: 180.0,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('はたらくじかん', style: kTitleTextStyle),
                      Text('for タブレット', style: kSubTitleTextStyle),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  Loading(color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
