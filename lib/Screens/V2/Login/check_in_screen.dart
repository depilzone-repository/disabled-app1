
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../Services/auth_service.dart';
import '../../../constants.dart';
import '../../../shared/models/Cliente.dart';
import '../../../shared/services/cliente_service.dart';
import '../../../shared/utils/core.dart';
import '../../Clave/clave_screen.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CheckInScreenState();

}

class _CheckInScreenState extends State<CheckInScreen>{

  bool validate = false;
  Cliente? clientValidated;
  String? messageClient;
  String? typeMessageClient;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlCode = TextEditingController();
  final TextEditingController _ctrlPhone = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final TextEditingController _ctrlRepeatPassword = TextEditingController();


  bool _stateTextCode = true;
  bool _stateTextPhone = true;
  bool _stateTextEmail = true;
  bool _stateTextPassword = true;
  bool _stateTextRepeatPassword = true;
  bool _stateBtnSubmit = true;

  FocusNode focusPasswordNode = FocusNode();
  FocusNode focusRepeatPasswordNode = FocusNode();

  bool _hasError = false;
  bool visibility = false;
  final bool _hasLoged = false;

  final auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // focusPasswordNode.
    //
    // focusPasswordNode.addListener(() async {

    //   await showInformationDialog(context).then((String? val) {
    //     // ignore: avoid_print

    //     if(val != null){
    //       //ignore: avoid_print

