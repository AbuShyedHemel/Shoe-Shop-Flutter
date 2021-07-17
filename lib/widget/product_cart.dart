import 'package:flutter/material.dart';
import 'package:shoe_shop/screens/constants.dart';


class ProductCart extends StatelessWidget {
  final Function()? onPressed;
  final String? imageUrl;
  final String? title;
  final String? price;
  final String? productID;

  const ProductCart(
      {Key? key, this.onPressed, this.imageUrl, this.title, this.price, this.productID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 354,
        margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                "$imageUrl",
                width: 800.0,
                height: 400.0,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title!,
                      style: Constants.regularDarkText,
                    ),
                    Text(
                      price!,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontWeight: FontWeight.w900),
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
}
