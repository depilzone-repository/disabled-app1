import 'package:shared_preferences/shared_preferences.dart';

import '../shared/models/Usuario.dart';
import '../shared/services/shared_pref.dart';




// Función para guardar el estado de inicio de sesión
Future<void> saveLoginState(bool isLoggedIn) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLoggedIn', isLoggedIn);
}


// Función para obtener el estado de inicio de sesión
Future<bool> getLoginState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}


Future<void> logout() async {
  SharedPref sharedPref = SharedPref();
  sharedPref.remove("pa_user");
}


Future<Usuario?> getUsuario() async {
  SharedPref sharedPref = SharedPref();
  final usuarioJson = await sharedPref.readJson("pa_user");
  Usuario? usuario = usuarioJson != null ? Usuario.fromJson(usuarioJson) : null;

  return usuario;
}