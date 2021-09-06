import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/section.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/screens/home.dart';
import 'package:hatarakujikan_tablet/screens/login.dart';
import 'package:hatarakujikan_tablet/screens/section/login.dart';
import 'package:hatarakujikan_tablet/screens/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GroupProvider.initialize()),
        ChangeNotifierProvider.value(value: SectionProvider.initialize()),
        ChangeNotifierProvider.value(value: WorkProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ja'),
        ],
        locale: const Locale('ja'),
        title: 'はたらくじかんforタブレット',
        theme: theme(),
        home: SplashController(),
      ),
    );
  }
}

class SplashController extends StatefulWidget {
  @override
  _SplashControllerState createState() => _SplashControllerState();
}

class _SplashControllerState extends State<SplashController> {
  bool _mode = true;

  void _init() async {
    if (await getPrefs(key: 'groupId') != '') {
      _mode = true;
    } else if (await getPrefs(key: 'sectionId') != '') {
      _mode = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);
    final sectionProvider = Provider.of<SectionProvider>(context);
    if (_mode == true) {
      switch (groupProvider.status) {
        case Status.Uninitialized:
          return SplashScreen();
        case Status.Unauthenticated:
        case Status.Authenticating:
          return LoginScreen();
        case Status.Authenticated:
          if (groupProvider.group == null) {
            groupProvider.signOut();
            return LoginScreen();
          }
          return HomeScreen();
        default:
          return LoginScreen();
      }
    } else {
      switch (sectionProvider.status) {
        case Status2.Uninitialized:
          return SplashScreen();
        case Status2.Unauthenticated:
        case Status2.Authenticating:
          return SectionLoginScreen();
        case Status2.Authenticated:
          if (sectionProvider.section == null) {
            sectionProvider.signOut();
            return SectionLoginScreen();
          }
          return HomeScreen();
        default:
          return SectionLoginScreen();
      }
    }
  }
}
