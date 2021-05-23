import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeScreen extends StatelessWidget {
  final GroupProvider groupProvider;

  QrcodeScreen({@required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('QRコード'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Center(
        child: QrImage(
          data: '${groupProvider.group.id}',
          version: QrVersions.auto,
          size: 300.0,
        ),
      ),
    );
  }
}
