import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../V2/Login/login_screen.dart';

class PasswordTop extends StatefulWidget {

  const PasswordTop({
    super.key, required this.clave
  });
  final String clave;

  @override
  State<PasswordTop> createState() => _PasswordTopState();

}


class _PasswordTopState extends State<PasswordTop> {
  String _clave = '';
  List numeros = [0,1,2,3,4,5,6,7,8,9];

  void shuffleList() {
    setState(() {
      numeros.shuffle();
    });
  }

  void _add(String value) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _clave = _clave + value;
      if(_clave.length == 6){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ),
        );
      }
    });
  }

  void _remove() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _clave = _clave.isNotEmpty ? _clave.substring(0, _clave.length - 1) : '';
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Positioned(
          top: 0,
          left: 0,
          child:  CloseButton(
            style: ButtonStyle(

            ),
            onPressed: null,
          ),
        ),
        // Text(
        //   _clave,
        //   style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        // ),
        const Text(
          "Ingresa tu clave",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
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
                            border: Border.all(color: kPrimaryColor, width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: _clave.length >= (i+1) ? kPrimaryColor : null,
                            boxShadow: _clave.length >= (i+1) ? const [
                              BoxShadow(
                                color: kPrimaryLightColor,
                                spreadRadius: 3,
                                blurRadius: 0,
                                offset: Offset(0, 0), // changes position of shadow
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
                                  width: 60,
                                  height: 60,
                                      child: ElevatedButton(
                                          onPressed: (){
                                              _add(numeros[(i*3)+b].toString());
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(kGray100Color),
                                              elevation: MaterialStateProperty.all(0.0)
                                          ),
                                          child: Text(numeros[(i*3)+b].toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: kPrimaryColor)),
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
                              width: 60,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: (){
                                  _add(numeros[9].toString());
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),
                                    elevation: MaterialStateProperty.all(0.0)
                                ),
                                child: Text(numeros[9].toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: kPrimaryColor)),
                              ),
                            ),
                            SizedBox(
                                width: 60,
                                height: 60,
                                child: IconButton(
                                    color: kPrimaryColor,
                                    icon: const Icon(Icons.backspace),
                                    tooltip: 'Borrar',
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        elevation: MaterialStateProperty.all(0.0)
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _remove();
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
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      shuffleList();
    });
  }
}
