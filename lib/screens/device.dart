import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_form_field.dart';
import 'package:hatarakujikan_tablet/widgets/round_background_button.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  TextEditingController name = TextEditingController();

  void _init() async {
    name.text = await getPrefsName() ?? '';
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('端末の名前変更'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, size: 40.0),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        children: [
          CustomTextFormField(
            controller: name,
            obscureText: false,
            textInputType: TextInputType.name,
            maxLines: 1,
            label: '端末の名前',
            color: Colors.black54,
            prefix: Icons.tablet,
            suffix: null,
            onTap: null,
          ),
          SizedBox(height: 16.0),
          RoundBackgroundButton(
            onPressed: () async {
              await setPrefsName(name.text.trim());
              Navigator.pop(context);
            },
            label: '変更を保存',
            color: Colors.white,
            backgroundColor: Colors.blue,
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
