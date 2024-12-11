import 'package:depilzone_cliente/Screens/V2/Login/check_in_screen.dart';
import 'package:flutter/material.dart';

import '../../../Services/auth_service.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../shared/services/auth_service.dart';
import '../../../shared/services/shared_pref.dart';
import '../../Clave/clave_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ctrlPhone = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  FocusNode focusPasswordNode = FocusNode();

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
    _ctrlPhone.dispose();
    _ctrlPassword.dispose();
    focusPasswordNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SharedPref sharedPref = SharedPref();

    // final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
        body: Center( child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding*2),
            constraints: const BoxConstraints(
              maxWidth: 500
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                Image.asset("assets/images/logo-depilzone.png"),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text("Ingresa tus datos para continuar", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: defaultPadding),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,
                        onSaved: (email) {},
                        controller: _ctrlPhone,

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
                          onPressed: () async {
                              if (_formKey.currentState!.validate()) {

                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                dynamic snack = ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                    content: Text('Enviando datos...'),
                                    behavior: SnackBarBehavior.floating,
                                    duration: Duration(seconds: 1),
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


                                await Login(_ctrlPhone.text, _ctrlPassword.text)
                                    .then((value) async{
                                        await sharedPref.save('pa_user', value.toJson());
                                        Navigator.pushReplacementNamed(context, '/home');
                                    })
                                    .catchError((err){
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
                                return const CheckInScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        )
    )
    );
  }
}