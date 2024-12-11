import 'package:bloc/bloc.dart';

import '../Events/auth_event.dart';
import '../Models/usuario_model.dart';

class HomeBloc extends Bloc<AuthEvent, AuthState> {
  HomeBloc() : super(InitialAuthState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      // Aquí debes realizar la lógica de autenticación
      // y emitir los estados correspondientes.
      // Puedes usar try-catch para manejar errores.
      // Si la autenticación es exitosa, emite AuthenticatedState,
      // de lo contrario, emite UnauthenticatedState.

      const user = User(username: "dddd", password: "eeeee");

      UnauthenticatedState();
    }
  }
}