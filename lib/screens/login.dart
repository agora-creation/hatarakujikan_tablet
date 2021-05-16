import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_tablet/widgets/error_message.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';
import 'package:hatarakujikan_tablet/widgets/round_background_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4DB6AC),
                  Color(0xFF009688),
                ],
              ),
            ),
            child: groupProvider.status == Status.Authenticating
                ? Loading(size: 40.0, color: Colors.white)
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 320.0, vertical: 80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 200.0,
                            height: 200.0,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('はたらくじかん', style: kTitleTextStyle),
                            Text('for タブレット', style: kSubTitleTextStyle),
                          ],
                        ),
                        SizedBox(height: 32.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              controller: groupProvider.email,
                              obscureText: false,
                              textInputType: TextInputType.emailAddress,
                              maxLines: 1,
                              labelText: 'メールアドレス',
                              labelColor: Colors.white,
                              prefixIconData: Icons.email,
                              suffixIconData: null,
                              onTap: null,
                            ),
                            SizedBox(height: 16.0),
                            CustomTextFormField(
                              controller: groupProvider.password,
                              obscureText:
                                  groupProvider.isHidden ? false : true,
                              textInputType: null,
                              maxLines: 1,
                              labelText: 'パスワード',
                              labelColor: Colors.white,
                              prefixIconData: Icons.lock,
                              suffixIconData: groupProvider.isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: () {
                                groupProvider.changeHidden();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 32.0),
                        RoundBackgroundButton(
                          labelText: 'ログイン',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue,
                          labelFontSize: 16.0,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          onPressed: () async {
                            if (!await groupProvider.signIn()) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => ErrorMessage(
                                  message:
                                      'ログインに失敗しました。メールアドレスもしくはパスワードが間違っている可能性があります。',
                                ),
                              );
                              return;
                            }
                            groupProvider.clearController();
                          },
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
