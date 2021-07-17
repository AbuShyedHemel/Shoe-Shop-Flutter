import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/Database/services/firebase_services.dart';
import 'package:shoe_shop/screens/cart_page.dart';
import 'package:shoe_shop/screens/constants.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hasttitle;
  final bool? hasBackground;

  CustomActionBar(
      {this.title, this.hasBackArrow, this.hasttitle, this.hasBackground});
  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hastitle = hasttitle ?? true;
    bool _hasbackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasbackground
              ? LinearGradient(
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1))
              : null),
      padding:
          EdgeInsets.only(top: 52.0, left: 24.0, right: 24.0, bottom: 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  width: 42.0,
                  height: 42.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage("images/arrow.png"),
                    color: Colors.white,
                    height: 12.0,
                    width: 12.0,
                  )),
            ),
          if (_hastitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: _usersRef
                      .doc(_firebaseServices.getUserID())
                      .collection("Cart")
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    int _totalItems = 0;
                    if (streamSnapshot.connectionState ==
                        ConnectionState.active) {
                      List _documents = streamSnapshot.data!.docs;
                      _totalItems = _documents.length;
                    }
                    return Text(
                      "$_totalItems",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
