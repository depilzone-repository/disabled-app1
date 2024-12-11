import 'dart:async';

import 'package:depilzone_cliente/Screens/Menu/menu_principal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../NavigationScreens/Home/home_screen.dart';
import '../../../NavigationScreens/NavigationList.dart';
import '../../../Services/auth_service.dart';
import '../../../Services/shared_preferences.dart';
import '../../../constants.dart';
import '../../../shared/models/Usuario.dart';
import '../../../shared/services/shared_pref.dart';
import '../Promociones/promociones_screen.dart';
import '../QrCliente/qr_cliente_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  Usuario? currentUser;

  final SharedPref sharedPref = SharedPref();

  final _pageControlller = PageController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  bool showBar = true;
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
      // showBar = _widgetList[_currentIndex].showNabBar;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cargarUsuario();


    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   _incrementCounter();
    // });
  }


  @override
  void dispose() {
    super.dispose();
    _pageControlller.dispose();
  }


  Future<void> _cargarUsuario() async {
    Usuario? user = await getUsuario();
    setState(() {
      currentUser = user!;
    });
  }




  @override
  Widget build(BuildContext context) {

    final auth = AuthService();

    final List<NavigationList> widgetList = [
      NavigationList(
          "Inicio",
          const NavigationHomeScreen(),
          true,
          const Icon(Symbols.home_rounded),
          const Icon(Symbols.home_rounded, fill: 1),
          kDepilColor
      ),
      NavigationList(
          "Mi QR",
          const QrClienteScreen(),
          true,
          const Icon(Icons.qr_code_rounded),
          const Icon(Icons.qr_code_rounded, fill: 1),
          // const Icon(Icons.qr_code_scanner_rounded),
          // const Icon(Icons.qr_code_scanner_rounded, fill: 1),
          kDepilColor
      ),
      NavigationList(
          "Promociones",
          const PromocionesScreen(),
          true,
          counter > 0 ? Badge(
            label: Text('$counter'),
            child: const Icon(Symbols.featured_seasonal_and_gifts_rounded),
          ) : const Icon(Symbols.featured_seasonal_and_gifts_rounded),

          counter > 0 ? Badge(
            label: Text('$counter'),
            child: const Icon(Symbols.featured_seasonal_and_gifts_rounded, fill: 1, color: Color(0xff0e2443)),
          ) : const Icon(Symbols.featured_seasonal_and_gifts_rounded),

          const Color(0xff80b1ff)
      ),
    ];

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,


        // bottomNavigationBar: BottomNavigationBar(
        //
        //     iconSize: 26,
        //     backgroundColor: Colors.white,
        //     unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        //     unselectedLabelStyle: TextStyle(color: Colors.grey[400]),
        //
        //     selectedIconTheme: const IconThemeData(color: kDepilColor),
        //     selectedLabelStyle: const TextStyle(color: kDepilColor),
        //     selectedFontSize: 12,
        //
        //     fixedColor: kDepilColor,
        //     type: BottomNavigationBarType.fixed,
        //     onTap: onTapped,
        //     currentIndex: _currentIndex,
        //     items: [
        //       for( var n in widgetList )
        //         BottomNavigationBarItem(label: n.label, icon: n.icon, activeIcon: n.iconSelected)
        //     ]
        //
        // ),

        extendBody: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: _currentIndex == 1 ? Colors.white : kDepilColor,
          onPressed: () {
            setState(() {
              _currentIndex = 1;
            });
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))
          ),
          child: Icon(
              Symbols.qr_code_rounded,
              color: _currentIndex == 1 ? kIndigo : Colors.white,
              size: 35.0
          ),
        ),


        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          color: kDepilColor,
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: _currentIndex == 0 ? const BorderSide(
                            style: BorderStyle.solid,
                            width: 5,
                            color: Colors.indigo,
                            strokeAlign: BorderSide.strokeAlignInside
                        ) : BorderSide.none ,
                        bottom: BorderSide.none,
                        right: BorderSide.none,
                        left: BorderSide.none
                    ),
                  ),
                  width: 100,
                  padding: const EdgeInsets.all(10.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Symbols.home_rounded, size: 25, color: Colors.white), // Icono del botón
                      SizedBox(width: 8.0), // Espaciado entre el icono y el texto
                      Text('Mis Citas', style: TextStyle(fontSize: 10, color: Colors.white, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600)), // Texto del botón
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                splashFactory: InkRipple.splashFactory,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: _currentIndex == 2 ? const BorderSide(
                            style: BorderStyle.solid,
                            width: 5,
                            color: Colors.indigo,
                            strokeAlign: BorderSide.strokeAlignInside
                        ) : BorderSide.none ,
                        bottom: BorderSide.none,
                        right: BorderSide.none,
                        left: BorderSide.none
                    ),
                  ),
                  width: 100,
                  padding: const EdgeInsets.all(10.0),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Symbols.featured_seasonal_and_gifts_rounded, size: 25, color: Colors.white), // Icono del botón
                      SizedBox(width: 8.0), // Espaciado entre el icono y el texto
                      Text('Promociones', style: TextStyle(fontSize: 10, color: Colors.white, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600)), // Texto del botón
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


        appBar: widgetList[_currentIndex].showNabBar ?  AppBar(
          toolbarHeight: 60.0,
          backgroundColor: kDepilColor,
          titleSpacing: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                child: IconButton(
                  icon: const Icon(FeatherIcons.menu),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const MenuPrincipalScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        )
                    )
                    // // ignore: avoid_print
                    // print('eee')
                  },
                  color: Colors.white,
                ),
              ),
              // Stack(
              //   alignment: Alignment.center,
              //   children: <Widget>[
              //     IconButton(
              //       icon: Icon(Icons.mail_outline),
              //       onPressed: (){
              //         // ignore: avoid_print
              //         print('ddd');
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
              Expanded(
                child: Text(
                  'Hola, ${currentUser?.nombre}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
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
                      color: Colors.white,
                      onPressed: (){},
                      icon: const Icon(
                         FeatherIcons.bell
                      ),
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                    )
                )
              ],
            )
          ],
        ) : null,
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



        // body: FutureBuilder<bool>(
        //   future: getLoginState(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       // Mientras espera la autenticación, muestra un indicador de carga
        //       return CircularProgressIndicator();
        //     } else {
        //       if (snapshot.hasError) {
        //         // Si hay un error en la autenticación, muestra un mensaje de error
        //         return Text('Error en la autenticación');
        //       } else {
        //         return Text('Autenticado');
        //       }
        //     }
        //   },
        // ),

    );
  }
}
