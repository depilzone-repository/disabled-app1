import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../constants.dart';
import '../../shared/services/auth_service.dart';
import '../V2/Splash/splash_screen_v1.dart';
import '../ValidarClave/validar_clave_screen.dart';
import 'perfil_editar_correo_codigo_screen.dart';

class EditarCorreoScreen extends StatefulWidget {
  final String? correo;
  const EditarCorreoScreen({super.key, required this.correo});

  @override
  State<StatefulWidget> createState() => _EditarCorreoScreenState();
}

class _EditarCorreoScreenState extends State<EditarCorreoScreen>{

  final TextEditingController _ctrlCorreo = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasError = false;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrlCorreo.text = widget.correo != null ? widget.correo! : '';


  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ctrlCorreo.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      // key: widget.key,
      appBar: AppBar(
        // toolbarHeight: 70.0,
        centerTitle: true,
        leading: IconButton(
          // style: IconButton.styleFrom(
          //   // backgroundColor: Colors.red
          // ),
          onPressed: (){
            Navigator.pop(context, false);
          },
          icon:const Icon(FeatherIcons.chevronLeft, size: 30),
          //replace with our own icon data.
        ),
        backgroundColor: Colors.white,
        title: const Text('Editar correo', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding*2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                          const Text('Ingresa un correo electrónico', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                          const SizedBox(height: 8),
                          const Text('Te enviaremos un código de verificación al siguiente correo electrónico', style: TextStyle(), textAlign: TextAlign.center),
                          const SizedBox(height: 30),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              cursorColor: kPrimaryColor,
                              onSaved: (email) {},
                              controller: _ctrlCorreo,

                              decoration: InputDecoration(

                                counterText: "",

                                labelText: 'Correo electrónico',
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
                                })
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
                      ],
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(defaultPadding*2),
                  child: Hero(
                    tag: "change_email_btn",
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDepilColor
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {

                          final result = await Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const ValidarClaveScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              )
                          );

                          // When a BuildContext is used from a StatefulWidget, the mounted property
                          // must be checked after an asynchronous gap.
                          if (!mounted) return;


                          // After the Selection Screen returns a result, hide any previous snackbars
                          // and show the new result.
                          if(result){

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SplashScreen()),
                            );
                            bool generated = await generateOtp(_ctrlCorreo.text);
                            Navigator.pop(context);

                            if(generated){

                              final result = await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => EditarCorreoCodigoScreen(correo: _ctrlCorreo.text),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(0.0, 1.0);
                                      const end = Offset.zero;
                                      const curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  )
                              );

                              // When a BuildContext is used from a StatefulWidget, the mounted property
                              // must be checked after an asynchronous gap.
                              if (!mounted) return;


                              // After the Selection Screen returns a result, hide any previous snackbars
                              // and show the new result.
                              if(result){
                                Navigator.pop(context, true);
                              }


                            }else{

                            }

                            
                          }

                        }
                      },
                      child: const Text('Enviar código', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                    )
                  )
              )
            ],
          )
      ),
    );
  }
}