import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/widgets/flash_button.dart';
import 'package:flash_chat/widgets/flash_text_field.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String routeName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                FlashTextField(
                  onChanged: (value) {
                    email = value;
                  },
                  borderColor: Theme.of(context).primaryColor,
                  hint: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 8.0,
                ),
                FlashTextField(
                  onChanged: (value) {
                    password = value;
                  },
                  borderColor: Theme.of(context).primaryColor,
                  hint: 'Enter your password',
                  obscureText: true,
                ),
                SizedBox(
                  height: 24.0,
                ),
                FlashButton(
                  child: Text(
                    'Register',
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      AuthResult result =
                          await _auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (result.user != null) {
                        Navigator.pushNamed(context, '/chat');
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
