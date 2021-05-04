import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Form Field',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Text Form Field'),
          ),
          body: MyForm()),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  bool _securePass = true;
  String _name = '';
  bool _button = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/images/undraw_secure_login_pdn4.png'),
        SizedBox(height: 5),
        Text(
          'Welcome',
          textScaleFactor: 2.0,
          style: TextStyle(color: Colors.blue),
        ),
        SizedBox(height: 5),
        Text('$_name'),
        SizedBox(height: 5),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: TextFormField(
                  validator: (error) {
                    if (error.isEmpty)
                      return 'Field can not be Empty';
                    else if (
                        // !error.endsWith('mail.com') &&
                        !error.contains('@'))
                      return 'Incorrect Email Pathern';
                    else
                      return null;
                  },
                  onChanged: (name) {
                    setState(() {
                      _name = name;
                    });
                  },
                  maxLength: 50,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'User name',
                      hintText: 'Enter the User name or Email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextFormField(
                  validator: (error) {
                    if (error.isEmpty)
                      return 'Field can not be Empty';
                    else if (error.length <= 5)
                      return 'Length must be greater then five';
                    else
                      return null;
                  },
                  maxLength: 30,
                  obscureText: _securePass,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _securePass = !_securePass;
                            });
                          },
                          icon: Icon(_securePass
                              ? Icons.remove_red_eye
                              : Icons.security_rounded)),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter the Password'),
                ),
              ),
              SizedBox(height: 5),
              Material(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  splashColor: Colors.indigo,
                  onTap: () {
                    validation();
                  },
                  child: AnimatedContainer(
                    alignment: Alignment.center,
                    height: 50,
                    width: _button ? 150 : 50,
                    duration: Duration(seconds: 1),
                    child: _button ? Text('Login') : Icon(Icons.done),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void validation() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _button = !_button;
      });
      await Future.delayed(Duration(seconds: 1));
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Alert!!'),
                content: Text('Successfully Logged in'),
              ));
      _formKey.currentState.reset();
      setState(() {
        _button = true;
      });
    }
  }
}
