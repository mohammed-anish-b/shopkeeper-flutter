import 'package:flutter/material.dart';
import 'package:shopkeeper/widgets/sidemenu.dart';
import 'package:email_validator/email_validator.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _signup = GlobalKey<FormState>();
  String username;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      drawer: Menu(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _signup,
              child :Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username'
                      ),
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
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email'
                      ),
                      onChanged: (val) {
                        this.email = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        } else if (!EmailValidator.Validate(value,true)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password'
                      ),
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
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                    child: Builder(
                        builder: (context) => RaisedButton(
                        child: Text("Sign Up"),
                        onPressed: () async {
                          if (_signup.currentState.validate()) {
                            // dynamic res = await _auth.registerWithEmailAndPassword(email, password);
                            Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Account Registered')));
                          } else {
                            Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('You missied some mandatory fields ')));
                          }
                        },
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}