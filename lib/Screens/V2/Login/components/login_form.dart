
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../Services/auth_service.dart';
import '../../../../components/already_have_an_account_acheck.dart';
import '../../../../constants.dart';
import '../../../Signup/signup_screen.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}


class _LoginFormState extends State<LoginForm> {
  FlutterTts flutterTts = FlutterTts();

  Future<void> configureTts() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
  }




  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final String _clave = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlPhone = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final Map<String, TextEditingController> formControllers = {
    'phone': TextEditingController(),
    'password': TextEditingController()
  };
  bool _hasError = false;

  late FocusNode focusPasswordNode;


  List<int> numeros = [0,1,2,3,4,5,6,7,8,9];
  String clave = '';
  bool visibility = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusPasswordNode = FocusNode();
    focusPasswordNode.addListener(() {
      // log(123123);
    });

  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ctrlPhone.dispose();
    _ctrlPassword.dispose();
    focusPasswordNode.dispose();

    super.dispose();
  }



  void shuffleList() {
    setState(() {
      numeros.shuffle();
    });
  }


  @override
  Widget build(BuildContext context) {

    final auth = AuthService();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text("Ingresa tus datos para continuar", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: defaultPadding),
          TextFormField(
            maxLength: 9,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            controller: _ctrlPhone,

            decoration: InputDecoration(

              counterText: "",

              labelText: 'Celular',
              labelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? kWarningColor
                    : kGray500Color;
                return TextStyle(
                    color: color,
                    fontWeight: FontWeight.w400
                );
              }),
              floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? kWarningColor
                    : kGray500Color;

                return TextStyle(
                    color: color,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w500
                );
              },
              ),

              // hintText: "Ingresa tu teléfono",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.phone),
              ),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                _hasError = true;

                /// refresh the state
                setState(() {});

                return 'Es necesario completar este campo.';
              }

              if (value.length < 9) {
                _hasError = true;

                /// refresh the state
                setState(() {});

                return 'Es número de celular no es válido.';
              }

              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              focusNode: focusPasswordNode,
              maxLength: 6,
              readOnly: true,
              textInputAction: TextInputAction.done,
              obscureText: !visibility,
              cursorColor: kPrimaryColor,
              controller: _ctrlPassword,
              decoration: InputDecoration(
                  counterText: "",
                  labelText: "Clave (6 dígitos)",
                  labelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.error)
                        ? kWarningColor
                        : kGray500Color;
                    return TextStyle(
                        color: color,
                        fontWeight: FontWeight.w400
                    );
                  }),

                  floatingLabelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
                              ? kWarningColor
                              : kGray500Color;

                      return TextStyle(
                          color: color,
                          letterSpacing: 1.3,
                          fontWeight: FontWeight.w500
                      );
                    },
                  ),

                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          color: kGray500Color,
                          onPressed: () async => {
                          // flutterTts.speak("Hay un cliente nuevo en la sala de espera")
                            // Timer.periodic(Duration(seconds: 5), (timer) {
                            //   // Vibrate.vibrate();
                            //   flutterTts.speak("Hay un cliente nuevo en la sala de espera");
                            // })
                            setState( () => visibility = !visibility )
                          },
                          icon: Icon( visibility ? Icons.visibility_off :Icons.visibility),
                        )
                    )
                  )
              ),
              onTap: () async {
                // shuffleList();
                await showInformationDialog(context).then((String? val) {
                  // ignore: avoid_print

                  if(val != null){
                    //ignore: avoid_print

                    _ctrlPassword.text = val;
                  }

                  // formControllers['password']?.text = val ? val : '';
                  // setState(() {
                  //   clave = val;
                  // });
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Es necesario completar este campo.';
                }
                return null;
              },
            ),
          ),
          // const SizedBox(height: defaultPadding),
          Row(
            children: [
              Expanded(
                child: GestureDetector(

                  child: const Text(
                    textAlign: TextAlign.right,
                    "¿Olvidaste tu clave?",
                    style: TextStyle(
                      color: kDepilColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Enviando datos...'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                    ),
                  ).closed.then((value) async => {


                      // Navigator.of(context).pushNamed('/home')
                  // Navigator.push(
                  //   context,
                  //     PageRouteBuilder(
                  //       pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  //         const begin = Offset(0.0, 1.0);
                  //         const end = Offset.zero;
                  //         const curve = Curves.ease;
                  //
                  //         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  //
                  //         return SlideTransition(
                  //           position: animation.drive(tween),
                  //           child: child,
                  //         );
                  //       },
                  //     )
                  // )
                  });
                }
              },
              child: const Text(
                "Ingresar",
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}


Future<String?> showInformationDialog(BuildContext context) async {

  List<int> numbers = [0,1,2,3,4,5,6,7,8,9];
  numbers.shuffle();

  // numbers.shuffle();

  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {

        String password = '';
        List numeros = numbers;

        return StatefulBuilder(builder: (context, setState) {
          return Dialog(

            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0)),
            child: Container(
              alignment: Alignment.center,
              margin: null,
              padding: null,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // constraints: BoxConstraints(maxHeight: 350),
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppBar(
                          leading: SizedBox(
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.black),
                                onPressed: () => Navigator.pop(context, null)
                              )
                          ),
                          backgroundColor: Colors.white
                      ),
                      const SizedBox(height: defaultPadding * 2),
                      // Text(
                      //   password,
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
                                          border: Border.all(color: kDepilColor, width: 1),
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          color: password.length >= (i+1) ? kDepilColor : null,
                                          boxShadow: password.length >= (i+1) ? const [
                                            BoxShadow(
                                              color: kDepilLightColor,
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
                                                  width: 70,
                                                  height: 70,
                                                  child: ElevatedButton(
                                                    onPressed: (){
                                                      if(password.length == 6){
                                                        return;
                                                      }
                                                      setState(() {
                                                        // This call to setState tells the Flutter framework that something has
                                                        // changed in this State, which causes it to rerun the build method below
                                                        // so that the display can reflect the updated values. If we changed
                                                        // _counter without calling setState(), then the build method would not be
                                                        // called again, and so nothing would appear to happen.
                                                        password = password + numeros[(i*3)+b].toString();
                                                        if(password.length == 6){
                                                          Navigator.pop(context, password);
                                                        }
                                                      });
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
                                              onPressed: (){
                                                if(password.length == 6){
                                                  return;
                                                }
                                                setState(() {
                                                  // This call to setState tells the Flutter framework that something has
                                                  // changed in this State, which causes it to rerun the build method below
                                                  // so that the display can reflect the updated values. If we changed
                                                  // _counter without calling setState(), then the build method would not be
                                                  // called again, and so nothing would appear to happen.
                                                  password = password + numeros[9].toString();
                                                  if(password.length == 6){
                                                    Navigator.pop(context, password);
                                                  }
                                                });
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
            ),
          );
        });
      });
}