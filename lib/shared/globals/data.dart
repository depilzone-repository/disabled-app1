import 'package:flutter/material.dart';

import '../models/Usuario.dart';
import '../services/shared_pref.dart';

class AppProvider extends ChangeNotifier {

  bool _isLogged = false;
  String _text = 'Iniciando...';
  Usuario? _usuario;

  String get text => _text;
  bool get isLogged => _isLogged;
  Usuario? get usuario => _usuario;

  SharedPref sharedPref = SharedPref();

  /// Updates
  Future<void> updateText(String newText) async {
    _text = newText;
    notifyListeners();
  }

  Future<void> updateLogged(bool value) async {
    _isLogged = value;
    notifyListeners();
  }

  Future<void> updateUsuario(Usuario? value) async {
    _usuario = value;
    notifyListeners();
  }


  Future<void> fetchData() async {
    print('This executes');

    // Simulamos una operación asíncrona, como una llamada a una API
    await Future.delayed(const Duration(seconds: 5));

    // Actualizamos el valor
    await updateText("Validando...");

    Usuario usuario = Usuario.fromJson(await sharedPref.read("pa_user"));
    await updateUsuario( usuario );

    await Future.delayed(const Duration(seconds: 5));

    print('This not executes');
  }


}

