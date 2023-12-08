import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metro_admin/screens/home_screen.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAhSraRT3bioDsXdTsRoXNb4Q37Ljp5S_s",
          appId: "1:694409382296:web:b9f7cceb2afec0b2ef43ed",
          messagingSenderId: "694409382296",
          projectId: "metro-806d3",
          storageBucket: "metro-806d3.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      title: 'Taxi Region II',
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
