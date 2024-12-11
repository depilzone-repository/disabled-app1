import 'dart:convert';
import 'dart:io';


import 'package:depilzone_cliente/shared/services/shared_pref.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../Services/shared_preferences.dart';
import '../models/Response.dart';
import '../models/Usuario.dart';

Future<Usuario> Login(String email, String password) async {


  Usuario usuario = Usuario(hash: 'asdfasdfasd-asdfasdfasd-fasdfasdf', correo: 'asdfasdfasdfasdfads');

  final msg = jsonEncode({"clave":password,"correo":email});

  final url = dotenv.env['API_URL'];
  print(url);
  print('$url/client/login');

  dynamic response = await http
      .post(Uri.parse('$url/client/login'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );

  if (response.statusCode == 200) {

    print(jsonDecode(response.body));

    Map<String, dynamic> result = jsonDecode(response.body);

    if(result['data']['id'] == 0){
      throw Exception('${result['data']['mensaje']}');
    }

    usuario.id = result['data']['id'];
    usuario.nombre = '${result['data']['nombres']}';
    usuario.apellido = '${result['data']['apellidos']}';

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al obtener tus datos');
  }

  return usuario;
}



Future<bool> validatePassword(String password) async {

  Usuario? usuario = await getUsuario();

  final msg = jsonEncode({"id": usuario?.id, "clave":password});

  bool output = false;

  dynamic response = await http
      .put(Uri.parse('${dotenv.get('API_URL')}/client/validar-clave'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );


  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);
    print("login");
    print(result);

    output = result['status'] == 200;

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al actualizar el alias');
  }

  return output;
}




Future<bool> generateOtp(String correo) async {

  Usuario? usuario = await getUsuario();

  final msg = jsonEncode({"id": usuario?.id, "correo": correo});

  bool output = false;

  // print(msg);

  dynamic response = await http
      .post(Uri.parse('${dotenv.get('API_URL')}/client/generar-otp'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );


  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);
    // print(result);

    output = result['status'] == 200;

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al generar el código OTP');
  }

  return output;
}



Future<Response> validateOtp(String otp) async {

  Usuario? usuario = await getUsuario();

  final msg = jsonEncode({"id": usuario?.id, "otp":otp});

  bool output = false;

  dynamic response = await http
      .put(Uri.parse('${dotenv.get('API_URL')}/client/validar-otp'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: msg
  );


  if (response.statusCode == 200) {

    Map<String, dynamic> result = jsonDecode(response.body);
    Response responseJson = Response(
      data : result['data'],
      error : result['error'],
      status : result['status']
    );

    return responseJson;

  }
  else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Ocurrio un error al validar el otp');
  }
  //
  // return output;
}


Future<void> logout() async {
  SharedPref sharedPref = SharedPref();
  sharedPref.remove("pa_user");
}
