import 'package:flash_chat/widgets/flash_button.dart';
import 'package:flash_chat/widgets/flash_text_field.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              borderColor: Colors.blueAccent,
              hint: 'Enter your email',
            ),
            SizedBox(
              height: 8.0,
            ),
            FlashTextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              borderColor: Colors.blueAccent,
              hint: 'Enter your password',
            ),
            SizedBox(
              height: 24.0,
            ),
            FlashButton(
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //Implement registration functionality.
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
