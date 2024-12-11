import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Screens/Home/cliente_info_cita.dart';
import '../../../Screens/Home/home_screen.dart';
import '../../../constants.dart';

class ListViewClienteEspera extends StatelessWidget{
  final ScrollController? controller;
  const ListViewClienteEspera({
    super.key,
    this.controller
  });


  @override
  Widget build(BuildContext contenx){

    return ListView.builder(
      itemCount: 10,
      controller: controller, // set this too
      itemBuilder: (_, i) => Card(
        color: kGray100Color,
        elevation: 0,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
          horizontalTitleGap: 10,
          minVerticalPadding: defaultPadding,
          leadingAndTrailingTextStyle: const TextStyle(
              fontSize: 30
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: SvgPicture.asset(
              i % 2 == 0 ? 'assets/images/Femenino.svg' : 'assets/images/Masculino.svg',
              height: 100.0,
              width: 100.0,
              allowDrawingOutsideViewBox: false,
            ),
          ),
          title: const Text("Pepe Lucho sdfasdfasd fasdf asdf asdf asd f", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),),
          subtitle: const Text("En espera", style: TextStyle(fontSize: 12)),
          trailing: PopupMenuButton<SampleItem>(
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              PopupMenuItem<SampleItem>(
                  onTap: ()  {
                    showInfoClientDialog(context);
                  },
                  value: SampleItem.itemOne,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, defaultPadding/2, 0),
                        child: const Icon(Icons.info_rounded),
                      ),
                      const Text("Info")
                    ],
                  )
              ),
              PopupMenuItem<SampleItem>(
                  value: SampleItem.itemOne,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, defaultPadding/2, 0),
                        child: const Icon(Icons.front_hand_rounded),
                      ),
                      const Text("Atender")
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );

  }
}