    //       _ctrlPassword.text = val;
    //     }
    //
    //     // formControllers['password']?.text = val ? val : '';
    //     // setState(() {
    //     //   clave = val;
    //     // });
    //   });
    // });

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ctrlCode.dispose();
    _ctrlPhone.dispose();
    _ctrlEmail.dispose();
    _ctrlPassword.dispose();
    focusPasswordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 70.0,
          centerTitle: true,
          // leading: IconButton(
          //   // style: IconButton.styleFrom(
          //   //   // backgroundColor: Colors.red
          //   // ),
          //   onPressed: (){
          //     Navigator.pop(context, false);
          //   },
          //   icon:const Icon(FeatherIcons.chevronLeft, size: 30),
          //   //replace with our own icon data.
          // ),
          backgroundColor: Colors.white,
          title: const Text('Registrarse', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          leading: IconButton(
            // style: IconButton.styleFrom(
            //   // backgroundColor: Colors.red
            // ),
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(FeatherIcons.chevronLeft, size: 30),
            //replace with our own icon data.
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding*2),
            constraints: const BoxConstraints(
              maxWidth: 500
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/images/logo-depilzone.png"),
                const SizedBox(height: 30),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text("Registrate", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30, color: dDarkColor)),
                      const SizedBox(height: defaultPadding),


                      messageClient != null ? Visibility(
                          visible: messageClient != null,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(validate && !clientValidated!.tieneCredenciales! ? FeatherIcons.checkCircle : FeatherIcons.alertTriangle),
                                tileColor: validate && !clientValidated!.tieneCredenciales! ? Colors.greenAccent : Colors.yellow.shade100,
                                title: Text(messageClient!),
                              ),
                              const SizedBox(height: 30,),
                            ],
                          )
                      ) : Text(""),

                      // codigo
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        onSaved: (email) {},
                        controller: _ctrlCode,
                        enabled: _stateTextCode,

                        decoration: InputDecoration(

                          counterText: "",

                          labelText: 'Código cliente',
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
                            child: Icon(FeatherIcons.hash),
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


                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),


                      // numero
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        onSaved: (email) {},
                        controller: _ctrlPhone,
                        enabled: _stateTextPhone,

                        decoration: InputDecoration(

                          counterText: "",

                          labelText: 'Número de celular',
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
                            child: Icon(FeatherIcons.phone),
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

                          return null;
                        },
                      ),
                      const SizedBox(height: defaultPadding),


                      // correo
                      Visibility(
                        visible: validate && clientValidated!.encontrado! && !clientValidated!.tieneCredenciales!,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              cursorColor: kPrimaryColor,
                              onSaved: (email) {},
                              controller: _ctrlEmail,
                              enabled: _stateTextEmail,

                              decoration: InputDecoration(

                                counterText: "",

                                labelText: 'Correo',
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
                                  child: Icon(Icons.mail),
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

                                if (!value.contains("@") || !value.contains(".")) {
                                  _hasError = true;

                                  /// refresh the state
                                  setState(() {});

                                  return 'Ingrese un correo válido.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                          ],
                        ),
                      ),


                      // clave
                      Visibility(
                        visible: validate && clientValidated!.encontrado! && !clientValidated!.tieneCredenciales!,
                        child: Column(
                          children: [
                            TextFormField(
                              focusNode: focusPasswordNode,
                              maxLength: 6,
                              readOnly: true,
                              textInputAction: TextInputAction.done,
                              obscureText: !visibility,
                              cursorColor: kPrimaryColor,
                              controller: _ctrlPassword,
                              enabled: _stateTextPassword,
                              decoration: InputDecoration(
                                  counterText: "",
                                  labelText: "Clave",
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
                                              setState((){
                                                visibility = !visibility;
                                              })
                                            },
                                            icon: Icon( visibility ? Icons.visibility_off :Icons.visibility),
                                          )
                                      )
                                  )
                              ),
                              onTap: () async {
                                // shuffleList();

                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ClaveScreen()),
                                );

                                // When a BuildContext is used from a StatefulWidget, the mounted property
                                // must be checked after an asynchronous gap.
                                if (!mounted) return;


                                // After the Selection Screen returns a result, hide any previous snackbars
                                // and show the new result.
                                _ctrlPassword.text = result ?? '';


                                /*await showInformationDialog(context).then((String? val) {
                              // ignore: avoid_print
                              // print(val);
                              if(val != null){
                                //ignore: avoid_print
                                print(val);
                                _ctrlPassword.text = val;
                              }

                              // formControllers['password']?.text = val ? val : '';
                              // setState(() {
                              //   clave = val;
                              // });
                            });*/
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Es necesario completar este campo.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                          ]
                        )
                      ),


                      // repetir clave
                      Visibility(
                        visible: validate && clientValidated!.encontrado! && !clientValidated!.tieneCredenciales!,
                        child: Column(
                          children: [
                            TextFormField(
                              focusNode: focusRepeatPasswordNode,
                              maxLength: 6,
                              readOnly: true,
                              textInputAction: TextInputAction.done,
                              obscureText: !visibility,
                              cursorColor: kPrimaryColor,
                              controller: _ctrlRepeatPassword,
                              enabled: _stateTextRepeatPassword,
                              decoration: InputDecoration(
                                  counterText: "",
                                  labelText: "Repetir clave",
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
                                          /*child: IconButton(
                                            color: kGray500Color,
                                            onPressed: () async => {
                                              setState((){
                                                visibility = !visibility;
                                              })
                                            },
                                            icon: Icon( visibility ? Icons.visibility_off :Icons.visibility),
                                          )*/
                                      )
                                  )
                              ),
                              onTap: () async {
                                // shuffleList();

                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ClaveScreen()),
                                );

                                // When a BuildContext is used from a StatefulWidget, the mounted property
                                // must be checked after an asynchronous gap.
                                if (!mounted) return;


                                // After the Selection Screen returns a result, hide any previous snackbars
                                // and show the new result.
                                _ctrlRepeatPassword.text = result ?? '';


                                /*await showInformationDialog(context).then((String? val) {
                              // ignore: avoid_print
                              // print(val);
                              if(val != null){
                                //ignore: avoid_print
                                print(val);
                                _ctrlPassword.text = val;
                              }

                              // formControllers['password']?.text = val ? val : '';
                              // setState(() {
                              //   clave = val;
                              // });
                            });*/
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Es necesario completar este campo.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: defaultPadding),
                          ]
                        )
                      ),

                      Hero(
                        tag: "login_btn",
                        child: ElevatedButton(
                          onPressed: () async {
                              if(!_stateBtnSubmit){
                                return;
                              }

                              if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _stateBtnSubmit = false;
                                  });


                                  _stateTextCode = false;
                                  _stateTextPhone = false;


                                print(validate ? 'Registrando...' : 'Validando...');

                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                dynamic snack = ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text( validate ? 'Registrando...' : 'Validando...'),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );

                                // log(_ctrlPhone.text);
                                // log(_ctrlPassword.text);
                                // auth.login(_ctrlPhone.text, _ctrlPassword.text).then((bool value) => {
                                //     if(value){
                                //         // Navegar a la pantalla principal
                                //         Navigator.pushReplacementNamed(context, '/home')
                                //     }
                                // });

                                // authBloc.add(const LoginEvent(
                                //   user:  User(username: 'nombre_de_usuario', password: 'contraseña'),
                                // ));

                                // Guardar el estado de inicio de sesión

                                //Navigator.pop(context, SplashScreen());
                                if(validate){

                                  await registerCredential( clientValidated!.id! ,_ctrlEmail.text, _ctrlPassword.text).then((bool value){

                                    messageClient = 'Sus credenciales fueron registrados con éxito!!';
                                    typeMessageClient = 'success';
                                    setState(() {});

                                    Timer(Duration(seconds: 3), () {
                                      Navigator.pop(context);
                                    });

                                  }).catchError((err){
                                    setState(() {
                                      _stateBtnSubmit = true;
                                      _stateTextEmail = true;
                                      _stateTextPassword = true;
                                      _stateTextRepeatPassword = true;
                                    });

                                    print(err);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${err.message}'),
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 3),
                                      ),
                                    );
                                  });

                                }else{
                                  await validateClient(int.parse(_ctrlCode.text), _ctrlPhone.text)
                                      .then((Cliente value){
                                    clientValidated = value;
                                    if(clientValidated!.encontrado!){
                                      validate = true;
                                      messageClient = 'Bienvenido ${clientValidated!.nombres} ${clientValidated!.apellidos}, favor de registrar sus credenciales para el acceso a su perfil.';
                                      typeMessageClient = 'success';

                                      _stateBtnSubmit = true;

                                      if(clientValidated!.tieneCredenciales!){
                                        messageClient = 'Bienvenido ${clientValidated!.nombres!} ${clientValidated!.apellidos!}, usted ya tiene registrado sus credenciales para el acceso a su perfil.';
                                        typeMessageClient = 'warning';
                                        _stateTextEmail = false;
                                        _stateTextPassword = false;
                                        _stateTextRepeatPassword = false;
                                        _stateBtnSubmit = false;
                                      }

                                    }else{
                                      messageClient = 'El código o número de celular del cliente es incorrecto. Vuelva a ingresar sus datos.';
                                      typeMessageClient = 'danger';
                                      _stateTextCode = true;
                                      _stateTextPhone = true;
                                      _stateBtnSubmit = true;
                                    }

                                    setState(() {});
                                  }).catchError((err){
                                          setState(() {
                                            _stateBtnSubmit = true;
                                            _stateTextCode = true;
                                            _stateTextPhone = true;
                                          });

                                          print(err);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('${err.message}'),
                                              behavior: SnackBarBehavior.floating,
                                              duration: const Duration(seconds: 3),
                                            ),
                                          );
                                  });
                                }



                              }
                          },
                          child: Text(
                            validate ? "Registrar" : "Validar",
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),

                      GestureDetector(
                        onTap: () async {
                          print("ddd");
                          await CoreUtil.launchWhatsapp();
                        },
                        child: const Text(
                          textAlign: TextAlign.right,
                          "Solicita tu código de cliente aquí",
                          style: TextStyle(
                            color: kDepilColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),


                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}