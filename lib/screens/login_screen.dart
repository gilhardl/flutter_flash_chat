import 'package:flash_chat/widgets/flash_button.dart';
import 'package:flash_chat/widgets/flash_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            FlashTextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              borderColor: Colors.lightBlueAccent,
              hint: 'Enter your email',
            ),
            SizedBox(
              height: 8.0,
            ),
            FlashTextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              borderColor: Colors.lightBlueAccent,
              hint: 'Enter your password',
            ),
            SizedBox(
              height: 24.0,
            ),
            FlashButton(
              child: Text(
                'Log In',
              ),
              onPressed: () {
                //Implement login functionality.
              },
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
