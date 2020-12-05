import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

bool showSpinner = false;

class _LoginScreenState extends State<LoginScreen> {
  String getEmail;
  String getPass;
  final _getAuth = FirebaseAuth.instance;
  @override
  initState()
  {
    super.initState();
    showSpinner = false;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.black87,
        opacity: 0.8,
        inAsyncCall: showSpinner,
        child: Container(
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
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: SizedBox(height: 30)),
                SizedBox(
                  height: 140,
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/logo.png'),
                        radius: 70,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    getEmail = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    getPass = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password.',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 24.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        print(getEmail);
                        print(' password $getPass');
                        try {
                          final user = await _getAuth
                              .signInWithEmailAndPassword(
                                  email: getEmail, password: getPass);
                              

                          print(user);
                          if (user != null) {
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pushNamed(context, 'chat_screen');
                          }
                        } catch (e) {

                          setState(() {
                            showSpinner=false;
                            WarningAlertBoxCenter(messageText: 'Incorrect email or Password'
                            ,context: context);
                            
                          });
                          print(e);
                        }
                        // setState(() {
                        //   showSpinner = false;
                        // });
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Log In',
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox(height: 30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
