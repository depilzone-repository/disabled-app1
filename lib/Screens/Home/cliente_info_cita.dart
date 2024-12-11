import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';




Widget _dialog(BuildContext context) {
  return Dialog(

    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    insetPadding: const EdgeInsets.all(defaultPadding),
    shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(30.0)
    ),


    insetAnimationCurve: Curves.slowMiddle,
    child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // constraints: BoxConstraints(maxHeight: 350),
        child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: CloseButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                      child: SvgPicture.asset(
                        'assets/images/Femenino.svg',
                        height: 100.0,
                        width: 100.0,
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(defaultPadding, 0, 0, 0),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Pepe Lucho asdfasdf asdfasdf',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color:  Color(0xff0e2443),
                                        fontSize: 18,
                                        height: 1
                                    )
                                ),
                                Text(
                                  '00011',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: kGray500Color,
                                      height: 1.5
                                  ),
                                )
                              ],
                            )
                        )
                    )
                  ],
                ),
                const SizedBox(height: defaultPadding),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        children: [
                                          Text("N° Cita:"),
                                          Expanded(child: Text( "00001412", textAlign: TextAlign.right,))
                                        ],
                                      )
                                  ),
                                  const Divider(height: 0),
                                  const Padding(
                                      padding: EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        children: [
                                          Text("Servicio:"),
                                          Expanded(child: Text( "Depilación", textAlign: TextAlign.right,))
                                        ],
                                      )
                                  ),
                                  const Divider(height: 0),
                                  const Padding(
                                      padding: EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        children: [
                                          Text("Fecha Cita:"),
                                          Expanded(child: Text( "01/12/2023", textAlign: TextAlign.right,))
                                        ],
                                      )
                                  ),
                                  const Divider(height: 0),
                                  const Padding(
                                      padding: EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        children: [
                                          Text("Hora Inicio:"),
                                          Expanded(child: Text( "04:10 AM", textAlign: TextAlign.right,))
                                        ],
                                      )
                                  ),
                                  const Divider(height: 0),
                                  Padding(
                                      padding: const EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Zonas:"),
                                          Expanded(
                                              child: Container(
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      for(int i=0; i<5; i++)
                                                        const Text("Piernas Completas S1", textAlign: TextAlign.right, style: TextStyle(height: 2)),
                                                    ]),
                                              ))
                                        ],
                                      )
                                  ),
                                  const Divider(height: 0),
                                  Padding(
                                      padding: const EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Zonas:"),
                                          Expanded(
                                              child: Container(
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      for(int i=0; i<5; i++)
                                                        const Text("Piernas Completas S1", textAlign: TextAlign.right, style: TextStyle(height: 2)),
                                                    ]),
                                              ))
                                        ],
                                      )
                                  ),
                                  const Divider(height: 0),
                                  Padding(
                                      padding: const EdgeInsets.all(defaultPadding),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Zonas:"),
                                          Expanded(
                                              child: Container(
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      for(int i=0; i<5; i++)
                                                        const Text("Piernas Completas S1", textAlign: TextAlign.right, style: TextStyle(height: 2)),
                                                    ]),
                                              ))
                                        ],
                                      )
                                  ),
                                ],
                              )
                            ]
                        )
                    )
                )
                // const SizedBox(height: defaultPadding * 2),

              ],
            )
        )),


  );
}



void showInfoClientDialog(BuildContext context)  {

  showGeneralDialog(
      barrierDismissible: false,
      context: context,
      pageBuilder: (ctx, a1, a2) {

        return Container();
      },


      transitionBuilder: (ctx, a1, a2, child) {
        return Transform.rotate(
          angle: 0,
          child: _dialog(ctx),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
  );
}