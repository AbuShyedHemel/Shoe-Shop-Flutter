import 'package:flutter/material.dart';

class CustomBTN extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;
  final bool? outlinebtn;
  final bool? isLoading;

  const CustomBTN({this.text, this.onPressed, this.outlinebtn, this.isLoading});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _outlineBTN = outlinebtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _outlineBTN ? Colors.transparent : Colors.black,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text ?? 'Text',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _outlineBTN ? Colors.black : Colors.white),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
             child: Center(
                child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
