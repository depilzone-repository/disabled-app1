

import '../shared/models/Usuario.dart';

class AuthService {
  Usuario? _authenticatedUser;

  Future<bool> login(String username, String password) async {
    // Lógica de autenticación (puedes comparar con una lista de usuarios registrados)
    // Retorna true si la autenticación es exitosa, de lo contrario false.

    _authenticatedUser = Usuario();
    


    return true;
  }

  Usuario? get authenticatedUser => _authenticatedUser;

}
