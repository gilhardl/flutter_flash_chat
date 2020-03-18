import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/widgets/flash_button.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      if (user != null) {
        Navigator.pushNamed(context, '/chat');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 60.0,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  HeroLogo(),
                  TypewriterAnimatedTextKit(
                    text: [
                      "Flash Chat",
                    ],
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.start,
                    alignment: AlignmentDirectional.topEnd,
                    isRepeatingAnimation: true,
                    pause: Duration(microseconds: 0),
                    totalRepeatCount: 1000,
                    speed: Duration(milliseconds: 200),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            FlashButton(
              child: Text(
                'Log In',
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              color: Theme.of(context).accentColor,
            ),
            FlashButton(
              child: Text(
                'Register',
              ),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.routeName);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class HeroLogo extends StatefulWidget {
  @override
  _HeroLogoState createState() => _HeroLogoState();
}

class _HeroLogoState extends State<HeroLogo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    animation.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });

    Future.delayed(Duration(seconds: 1)).then((_) {
      controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Container(
        child: Opacity(
          opacity: opacity,
          child: Image.asset('images/logo.png'),
        ),
        height: 30 + (animation.value * 30),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
