import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proChat/screens/login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:proChat/Button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  initState()
  {
    super.initState();
    print('hello');
  }
  String id = 'welcome_screen';
  Widget build(BuildContext context) {
    print('jkdsbvjhf');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF005995),
              Color(0xFF0f2862),
              Color(0xFF0f2862),
              Color(0xFF0f2862),
              Color(0xFF0f2862),
              Color(0xFF4f5f76),
              Color(0xFF2d545e),
              Color(0xFFc89666),
              Color(0xFFe1b382),
              Color(0xFFc7af6b)
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Divider(
                color: Colors.purple[500],
                thickness: 3,
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  TyperAnimatedTextKit(
                    pause: Duration(milliseconds: 6500),
                    text: ['proChat_'],
                    stopPauseOnTap: false,
                    textStyle: TextStyle(
                      fontFamily: 'Ultra',
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      backgroundColor: Colors.white60,
                      color: Colors.green[900],
                    ),
                    textAlign: TextAlign.start,
                    alignment: AlignmentDirectional.topStart,
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              new Divider(
                color: Colors.purple[500],
                thickness: 3,
              ),
              SizedBox(
                height: 44.0,
              ),
              // returnButton(Colors.teal[600], 'Log In',Navigator.pushNamed(context, 'login_screen'))
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 15.0,
                  // color: Color(0xFFe1b382),
                  color:Colors.teal,
                  // shadowColor: Color(0xFFc89666),
                  shadowColor: Colors.brown[900],
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login_screen');
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 15,
                  color: Color(0xFFf9c5bd),
                  shadowColor: Colors.pink[900],
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'registration_screen');
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
