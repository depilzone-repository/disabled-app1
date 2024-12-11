import 'package:flutter/material.dart';

import '../../constants.dart';
import 'descuentos_qr.dart';

class Descuentos extends StatelessWidget{
  const Descuentos({super.key});

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(defaultPadding, 10, defaultPadding, 10),
          decoration: const BoxDecoration(
              color: Color(0xfff7ecfe),
              border: Border.fromBorderSide(
                  BorderSide(
                      color: Color(0xffe7c5fc),
                      style: BorderStyle.solid,
                      width: 2.0
                  )
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: const Text("30 % dscto", textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.w600, color: Color(0xff63089b), fontSize: 12 )),
        ),
        const SizedBox(height: defaultPadding),
        const Text("30% dscto. en servicio de Depilación Láser", textAlign: TextAlign.justify, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12)),
        const SizedBox(height: defaultPadding / 2),
        const Text("Válido hasta el 30/11/23", textAlign: TextAlign.justify, style: TextStyle(color: kGray500Color, fontWeight: FontWeight.normal, fontSize: 11)),
        const SizedBox(height: defaultPadding / 2),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: OutlinedButton(
              onPressed: () async{
                await showQrDialog(context);
              },
              style: OutlinedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  side: const BorderSide(
                      width: 2,
                      color: kDepilColor
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  )
              ),
              child: const Text(
                  "Escanear QR",
                  style: TextStyle(
                      color: kDepilColor
                  )
              )
          ),
        )

      ],
    );
  }
}