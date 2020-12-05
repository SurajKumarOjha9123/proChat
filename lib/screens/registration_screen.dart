import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:proChat/screens/login_screen.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}



class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  String email;
  String pass;
  final _auth = FirebaseAuth.instance;
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
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
            // crossAxisAlignment: CrossAxisAlignment.strretch,
            children: <Widget>[
                Expanded(child: SizedBox(height: 30)),
                SizedBox(
                  height: 140,
                  child: Hero(
                    tag: 'logo',
                    child: Container(//Image.asset('images/logo.png')
                      height: 200.0,
                      child: CircleAvatar(backgroundImage: AssetImage('images/logo.png'),radius: 70,), 
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    // height: 48.0,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
                    pass=value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        try{
                          final newUser = await _auth.createUserWithEmailAndPassword(
                            email: email, password: pass);
                        if (newUser != null) {
                          setState(() {
                              showSpinner = false;
                            });
                          print(newUser);
                          Navigator.pushNamed(context, 'chat_screen');
                        }
                        }
                        catch(e)
                        {
                          setState(() {
                            showSpinner=false;
                            print(e);
                          });
                        }
                        // print(newUser);
                        setState(() {
                          showSpinner = false;
                          WarningAlertBoxCenter(messageText: 'ERROR!'
                            ,context: context);
                        });
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(child: SizedBox(height:10)),
            ],
          ),
        ),
              ),
      ),
    );
  }
}
