import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../Services/shared_preferences.dart';
import '../../../constants.dart';
import '../../../shared/models/Usuario.dart';
import '../../../shared/services/shared_pref.dart';

class QrClienteScreen extends StatefulWidget {
  const QrClienteScreen({super.key});

  @override
  State<StatefulWidget> createState() =>  _QrClienteScreenState();
}

class _QrClienteScreenState extends State<QrClienteScreen> {

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

  Future<void> _cargarUsuario() async {
    Usuario? user = await getUsuario();
    setState(() {
      currentUser = user!;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      // color: kDepilColor,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kDepilColor, Colors.indigo],
          stops: [0.25, 0.75],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )

      ),
      padding: const EdgeInsets.all(defaultPadding*2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              const Text("Mi código Qr", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: QrImageView(
                  padding: const EdgeInsets.all(defaultPadding*2),
                  backgroundColor: Colors.white,
                  data: '${currentUser?.hash}',
                  version: 4,
                  size: 250.0,
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('Utiliza tu código Qr al asistir a tu cita, obtener promociones y/o descuentos', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              const SizedBox(height: 70)
        ]
      )
    );


  }


}
