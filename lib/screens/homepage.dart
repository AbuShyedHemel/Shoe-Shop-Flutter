import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_shop/tabs/home_tab.dart';
import 'package:shoe_shop/tabs/save_tab.dart';
import 'package:shoe_shop/tabs/serach_tab.dart';
import 'package:shoe_shop/widget/bottomtabs.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController? _tabpagecontroller;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabpagecontroller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabpagecontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            child: Expanded(
          child: PageView(
            controller: _tabpagecontroller,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTabs(),
              SearchTabs(),
              SavePage(),
              Container(
                child: Center(
                  child: FlatButton(
                    color: Colors.red,
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text('LogOutButton')),
                ),
              )
            ],
          ),
        )),
        BottomTabs(
          selectedTab: _selectedTab,
          tabclicked: (num) {
            _tabpagecontroller!.animateToPage(num,
                duration: Duration(microseconds: 300),
                curve: Curves.easeOutCubic);
          },
        ),
      ],
    ));
  }
}
