import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/Database/services/firebase_services.dart';
import 'package:shoe_shop/screens/products_page.dart';
import 'package:shoe_shop/widget/custom_actionbar.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<SavePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserID())
                  .collection("Save")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error : ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(top: 128.0, bottom: 12.0),
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                          produtID: document.id,
                                        )));
                          },
                          child: FutureBuilder<DocumentSnapshot>(
                              future: _firebaseServices.productRef
                                  .doc(document.id)
                                  .get(),
                              builder: (context, productsnapshot) {
                                if (productsnapshot.hasError) {
                                  return Container(
                                    child: Center(
                                        child:
                                            Text("${productsnapshot.error}")),
                                  );
                                }
                                if (productsnapshot.connectionState ==
                                    ConnectionState.done) {
                                  Map? _productMap =
                                      productsnapshot.data!.data() as Map?;

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 24.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90.0,
                                          height: 90.0,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                "${_productMap!['images'][0]}",
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${_productMap['name']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                ),
                                                child: Text(
                                                  "\$${_productMap['price']}",
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.deepOrange,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                "Size: ${document['size']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }));
                    }).toList(),
                  );
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            hasBackground: false,
            hasBackArrow: true,
            title: "Save",
          )
        ],
      ),
    );
  }
}
