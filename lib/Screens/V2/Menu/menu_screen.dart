import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'components/menu_opciones.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        key: key,

        appBar: AppBar(
          // toolbarHeight: 70.0,
          centerTitle: true,
          leading: IconButton(
            // style: IconButton.styleFrom(
            //   // backgroundColor: Colors.red
            // ),
            onPressed: (){
              Navigator.pop(context, false);
            },
            icon:const Icon(FeatherIcons.chevronLeft, size: 30),
            //replace with our own icon data.
          ),
          backgroundColor: Colors.white,
          title: const Text('Menú Principal', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        ),

        body: Container(
            color: Colors.white,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: const MenuOpciones()
        )
    );
  }
}

