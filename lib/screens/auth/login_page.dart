import 'package:flutter/material.dart';
import 'package:metro_admin/screens/home_screen.dart';
import 'package:metro_admin/utils/colors.dart';
import 'package:metro_admin/widgets/button_widget.dart';
import 'package:metro_admin/widgets/text_widget.dart';

class LoginPage extends StatelessWidget {
  late String username;
  late String password;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: secondaryRed,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png', // replace with your image file path
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ButtonWidget(
                color: secondaryRed,
                label: 'Login',
                onPressed: () {
                  if (username == 'cvkatcoadmin' && password == 'cvkatco') {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: TextRegular(
                            text: 'Invalid admin credentials',
                            fontSize: 18,
                            color: Colors.white)));
                  }
                })
          ],
        ),
      ),
    );
  }
}
