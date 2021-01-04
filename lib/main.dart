import 'package:flutter/material.dart';
import 'package:google_signin_example/page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_signin_example/services/theme_changer.dart';
import 'package:google_signin_example/theme.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
static final String title = 'Google SignIn';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: Builder(builder: (context) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          themeMode: themeChanger.getTheme,
          darkTheme: Style.get(true),
          theme: Style.get(false),
          home: HomeRoute(),
        );
      }),
    );
  }

  // static final String title = 'Google SignIn';

  // @override
  // Widget build(BuildContext context) => MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       title: title,
  //       theme: ThemeData(primarySwatch: Colors.amber),
  //       home: HomeRoute(),
  //     );
}

