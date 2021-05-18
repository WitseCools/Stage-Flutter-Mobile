import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';
import '../providers/User.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LogInScreen extends StatelessWidget {
  static const spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 300,
                child: Image(
                    key: Key("Logo"), image: AssetImage('images/logo.png'))),
            Container(
              margin: EdgeInsets.only(top: 20, right: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor("#222C4A"),
                        fontSize: 30),
                  ),
                  Text("Log in to continue")
                ],
              ),
            ),
            AuthCard(),
          ],
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Provider.of<User>(context, listen: false)
        .logIn(_authData['email'], _authData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(30),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  key: ValueKey("Email"),
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person), labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    _authData['email'] = value;
                  }),
              TextFormField(
                key: ValueKey("Pass"),
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                onSaved: (value) {
                  _authData['password'] = value;
                },
              ),
              Container(
                padding: EdgeInsets.all(50),
                child: RaisedButton(
                  key: ValueKey("Button"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                  onPressed: () {
                    _submit();
                  },
                  padding: EdgeInsets.all(10.0),
                  color: HexColor("#222C4A"),
                  textColor: Colors.white,
                  child: Text("Log In", style: TextStyle(fontSize: 15)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
