import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:mafia_helper/Screens/Game/game_screen.dart';
import 'package:mafia_helper/UICommon/app_color.dart';
import 'package:mafia_helper/UICommon/app_theme.dart';
import 'package:mafia_helper/Screens/Shufl/shuffle_screen.dart';
import 'package:mafia_helper/Analitics/Core/game_settings_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Analitics/Core/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logAppOpen();
  bool isGameStarted = false;
  try {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isGameStarted = prefs.getBool(GameSettingsStorage.gameStartedKey) ?? false;
    print("isGameStarted = " + isGameStarted.toString());
  } catch (e) {
    isGameStarted = false;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
                BouncingScrollWrapper.builder(context, widget!),
                maxWidth: 1200,
                minWidth: 480,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.autoScale(1000, name: DESKTOP)
                ],
        background: Container(color: AppColor.primary,)),
        title: 'Помошник мафии',
        theme: AppTheme.darkTheme,
        initialRoute: ShuffleScreen.routeName,
        routes: {
          ShuffleScreen.routeName: (context) =>
              const MyHomePage(title: 'Помошник мафии'),
          GameScreen.routeName: (context) => const GameScreen(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const ShuffleScreen(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
