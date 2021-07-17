import 'package:flutter/material.dart';

class ProductSizes extends StatefulWidget {
  final List? productSize;
  final Function(String)? onSelected;

  const ProductSizes({Key? key, this.productSize, this.onSelected});

  @override
  _ProductSizesState createState() => _ProductSizesState();
}

class _ProductSizesState extends State<ProductSizes> {
  int? _selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize!.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.onSelected!("${widget.productSize![i]}");
                  _selected = i;
                });
              },
              child: Container(
                height: 42.0,
                width: 42.0,
                decoration: BoxDecoration(
                    color: _selected == i
                        ? Colors.deepOrange.shade500
                        : Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  "${widget.productSize![i]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _selected == i ? Colors.white : Colors.black,
                      fontSize: 16.0),
                ),
              ),
            )
        ],
      ),
    );
  }
}
