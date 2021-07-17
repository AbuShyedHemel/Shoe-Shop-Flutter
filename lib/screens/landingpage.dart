import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/screens/homepage.dart';
import 'package:shoe_shop/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Landing extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Has Some ${snapshot.error} Error'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamsnapshot) {
                if (streamsnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Has Some ${streamsnapshot.error} Error'),
                    ),
                  );
                }

                if (streamsnapshot.connectionState == ConnectionState.active) {
                  User? _user = streamsnapshot.data as User?;

                  if (_user == null) {
                    return Login();
                  } else {
                    return Homepage();
                  }
                }

                return Container();
              });
        }
        return Container();
      },
    );
  }
}
