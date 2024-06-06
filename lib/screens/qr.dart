import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatelessWidget {
  final GroupModel? group;

  QrScreen({this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('${group?.name ?? ''}のQRコード'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: QrImageView(
                  data: group?.id ?? '',
                  version: QrVersions.auto,
                  size: 400.0,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'これは${group?.name ?? ''}の会社/組織IDが埋め込まれたQRコードです。別アプリ「はたらくじかんforスマートフォン」でこのQRコードを使用します。',
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '【会社/組織に入る時】',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('① 「はたらくじかんforスマートフォン」を起動し、ログインしておく'),
                  Text('② 下部メニューから「会社/組織」をタップする'),
                  Text('③ 下部メニューの上の「会社/組織に入る(QRコード)」ボタンをタップする'),
                  Text('④ カメラが起動するので、枠内にこのQRコードを収めるように撮る'),
                  SizedBox(height: 16.0),
                  group?.qrSecurity == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '【出退勤や休憩時間を記録する時】',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('① 「はたらくじかんforスマートフォン」を起動し、ログインしておく'),
                            Text('② 下部メニューが「ホーム」になっているのを確認する'),
                            Text(
                                '③ 「出勤」「退勤」「休憩開始」「休憩終了」のそれぞれボタンをタップした時にカメラが起動する'),
                            Text('④ 枠内にこのQRコードを収めるように撮る'),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
