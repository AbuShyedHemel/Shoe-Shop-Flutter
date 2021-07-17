import 'package:flutter/material.dart';

class ImageSwip extends StatefulWidget {
  final List? imageList;

  const ImageSwip({this.imageList});

  @override
  _ImageSwipState createState() => _ImageSwipState();
}

class _ImageSwipState extends State<ImageSwip> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400.0,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList!.length; i++)
                  Container(
                    child: Image.network(
                      "${widget.imageList![i]}",
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.imageList!.length; i++)
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.easeOut,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: _selectedPage == i ? 25.0 : 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                    )
                ],
              ),
            )
          ],
        ));
  }
}
