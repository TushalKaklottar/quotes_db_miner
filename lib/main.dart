import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_db_miner/view/screen/main_navigation_screen.dart';
import 'package:quotes_db_miner/view/screen/spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      themeMode: ThemeMode.system,
      getPages: [
        GetPage(
          name: '/',
          page: () => const Splash_Screen(),
        ),

        GetPage(
            name: '/home',
            page: () =>  Navigation_Screen(),
          transition: Transition.downToUp,
          curve: Curves.easeInOutCirc,
        )

      ],
    );
  }
}
