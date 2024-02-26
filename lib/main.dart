import 'package:cinelog/firebase_options.dart';
import 'package:cinelog/features/login_register/ui/login_screen.dart';
import 'package:cinelog/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cinelog',
      theme: ThemeData(
          primaryColor: Color(0xFFFE8E8E8),
          secondaryHeaderColor: Color(0xFFF222831),
          primaryColorDark: Colors.black,
          fontFamily: 'Glory',
          brightness: Brightness.light),
      darkTheme: ThemeData(
          primaryColor: Color(0xFFF30475E),
          secondaryHeaderColor: Color(0xFFFF05454),
          primaryColorDark: Color(0xFFFE8E8E8),
          fontFamily: 'Glory',
          brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MainScreen(
                index: 0,
              );
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}
