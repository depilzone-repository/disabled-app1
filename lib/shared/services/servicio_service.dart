import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/Servicio.dart';

Future<List<Servicio>> fetchServicios() async {

  List<Servicio> list = [];

  dynamic response = await http
      .get(Uri.parse('${dotenv.get('API_URL')}/servicio'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

  if (response.statusCode == 200) {

    Map<String, dynamic> result = json.decode(response.body);


    for ( var jdata in result['data']) {
      list.add(Servicio(
          id: jdata['id'],
          nombre: jdata['nombre'],
          nombreCorto: jdata['nombreCorto'],
          idEstado: jdata['idEstado'],
          color: jdata['color'],
      ));
    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Error al cargar los servicios');
  }

  return list;
}