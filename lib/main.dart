import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _securePassword = true;
  String _name = "", _passwordError, _userError;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TextField',
      home: Scaffold(
        appBar: AppBar(
          title: Text('TextField'),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/undraw_secure_login_pdn4.png'),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(color: Colors.blue),
                      textScaleFactor: 2.0,
                    ),
                    Text(_name),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 8),
                      child: TextField(
                        maxLength: 50,
                        controller: _userController,
                        onChanged: (name) {
                          setState(() {});
                          _name = name;
                        },
                        decoration: InputDecoration(
                            errorText: _userError,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelText: 'Name',
                            hintText: 'Enter the User Name or Email'),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextField(
                        controller: _passwordController,
                        maxLength: 20,
                        obscureText: _securePassword,
                        decoration: InputDecoration(
                            errorText: _passwordError,
                            prefixIcon: IconButton(
                                onPressed: () {
                                  setState(() {});
                                  _securePassword = !_securePassword;
                                },
                                icon: Icon(_securePassword
                                    ? Icons.remove_red_eye
                                    : Icons.security_rounded)),
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter the User Password'),
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) => MaterialButton(
                        onPressed: () {
                          validation(context);
                        },
                        color: Colors.blue,
                        child: Text('login'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void validation(BuildContext context) {
    setState(() {});
    if (_passwordController.text.isEmpty) {
      _passwordError = "Field can not be Empty";
    } else if (_passwordController.text.length <= 5) {
      _passwordError = "Length must be greater than 5";
    } else {
      _passwordError = null;
    }
    if (_userController.text.isEmpty) {
      _userError = "Field Can not be Empty";
    } else if (!_userController.text.endsWith(".com")) {
      _userError = "Wrong User Email Pathern";
    } else {
      _userError = null;
    }
    if (_userError == null && _passwordError == null) {
      alertDialog(context);
    }
  }

  void alertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Alert!!!'),
              content: Text('User successfully Logged in'),
            ));
  }
}
