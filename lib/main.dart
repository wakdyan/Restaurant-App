import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: AppTheme.themeData,
      initialRoute: HomeScreen.route,
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
        DetailScreen.route: (_) => DetailScreen(),
        SearchScreen.route: (_) => SearchScreen(),
      },
    );
  }
}
