import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Screens/Home/descuentos_qr.dart';
import '../../Screens/V2/Home/home_screen.dart';
import '../../constants.dart';


class ScannerQrScreen extends StatefulWidget {
  const ScannerQrScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScannerQrScreenState();
}

class _ScannerQrScreenState extends State<ScannerQrScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                // controller!.dispose();
                Navigator.of(context).pop( const HomeScreen());
              },
              color: Colors.white,
              icon: const Icon(Symbols.arrow_back_rounded),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("Escanear Código Qr", style: TextStyle(fontSize: 16, color: Colors.white))
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: _buildQrView(context)
            ),
            // Expanded(
            //   flex: 1,
            //   child: FittedBox(
            //     fit: BoxFit.contain,
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: <Widget>[
            //         if (result != null)
            //           Text(
            //               'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //         else
            //           const Text('Scan a code'),
            //         // Row(
            //         //   mainAxisAlignment: MainAxisAlignment.center,
            //         //   crossAxisAlignment: CrossAxisAlignment.center,
            //         //   children: <Widget>[
            //         //     Container(
            //         //       margin: const EdgeInsets.all(8),
            //         //       child: ElevatedButton(
            //         //           onPressed: () async {
            //         //             await controller?.toggleFlash();
            //         //             setState(() {});
            //         //           },
            //         //           child: FutureBuilder(
            //         //             future: controller?.getFlashStatus(),
            //         //             builder: (context, snapshot) {
            //         //               return Text('Flash: ${snapshot.data}');
            //         //             },
            //         //           )),
            //         //     ),
            //         //     Container(
            //         //       margin: const EdgeInsets.all(8),
            //         //       child: ElevatedButton(
            //         //           onPressed: () async {
            //         //             await controller?.flipCamera();
            //         //             setState(() {});
            //         //           },
            //         //           child: FutureBuilder(
            //         //             future: controller?.getCameraInfo(),
            //         //             builder: (context, snapshot) {
            //         //               if (snapshot.data != null) {
            //         //                 return Text(
            //         //                     'Camera facing ${describeEnum(snapshot.data!)}');
            //         //               } else {
            //         //                 return const Text('loading');
            //         //               }
            //         //             },
            //         //           )),
            //         //     )
            //         //   ],
            //         // ),
            //         // Row(
            //         //   mainAxisAlignment: MainAxisAlignment.center,
            //         //   crossAxisAlignment: CrossAxisAlignment.center,
            //         //   children: <Widget>[
            //         //     Container(
            //         //       margin: const EdgeInsets.all(8),
            //         //       child: ElevatedButton(
            //         //         onPressed: () async {
            //         //           await controller?.pauseCamera();
            //         //         },
            //         //         child: const Text('pause',
            //         //             style: TextStyle(fontSize: 20)),
            //         //       ),
            //         //     ),
            //         //     Container(
            //         //       margin: const EdgeInsets.all(8),
            //         //       child: ElevatedButton(
            //         //         onPressed: () async {
            //         //           await controller?.resumeCamera();
            //         //         },
            //         //         child: const Text('resume',
            //         //             style: TextStyle(fontSize: 20)),
            //         //       ),
            //         //     )
            //         //   ],
            //         // ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: kDepilColor,
          borderRadius: 30,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {

      controller.pauseCamera(); //

      setState(() async {
        result = scanData;

        // // ignore: avoid_print


        if (result != null){

          await showQrDialog(context).then((bool? val) {

            // ignore: avoid_print

            if(val != null){
              controller.resumeCamera();

              // ignore: avoid_print

            }

            // formControllers['password']?.text = val ? val : '';
            // setState(() {
            //   clave = val;
            // });
          });

        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}