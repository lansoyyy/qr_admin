import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/screens/home_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB0HijyKZx-5rqr8Ryp4HKHtZsflpoX0_o",
          projectId: "amusement-2e6a5",
          storageBucket: "amusement-2e6a5.appspot.com",
          messagingSenderId: "928127195723",
          appId: "1:928127195723:web:06834331060942c8ec0bce"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: 'Amusement Park',
      builder: ((context, child) {
        return ResponsiveWrapper.builder(child,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            ],
            background: Container(color: Colors.white));
      }),
    );
  }
}
