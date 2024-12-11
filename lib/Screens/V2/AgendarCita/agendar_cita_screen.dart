import 'package:flutter/material.dart';

import '../../../constants.dart';

class AgendarCitaScreen extends StatelessWidget{
  const AgendarCitaScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: key,
      appBar: AppBar(
        leading: const BackButton(
          color: kGray400Color
        ),
        backgroundColor: Colors.white,
        title: const Text('Agendar Cita', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ),
      body: Container(
        color: kDepilColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: Text("Agendar Cita"),
        ),
      ),
    );
  }
}