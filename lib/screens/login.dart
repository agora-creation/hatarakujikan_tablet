import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/screens/select.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_tablet/widgets/error_dialog.dart';
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
            decoration: kLoginDecoration,
            child: groupProvider.status == Status.Authenticating
                ? Loading(color: Colors.white)
                : SingleChildScrollView(
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
                              '会社/組織専用',
                              style: TextStyle(color: Colors.white),
                            ),
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
                              label: 'メールアドレス',
                              color: Colors.white,
                              prefix: Icons.email,
                              suffix: null,
                              onTap: null,
                            ),
                            SizedBox(height: 16.0),
                            CustomTextFormField(
                              controller: groupProvider.password,
                              obscureText:
                                  groupProvider.isHidden ? false : true,
                              textInputType: null,
                              maxLines: 1,
                              label: 'パスワード',
                              color: Colors.white,
                              prefix: Icons.lock,
                              suffix: groupProvider.isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              onTap: () => groupProvider.changeHidden(),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.0),
                        RoundBackgroundButton(
                          onPressed: () async {
                            if (!await groupProvider.signIn()) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => ErrorDialog('ログインに失敗しました。'),
                              );
                              return;
                            }
                            groupProvider.clearController();
                            overlayScreen(
                              context,
                              SelectScreen(groupProvider: groupProvider),
                            );
                          },
                          label: 'ログイン',
                          color: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        // SizedBox(height: 40.0),
                        // Center(
                        //   child: CustomLinkButton(
                        //     onTap: () {},
                        //     label: '部署/事業所専用はここをクリック',
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
