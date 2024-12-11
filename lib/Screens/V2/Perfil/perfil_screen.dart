import 'package:flutter/material.dart';

import '../../../constants.dart';

class MiPerfilScreen extends StatefulWidget{
  const MiPerfilScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MiPerfilScreenState();

}

class _MiPerfilScreenState extends State<MiPerfilScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        leading: const BackButton(
            color: kGray400Color
        ),
        backgroundColor: Colors.white,
        title: const Text('Mi Perfil', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text('Nombre'),
            trailing: Text('Pepe lucho'),
          ),
          Divider(height: 0),
          ListTile(
            title: Text('Apellido'),
            trailing: Text('Sanchez'),
          )
        ],
      ),
    );
  }
}