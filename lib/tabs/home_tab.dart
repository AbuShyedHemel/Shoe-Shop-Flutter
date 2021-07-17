import 'package:flutter/material.dart';
import 'package:shoe_shop/screens/products_page.dart';
import 'package:shoe_shop/widget/custom_actionbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoe_shop/widget/product_cart.dart';

class HomeTabs extends StatelessWidget {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _productRef.get(),
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
                      return ProductCart(
                        title: document['name'],
                        imageUrl: document['images'][0],
                        price: "\$${document['price']}",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ProductPage(produtID: document.id,)));
                        },
                      );
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
            title: "Home",
            hasBackArrow: false,
          )
        ],
      ),
    );
  }
}
