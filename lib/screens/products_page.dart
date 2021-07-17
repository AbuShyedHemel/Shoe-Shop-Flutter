import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/Database/services/firebase_services.dart';
import 'package:shoe_shop/screens/constants.dart';
import 'package:shoe_shop/widget/custom_actionbar.dart';
import 'package:shoe_shop/widget/image_swip/image_swip.dart';
import 'package:shoe_shop/widget/product_size/product_sizes.dart';

class ProductPage extends StatefulWidget {
  final String? produtID;

  const ProductPage({this.produtID});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

 // User? _user = FirebaseAuth.instance.currentUser;
  String _selectedProductSize = "0";

  Future _addCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Cart")
        .doc(widget.produtID)
        .set({"size": _selectedProductSize});
  }
  Future _addToSave() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserID())
        .collection("Save")
        .doc(widget.produtID)
        .set({"size": _selectedProductSize});
  }
  final SnackBar _snackBar =
      SnackBar(content: Text("Product Added To The Card"));

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                FutureBuilder<DocumentSnapshot>(
                    future:
                        _firebaseServices.productRef.doc(widget.produtID).get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error : ${snapshot.error}"),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic>? documentData =
                            snapshot.data!.data() as Map<String, dynamic>?;
                        List imageList = documentData!['images'];
                        List productSize = documentData['size'];

                        //set an initial size
                        _selectedProductSize = productSize[0];
                        return Column(
                          children: [
                            ImageSwip(
                              imageList: imageList,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "${documentData["name"]}",
                                style: Constants.boldHeading,
                              ),
                            ),
                            Text(
                              "\$${documentData["price"]}",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "${documentData["des"]}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Select Size",
                                    style: Constants.regularDarkText,
                                  )),
                            ),
                            ProductSizes(
                              onSelected: (size) {
                                _selectedProductSize = size;
                              },
                              productSize: productSize,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: ()async{
                                      await _addToSave();
                                        Scaffold.of(context)
                                            .showSnackBar(_snackBar);
                                    } ,
                                    child: Container(
                                        width: 65.0,
                                        height: 65.0,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        alignment: Alignment.center,
                                        child: Image(
                                          image: AssetImage("images/save.png"),
                                          height: 21.0,
                                        )),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        await _addCart();
                                        Scaffold.of(context)
                                            .showSnackBar(_snackBar);
                                      },
                                      child: Container(
                                        height: 65.0,
                                        margin: EdgeInsets.only(left: 16.0),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Add To Card",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
                    })
              ],
            ),
            CustomActionBar(
              hasBackArrow: true,
              hasttitle: false,
              hasBackground: false,
            )
          ],
        ),
      ),
    );
  }
}
