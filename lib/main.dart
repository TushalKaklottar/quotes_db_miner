import 'package:quotes_db_miner/export_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
          page: () =>  const Splash_Screen(),
        ),

        GetPage(
            name: '/home',
            page: () =>  NavigationScreen(),
          transition: Transition.downToUp,
          curve: Curves.easeInOutCubic,
        ),

        GetPage(
            name:  '/detail',
            page: () =>  DetailScreen(),
        ),

      ],
    );
  }
}
