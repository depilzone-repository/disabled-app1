// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../Providers/auth_service_provider.dart';
// import '../Screens/V2/Home/home_screen.dart';
// import '../Screens/V2/Login/login_screen.dart';
//
//
// class AuthWrapper extends ConsumerWidget {
//   const AuthWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authService = ref.read(authServiceProvider);
//
//     return authService.authenticatedUser != null
//         ? const HomeScreen()
//         : const LoginScreen();
//   }
// }
