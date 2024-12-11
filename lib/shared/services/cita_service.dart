import 'dart:convert';


import 'package:http/http.dart' as http;

import '../../Services/shared_preferences.dart';
import '../models/Cita.dart';
import '../models/Usuario.dart';
import '../models/Zonas.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<Cita>> fetchCitas() async {

  Usuario? user = await getUsuario();

  List<Cita> list = [];

  String url = '${dotenv.get('API_URL')}/cita/client/${user?.id!}';

  dynamic response = await http
      .get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode == 200) {

    Map<String, dynamic> result = json.decode(response.body);

    // print(result);

    for ( var jdata in result['data']) {
      list.add(Cita(
          idCita: jdata['id'],
          fecha: DateTime.parse(jdata['fecha']),
          fechaHoraFin: DateTime.parse(jdata['fechaHoraFin']),
          hora: jdata['hora'],
          idServicio: jdata['idServicio'],
          servicio: jdata['servicio'],
          tipoCita: jdata['tipoCita'],
          estado: jdata['estado'],
          colorEstado: jdata['colorEstado'],
          zonas: []
      ));
    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');

  }

  return list;
}


Future<List<GrupoCita>> fetchCitasByService(int idClient, int idService) async {

  List<GrupoCita> list = [];

  String url = '${dotenv.get('API_URL')}/cita/cliente/$idClient/servicio/$idService';
  // print(url);

  dynamic response = await http
      .get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode == 200) {

    Map<String, dynamic> result = json.decode(response.body);

    // print(result);

    for ( var jdata in result['data']) {
      final grupo = GrupoCita(
        mes: jdata['mes'],
        anio: jdata['anio'],
        texto: jdata['texto'],
        citas: []
      );

      for( var jcita in jdata['citas'] ){
        grupo.citas!.add(Cita(
            idCita: jcita['id'],
            fecha: DateTime.parse(jcita['fecha']),
            fechaHoraFin: DateTime.parse(jcita['fechaHoraFin']),
            hora: jcita['hora'],
            idServicio: jcita['idServicio'],
            servicio: jcita['servicio'],
            tipoCita: jcita['tipoCita'],
            estado: jcita['estado'],
            colorEstado: jcita['colorEstado'],
            zonas: []
        ));
      }

      list.add(grupo);

    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load grupo de citas');

  }

  return list;
}




Future<Cita> fetchCita(int idCita) async {

  Cita? cita;
  String url = '${dotenv.get('API_URL')}/cita/$idCita';

  dynamic response = await http
      .get(Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode == 200) {

    Map<String, dynamic> result = json.decode(response.body);

    // print(result);
    var jdata = result['data'];

    cita = Cita(
        idCita: jdata['id'],
        fecha: DateTime.parse(jdata['fecha']),
        fechaHoraFin: DateTime.parse(jdata['fechaHoraFin']),
        hora: jdata['hora'],
        idServicio: jdata['idServicio'],
        servicio: jdata['servicio'],
        tipoCita: jdata['tipoCita'],
        zonas: [],
        sede: jdata['sede'],
        estado: jdata['estado'],
        colorEstado: jdata['colorEstado'],
    );

    for ( var zona in jdata['zonas']) {
      print(zona['nombre']);
      cita.zonas!.add(Zona(
          id: zona['id'],
          nombre: zona['nombre'],
          sesion: zona['sesion']
      ));
    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');

  }

  return cita;
}