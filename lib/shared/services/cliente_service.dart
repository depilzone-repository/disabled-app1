import 'dart:convert';
import 'dart:io';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Services/shared_preferences.dart';
import '../models/Cliente.dart';
import '../models/Usuario.dart';

Future<Cliente> getProfile() async {

  Usuario? user = await getUsuario();
  Cliente client = Cliente();

  dynamic response = await http
      .get(Uri.parse('${dotenv.get('API_URL')}/client/obtenerDatos/${user!.id}'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      }
  );

  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);

    if(result['status'] != 200){
      throw Exception('${result['message']}');
    }

    var dataJson = result['data'];

    // print(dataJson);

    client.id = dataJson['id'];
    client.nombres = dataJson['nombres'];
    client.apellidos = dataJson['apellidos'];
    client.correo = dataJson['correo'];
    client.celular1 = dataJson['celular1'];
    client.celular2 = dataJson['celular2'];
    client.foto = dataJson['foto'];
    client.genero = dataJson['genero'];
    client.alias = dataJson['seudonimo'];
    client.numeroDocumentoIdentidad = dataJson['documentoIdentidad'];
    client.tipoDocumentoIdentidad = dataJson['tipoDocumentoIdentidad'];

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al obtener tus datos');
  }

  return client;
}




Future<bool> changeAlias(String alias) async {

  Usuario? usuario = await getUsuario();

  final msg = jsonEncode({"id": usuario?.id, "alias":alias});

  dynamic response = await http
      .put(Uri.parse('${dotenv.get('API_URL')}/client/alias'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );


  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);

    // print(result);

    if(result['status'] != 200){
      throw Exception('${result['error']}');
    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al actualizar el alias');
  }

  return true;
}


Future<bool> changeEmail(String email) async {

  Usuario? usuario = await getUsuario();

  final msg = jsonEncode({"id": usuario?.id, "correo":email});

  dynamic response = await http
      .put(Uri.parse('${dotenv.get('API_URL')}/client/actualizar-correo'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );


  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);

    // print(result);

    if(result['status'] != 200){
      throw Exception('${result['error']}');
    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al actualizar el alias');
  }

  return true;
}



Future<Cliente> validateClient(int code, String phone) async {

  Cliente client = Cliente();

  dynamic response = await http
      .get(Uri.parse('${dotenv.get('API_URL')}/client/check/$code/$phone'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      }
  );

  //print('${dotenv.get('API_URL')}/client/check/${code}/${phone}');

  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);

    if(result['status'] != 200){
      throw Exception('${result['message']}');
    }

    var dataJson = result['data'];

    //print(dataJson);

    client.encontrado = dataJson['encontrado'];

    if(client.encontrado!){

      client.id = dataJson['id'];
      client.nombres = dataJson['nombres'];
      client.apellidos = dataJson['apellidos'];
      client.tieneCredenciales = dataJson['tieneCredenciales'];
    }

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al obtener tus datos');
  }

  return client;
}



Future<bool> registerCredential(int idCliente, String correo, String password) async {
  final msg = jsonEncode({"idCliente": idCliente, "correo":correo, "clave": password});

  dynamic response = await http
      .post(Uri.parse('${dotenv.get('API_URL')}/client/credentials'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );

  //print('${dotenv.get('API_URL')}/client/check/${code}/${phone}');

  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);

    print(result);

    if(result['status'] != 200){
      throw Exception('${result['message']}');
    }

    var dataJson = result['data'];

    return dataJson;

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al registrar tus credenciales');
  }

}
