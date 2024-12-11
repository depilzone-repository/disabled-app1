import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../constants.dart';


class QrSalaDeEsperaScreen extends StatefulWidget {
  const QrSalaDeEsperaScreen({super.key});

  @override
  State<StatefulWidget> createState() => _QrSalaDeEsperaScreenState();
}

class _QrSalaDeEsperaScreenState extends State<QrSalaDeEsperaScreen> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white, //OR Colors.red or whatever you want
        ),
        title: const Text(
          'Sala de espera',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
            children: <Widget>[
                Expanded(
                  child: _buildQrView(context)
                ),
            ]
        ),
      )
    );
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

          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(result!.code != null ? result!.code!: "aaa"))
          );

          // await showQrDialog(context).then((bool? val) {
          //
          //   // ignore: avoid_print

          //   if(val != null){
          //     controller.resumeCamera();
          //
          //     // ignore: avoid_print

          //   }
          //
          //   // formControllers['password']?.text = val ? val : '';
          //   // setState(() {
          //   //   clave = val;
          //   // });
          // });

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