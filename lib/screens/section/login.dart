import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/screens/login.dart';
import 'package:hatarakujikan_tablet/widgets/custom_link_button.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_tablet/widgets/round_background_button.dart';

class SectionLoginScreen extends StatelessWidget {
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
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 320.0,
                vertical: 80.0,
              ),
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
                      SizedBox(height: 8.0),
                      Text(
                        '部署/事業所専用',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: null,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        maxLines: 1,
                        label: 'メールアドレス',
                        color: Colors.white,
                        prefix: Icons.email,
                        suffix: null,
                        onTap: null,
                      ),
                      SizedBox(height: 16.0),
                      CustomTextFormField(
                        controller: null,
                        obscureText: true,
                        textInputType: null,
                        maxLines: 1,
                        label: 'パスワード',
                        color: Colors.white,
                        prefix: Icons.lock,
                        suffix: Icons.visibility_off,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  RoundBackgroundButton(
                    onPressed: () async {},
                    label: 'ログイン',
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: CustomLinkButton(
                      onTap: () => nextScreen(
                        context,
                        LoginScreen(),
                      ),
                      label: '会社/組織専用はここをクリック',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}