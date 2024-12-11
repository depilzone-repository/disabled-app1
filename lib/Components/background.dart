import 'dart:async';

import 'package:flutter/material.dart';

import 'package:material_symbols_icons/symbols.dart';

import '../NavigationScreens/NavigationList.dart';
import '../NavigationScreens/ScannerQr/scanner_qr_screen.dart';
import '../Screens/V2/Menu/menu_screen.dart';
import '../Screens/Welcome/welcome_screen.dart';
import '../constants.dart';

class Background extends StatefulWidget {
  final Widget child;

  const Background({
    super.key,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  });

  final String topImage, bottomImage;

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool showBar = true;

  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }


  int _currentIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _incrementCounter();
    });
  }


  @override
  Widget build(BuildContext context) {

    final List<NavigationList> widgetList = [

    ];

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,


      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        backgroundColor: Colors.white,
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        unselectedLabelStyle: TextStyle(color: Colors.grey[400]),

        selectedIconTheme: const IconThemeData(color: kDepilColor),
        selectedLabelStyle: const TextStyle(color: kDepilColor),
        selectedFontSize: 12,

        fixedColor: kDepilColor,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        currentIndex: _currentIndex,
        items: [
          for( var n in widgetList )
            BottomNavigationBarItem(
                label: n.label,
                icon: n.icon,
                activeIcon: n.iconSelected,
            )
        ]
      ),

      appBar: widgetList[_currentIndex].showNabBar ?  AppBar(
        titleSpacing: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                        builder: (context) => const MenuScreen(),
                        ),
                      )
                      // // ignore: avoid_print

                    },
                    color: kDepilColor,
                ),
            ),
            // Stack(
            //   alignment: Alignment.center,
            //   children: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.mail_outline),
            //       onPressed: (){
            //         // ignore: avoid_print

            //       },
            //     ),
            //     Positioned(
            //       top: 12.0,
            //       right: 10.0,
            //       width: 10.0,
            //       height: 10.0,
            //       child: Container(
            //         decoration: const BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: kDepilColor,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            const Expanded(
              child: Text(
                'Hola, Yosel Edwin ',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        actions: <Widget>[
            Row(
                children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(defaultPadding / 2, 0, defaultPadding, 0),
                        child: IconButton(
                            color: kDepilColor,
                            onPressed: (){},
                            icon: const Icon(
                                Symbols.notifications_rounded
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: kDepilLightColor
                            ),
                        )
                    )
                ],
            )
        ],
      ) : null,
      drawer:  Drawer(
        width: 320.0,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: kGradiantVerticalColor
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Cerrar Sesión'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const WelcomeScreen();
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Scanear QR'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ScannerQrScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // body: SizedBox(
      //   width: double.infinity,
      //   height: MediaQuery.of(context).size.height,
      //   child: Stack(
      //     alignment: Alignment.center,
      //     children: <Widget>[
      //       Positioned(
      //         top: 0,
      //         left: 0,
      //         child: Image.asset(
      //           widget.topImage,
      //           width: 120,
      //         ),
      //       ),
      //       Positioned(
      //         bottom: 0,
      //         right: 0,
      //         child: Image.asset(widget.bottomImage, width: 120),
      //       ),
      //       SafeArea(child: widget.child),
      //     ],
      //   ),
      // ),
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: widgetList[_currentIndex].widget
      )
    );
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
      // showBar = _widgetList[_currentIndex].showNabBar;
    });
  }



}
