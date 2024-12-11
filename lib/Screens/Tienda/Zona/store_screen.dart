
import 'package:depilzone_cliente/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        key: widget.key,

        appBar: AppBar(
          // toolbarHeight: 70.0,
          centerTitle: true,
          // leading: IconButton(
          //   // style: IconButton.styleFrom(
          //   //   // backgroundColor: Colors.red
          //   // ),
          //   onPressed: (){
          //     Navigator.pop(context, false);
          //   },
          //   icon:const Icon(FeatherIcons.chevronLeft, size: 30),
          //   //replace with our own icon data.
          // ),
          backgroundColor: Colors.white,
          title: const Text('Tienda', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          leading: IconButton(
            // style: IconButton.styleFrom(
            //   // backgroundColor: Colors.red
            // ),
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(FeatherIcons.chevronLeft, size: 30),
            //replace with our own icon data.
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                Card(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                        width: 5.0,
                        color: Colors.white
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  child: InkWell(
                    onTap: () async {
                      final url = Uri.parse('https://depilzone.com.pe/depilacion-laser/');
                      await launch('https://depilzone.com.pe/depilacion-laser/');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/services/depilacion_laser.jpg'),
                        Container(
                          padding: const EdgeInsets.all(defaultPadding),
                          color: Colors.white,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Depilación Láser", style: TextStyle(fontSize: dTitle, color: dBlackColor), textAlign: TextAlign.start)
                            ],
                          ),
                        )
                      ],
                    ),
                  )

                ),


                Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                          width: 5.0,
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 3,
                    child: InkWell(
                      onTap: () async {
                        final url = Uri.parse('https://depilzone.com.pe/blanqueamiento-laser/');
                        await launch('https://depilzone.com.pe/blanqueamiento-laser/');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/images/services/blanqueamiento.jpg'),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            color: Colors.white,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Blanqueamiento", style: TextStyle(fontSize: dTitle, color: dBlackColor), textAlign: TextAlign.start)
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                ),


                Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                          width: 5.0,
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 3,
                    child: InkWell(
                      onTap: () async {
                        final url = Uri.parse('https://depilzone.com.pe/corporal-360/');
                        await launch('https://depilzone.com.pe/corporal-360/');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/images/services/corporal_360.jpg'),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            color: Colors.white,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Corporal 360", style: TextStyle(fontSize: dTitle, color: dBlackColor), textAlign: TextAlign.start)
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                ),


                Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                          width: 5.0,
                          color: Colors.white
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 3,
                    child: InkWell(
                      onTap: () async {
                        final url = Uri.parse('https://depilzone.com.pe/tratamientos-faciales/');
                        await launch('https://depilzone.com.pe/tratamientos-faciales/');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/images/services/tratamiento_facial.jpg'),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            color: Colors.white,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Tratamiento Facial", style: TextStyle(fontSize: dTitle, color: dBlackColor), textAlign: TextAlign.start)
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                ),
                
              ],
            )
          ],
        )


    );
  }

}
