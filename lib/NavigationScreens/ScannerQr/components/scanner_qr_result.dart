import 'package:flutter/material.dart';

import '../../../constants.dart';


Future<bool?> showQrDialog(BuildContext context) async {

  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

        return Dialog(

          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          // insetPadding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(30.0)
          ),
          child: Container(
              alignment: Alignment.center,
              margin: null,
              padding: null,
              // width: MediaQuery.of(context).size.width,
              height: 300,
              width: 300,
              // constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppBar(
                          titleSpacing: 0.0,
                          backgroundColor: Colors.white,
                          automaticallyImplyLeading: false,
                          centerTitle: false,
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, defaultPadding / 2, 0),
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => {
                                        Navigator.pop(context, true)
                                      },
                                      color: Colors.black,
                                    )
                                ),
                                const Expanded(
                                  child: Text(
                                    '30% DSCT',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    ),
                                  ),
                                )
                              ]
                          )
                      ),
                      Expanded(

                          child: SingleChildScrollView(
                              child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/qr-code.png",
                                      width: 150,
                                      height: 150,
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    const Text("30% dscto. en servicio de Depilación Láser, válido para duos, tríos, packs y medio packs, de un solo uso.", textAlign: TextAlign.justify, style: TextStyle(color: kGray700Color, fontWeight: FontWeight.normal, fontSize: 12)),
                                  ]
                              )
                          )
                      )
                      // const SizedBox(height: defaultPadding * 2),

                    ],
                  )
              )),
        );
      });
}