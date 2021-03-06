import 'package:flutter/material.dart';
import 'package:flutter_app3/services/auth.dart';
import 'package:flutter_app3/shared/constants.dart';
import 'package:flutter_app3/shared/loading.dart';
import 'package:flutter_app3/styleguide/colors.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:flutter_app3/screens/authenticate/register_doctor.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  static String userv = '';
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';

  // final List<String> doc_user = ['User', 'Doctor'];
  String error = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text('Sign up'),
              actions: <Widget>[
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue[400]), //Background Color
                    elevation: MaterialStateProperty.all(0), //Defines Elevation
                    // shadowColor:
                    //     MaterialStateProperty.all(brown), //Defines shadowColor
                  ),
                  icon: Icon(Icons.person),
                  label: Text('SignIn'),  
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SingleChildScrollView(
                              child: Form(
                  key: _formKey,
                  child: Column(
                    
                    children: <Widget>[
                         Text(
                "Welcome To MentalEase",
                style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.20,
            ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                        validator: (val) =>
                            val.length < 6 ? 'Enter an 6+ chars long' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      DropdownButton<String>(
                        items: <String>['User', 'Doctor'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => Register.userv = value),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(pink), //Background Color
                          elevation:
                              MaterialStateProperty.all(3), //Defines Elevation
                          shadowColor: MaterialStateProperty.all(
                              pink), //Defines shadowColor
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'please valid email';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void showConsoleUsingPrint() {
    print('Console Message Using Print');
    print(Register.userv);
  }
}
