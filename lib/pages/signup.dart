import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopkeeper/services/keycloak_service.dart';
import 'package:shopkeeper/widgets/sidemenu.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  KeycloakService keycloak = KeycloakService();
  final _signup = GlobalKey<FormState>();
  String username;
  String email;
  String password;
  String confirmPassword;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage('images/logo.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter)),
          ),
          Form(
            key: _signup,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 370),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(23),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: TextFormField(
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'SFUIDisplay'),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                            onChanged: (val) {
                              this.username = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter username';
                              } else if (value.length < 4) {
                                return 'minimum length of username is 4';
                              }
                              return null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: TextFormField(
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'SFUIDisplay'),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.lock_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                            onChanged: (val) {
                              this.email = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email';
                              } else if (!EmailValidator.Validate(
                                  value, true)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'SFUIDisplay'),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                            onChanged: (val) {
                              this.password = val;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              } else if (value.length < 6) {
                                return 'Minimum password length is 6';
                              }
                              return null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Container(
                        child: TextFormField(
                            obscureText: true,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'SFUIDisplay'),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Confirm password',
                                prefixIcon: Icon(Icons.lock_outline),
                                labelStyle: TextStyle(fontSize: 15)),
                            onChanged: (val) {
                              this.password = val;
                            },
                            validator: (value) {
                              if (value != this.password) {
                                return 'Passsword mismatch';
                              }
                              return null;
                            }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Builder(
                        builder: (context) => MaterialButton(
                          onPressed: () async {
                            if (_signup.currentState.validate()) {
                              await keycloak.createUser(username , email , password);
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Account Registered')));
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'You missied some mandatory fields ')));
                            }
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color(0xffff2d55),
                          elevation: 0,
                          minWidth: 400,
                          height: 50,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account?",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                              )
                            ),
                            TextSpan(
                              text: " login",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffff2d55),
                                fontSize: 15,
                              ),
                              recognizer: new TapGestureRecognizer()..onTap = () {
                                Navigator.pushReplacementNamed(context, '/login');
                              }
                            )
                          ]
                        ),
                      ),
                    ),
                  )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
