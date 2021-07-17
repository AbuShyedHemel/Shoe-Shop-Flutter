import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int? selectedTab;
  final void Function(int)? tabclicked;

  const BottomTabs({this.selectedTab, this.tabclicked});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 1.0,
                  blurRadius: 30.0)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabButtom(
              imagepath: 'images/home.png',
              selected: _selectedTab == 0 ? true : false,
              onPressed: () {
                widget.tabclicked!(0);
              },
            ),
            BottomTabButtom(
              imagepath: 'images/search.png',
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.tabclicked!(1);
              },
            ),
            BottomTabButtom(
              imagepath: 'images/ribbon.png',
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                widget.tabclicked!(2);
              },
            ),
            BottomTabButtom(
              imagepath: 'images/logout.png',
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ));
  }
}

class BottomTabButtom extends StatelessWidget {
  final String? imagepath;
  final bool? selected;
  final void Function()? onPressed;
  BottomTabButtom({this.imagepath, this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 24.0),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: _selected ? Colors.orangeAccent.shade700 : Colors.transparent,
          width: 2.0,
        ))),
        child: Image(
          image: AssetImage(imagepath ?? 'images/home.png'),
          width: 22,
          height: 22,
          color: _selected ? Colors.orangeAccent.shade700 : Colors.black,
        ),
      ),
    );
  }
}
