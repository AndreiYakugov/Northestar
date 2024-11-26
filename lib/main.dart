import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:northstar_app/screens/home_screen.dart';
import 'package:northstar_app/screens/sign_in_screen.dart';
import 'package:northstar_app/screens/splash_screen.dart';
import 'package:northstar_app/utils/SharedPrefUtils.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtils.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NortStar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(AppColors.primaryColor),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 14),
            ),
            textStyle: WidgetStateProperty.all<TextStyle>(
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
