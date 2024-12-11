import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../Screens/V2/QrEvents/qr_sala_de_espera.dart';
import '../../constants.dart';

class ScannerQrListScreen extends StatefulWidget {
  const ScannerQrListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerQrListScreenState();
}

class _ScannerQrListScreenState extends State<ScannerQrListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: Colors.white,
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, defaultPadding),
                child: Text("Eventos QR", style: TextStyle(color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.w500))
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 180,
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QrSalaDeEsperaScreen()),
                      );
                    },
                    icon: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Symbols.qr_code_scanner_rounded, size: 60, color: Colors.indigo,),
                        Text("Sala de espera", style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.w500),textAlign: TextAlign.center)
                      ],
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(10),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(defaultPadding/2, defaultPadding, defaultPadding/2, defaultPadding)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(width: 4, color: Colors.indigo)
                            )
                        )
                    ),
                  )
                ),
                SizedBox(
                    width: 180,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(Symbols.qr_code_scanner_rounded, size: 60, color: Colors.indigo,),
                          Text("Descuentos", style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.w500),textAlign: TextAlign.center,)
                        ],
                      ),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all<double>(10),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.fromLTRB(defaultPadding/2, defaultPadding, defaultPadding/2, defaultPadding)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(width: 4, color: Colors.indigo)
                              )
                          )
                      ),
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
