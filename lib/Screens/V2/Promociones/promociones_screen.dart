import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../shared/components/skeletons/list_item.dart';
import '../../../shared/models/Usuario.dart';
import '../../../shared/services/shared_pref.dart';

class PromocionesScreen extends StatefulWidget {
  const PromocionesScreen({super.key});

  @override
  State<StatefulWidget> createState() =>  _PromocionesScreenState();
}

class _PromocionesScreenState extends State<PromocionesScreen> {

  Usuario? currentUser;
  final SharedPref sharedPref = SharedPref();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final Future<String> _promociones = Future<String>.delayed(
      const Duration(seconds: 5),
      () => "Todavia no tiene promociones activas",
  );

  @override
  Widget build(BuildContext context) {


    return Container(
      // color: kDepilColor,
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        // padding: EdgeInsets.all(defaultPadding*2),
        child: FutureBuilder(
          future: _promociones,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                      return const Column(
                          children: [
                            Expanded(child: ListItemSkeleton(itemCount: 10))
                          ]
                      );
                  case ConnectionState.done:
                      return Padding( padding: const EdgeInsets.all(defaultPadding*2), child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/mensaje_sin_promociones.svg',
                              height: 250.0,
                              width: 250.0,
                              allowDrawingOutsideViewBox: false,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Por el momento no tienes promociones activas.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: kIndigo,
                                fontWeight: FontWeight.w500,
                                // fontSize: 10
                              ),
                            )
                          ]
                      ));
                case ConnectionState.none:
                  return const Text('Press button to start.');
              }
          },

        )
    );


  }


}
