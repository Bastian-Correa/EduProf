import 'package:flutter/material.dart';
import 'package:EduProf/Config/user_prefs.dart';
import 'package:EduProf/Home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeCtrl = ThemeController();
  await themeCtrl.load();
  runApp(MyApp(themeCtrl: themeCtrl));
}

class MyApp extends StatelessWidget {
  final ThemeController themeCtrl;
  const MyApp({super.key, required this.themeCtrl});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeCtrl,
      builder: (context, _) {
        return MaterialApp(
          title: 'EduProf',
          debugShowCheckedModeBanner: false,
          theme: themeCtrl.appTheme,
          builder: (context, child) {
            final scale = themeCtrl.textScaleFactor;
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            );
          },
          home: MyHomePage(title: 'EduProf', themeCtrl: themeCtrl),
        );
      },
    );
  }
}
