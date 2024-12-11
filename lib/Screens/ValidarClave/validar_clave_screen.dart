import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../constants.dart';
import '../../shared/services/auth_service.dart';
import '../../shared/utils/colors.dart';

class ValidarClaveScreen extends StatefulWidget{
  const ValidarClaveScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ValidarClaveScreenState();

}

class _ValidarClaveScreenState extends State<ValidarClaveScreen>{

  String _title = 'Ingresa tu clave';
  bool _error = false;
  String password = '';
  final List<int> numbers = [0,1,2,3,4,5,6,7,8,9];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    numbers.shuffle();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  setError(String error) {
    setState(() {
      _title = error;
      _error = true;
    });
    Future.delayed(const Duration(seconds: 3), clearError);
  }

  clearError(){
    setState(() {
      _title = 'Ingresa tu clave';
      _error = false;
      password = '';
    });
  }

  result(bool value, BuildContext context){
    if(!value){
      setError('Contraseña incorrecta');
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      return;
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    Navigator.pop(context, true);
  }

  intoPassword(String number) async {
    if(password.length == 6){
      return;
    }
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      password = password + number;
    });

    if(password.length == 6){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enviando datos...'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      await validatePassword(password).then((bool value){
        result(value, context);
      }).catchError((err){
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('${err.message}'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
      });
    }
  }

  @override
  Widget build(BuildContext context){

    List numeros = numbers;

    return Scaffold(
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBar(
                      leading: SizedBox(
                          child: IconButton(
                              icon: const Icon(FeatherIcons.x, color: Colors.black, size: 40),
                              onPressed: () => Navigator.pop(context, false)
                          )
                      ),
                      backgroundColor: Colors.white
                  ),
                  const SizedBox(height: defaultPadding * 4),
                  // Text(
                  //   password,
                  //   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  // ),
                  // Text(
                  //   _title,
                  //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: _error ? HexColor('#FF4747') : Colors.black),
                  // ),
                  const SizedBox(height: 10),
                  // Contador de caracteres
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (int i = 0; i < 6; i++)
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: (_error ? HexColor('#FF4747') : kDepilColor), width: 1),
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      color: password.length >= (i+1) ? (_error ? HexColor('#FF4747') : kDepilColor) : null,
                                      boxShadow: password.length >= (i+1) ? [
                                        BoxShadow(
                                          color: _error ? HexColor('#FFCCCC') : kDepilLightColor,
                                          spreadRadius: 3,
                                          blurRadius: 0,
                                          offset: const Offset(0, 0), // changes position of shadow
                                        )] : null
                                  ),
                                ),
                            ],
                          )
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 2),



                  // Botones
                  Column(
                      children: <Widget>[
                        for(int i = 0; i < 4; i++)
                          if(i < 3)
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 270,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          for( int b = 0; b < 3 ; b++ )
                                            SizedBox(
                                              width: 70,
                                              height: 70,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  await intoPassword(numeros[(i*3)+b].toString());
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(kGray100Color),
                                                    elevation: MaterialStateProperty.all(0.0)
                                                ),
                                                child: Text(numeros[(i*3)+b].toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30 , color: Colors.black)),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: defaultPadding * 2),
                              ],
                            )

                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 270,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 60,height: 60),
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await intoPassword(numeros[9].toString());
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(kGray100Color),
                                              elevation: MaterialStateProperty.all(0.0)
                                          ),
                                          child: Text(numeros[9].toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black)),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: IconButton(
                                              color: kDepilColor,
                                              icon: const Icon(Icons.backspace),
                                              tooltip: 'Borrar',
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                                  elevation: MaterialStateProperty.all(0.0)
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  // This call to setState tells the Flutter framework that something has
                                                  // changed in this State, which causes it to rerun the build method below
                                                  // so that the display can reflect the updated values. If we changed
                                                  // _counter without calling setState(), then the build method would not be
                                                  // called again, and so nothing would appear to happen.
                                                  password = password.isNotEmpty ? password.substring(0, password.length - 1) : '';
                                                });
                                              }
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                      ]
                  ),
                ],
              )
          ),
        ],
      ),

    );
  }

}