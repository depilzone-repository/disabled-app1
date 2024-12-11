import 'package:flutter/material.dart';

class Configuration extends ChangeNotifier {

   ValueNotifier<String> globalLazyProcedure = ValueNotifier<String>("Iniciando...");
   ValueNotifier<bool> globalIsLogged = ValueNotifier<bool>(false);

    setGlobalLazyProcedure(String value)  {
      globalLazyProcedure.value = value;
      notifyListeners();
    }
    getGlobalLazyProcedure()  {
      return globalLazyProcedure.value;
    }

    setGlobalIsLogged(bool value)  {
      globalIsLogged.value = value;
      notifyListeners();
    }
    getGlobalIsLogged() async {
      return globalIsLogged.value;
    }

}