import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/screens/products_page.dart';
import 'package:shoe_shop/widget/product_cart.dart';

class SearchTabs extends StatefulWidget {
  SearchTabs({Key? key}) : super(key: key);

  @override
  _SearchTabsState createState() => _SearchTabsState();
}

class _SearchTabsState extends State<SearchTabs> {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection('Products');

  String _searchstring = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchstring.isEmpty)
            Center(child: Container(child: Text("Search Result")))
          else
            FutureBuilder<QuerySnapshot>(
                future: _productRef.orderBy("name").startAt(
                    [_searchstring]).endAt(["$_searchstring\ufaff"]).get(),
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
                                    builder: (builder) => ProductPage(
                                          produtID: document.id,
                                        )));
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
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Container(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchstring = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    hintText: 'Search here...',
                    contentPadding: EdgeInsets.all(12.0)),
                style: TextStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
