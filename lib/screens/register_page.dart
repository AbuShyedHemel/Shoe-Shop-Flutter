import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/screens/constants.dart';
import 'package:shoe_shop/screens/loginpage.dart';
import 'package:shoe_shop/widget/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Future<String?> _creatAccount() async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _registerEmail, password: _registerpassword);
      User? user = result.user;
      user!.updateDisplayName(_name);
      return null;
    } on FirebaseException catch (e) {
      if (e.code == 'weak password') {
        return 'The Password is Too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The Acoount is already Exists';
      }
      return e.message;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.red),
            ),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Close Dialog",
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.w800),
                ),
              )
            ],
          );
        });
  }

  void _submitform() async {
    String? _creatfeedback = await _creatAccount();
    if (_creatfeedback != null) {
      _alertDialogBuilder(_creatfeedback);
      setState(() {
        _registerfromLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerfromLoading = false;
  String _registerEmail = "";
  String _registerpassword = "";
  String _registerconfirmpassword = "";
  String _name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 24.0),
                child: Text(
                  'Welcome There\n Please Register to your Account',
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2f2),
                        borderRadius: BorderRadius.circular(12.6)),
                    child: TextField(
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 24.0)),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2f2),
                        borderRadius: BorderRadius.circular(12.6)),
                    child: TextField(
                      onSubmitted: (value) => _submitform(),
                      obscureText: true,
                      onChanged: (value) {
                        _registerpassword = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 24.0)),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2f2),
                        borderRadius: BorderRadius.circular(12.6)),
                    child: TextField(
                      obscureText: true,
                      onChanged: (value) {
                        _registerconfirmpassword = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Confirm Password',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 24.0)),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2f2),
                        borderRadius: BorderRadius.circular(12.6)),
                    child: TextField(
                      onChanged: (value) {
                        _name = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 24.0)),
                      style: Constants.regularDarkText,
                    ),
                  ),
                  CustomBTN(
                    text: 'Creat New Account',
                    onPressed: () {
                      //_alertDialogBuilder();
                      setState(() {
                        if (_registerpassword != _registerconfirmpassword) {
                          Fluttertoast.showToast(
                            msg: "Password does't Match",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        } else {
                          _submitform();
                          _registerfromLoading = true;
                        }
                      });
                    },
                    //_registerfromLoading = true;
                    isLoading: _registerfromLoading,
                    outlinebtn: false,
                  ),
                ],
              ),
              CustomBTN(
                text: 'Already Have An Account',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                outlinebtn: true,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
