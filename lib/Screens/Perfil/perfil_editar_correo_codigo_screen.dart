import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../constants.dart';
import '../../shared/models/Response.dart';
import '../../shared/services/auth_service.dart';
import '../../shared/services/cliente_service.dart';
import '../ValidarClave/validar_clave_screen.dart';

class EditarCorreoCodigoScreen extends StatefulWidget {
  final String correo;
  const EditarCorreoCodigoScreen({super.key, required this.correo});

  @override
  State<StatefulWidget> createState() => _EditarCorreoCodigoScreenState();
}

class _EditarCorreoCodigoScreenState extends State<EditarCorreoCodigoScreen>{

  int seconds = 0;
  final TextEditingController _ctrlNum1 = TextEditingController();
  final TextEditingController _ctrlNum2 = TextEditingController();
  final TextEditingController _ctrlNum3 = TextEditingController();
  final TextEditingController _ctrlNum4 = TextEditingController();
  final TextEditingController _ctrlNum5 = TextEditingController();
  final TextEditingController _ctrlNum6 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  

  bool _hasError = false;
  String? _msgError;

  bool loading = false;
  bool waiting = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initWaiting();


  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ctrlNum1.dispose();
    _ctrlNum2.dispose();
    _ctrlNum3.dispose();
    _ctrlNum4.dispose();
    _ctrlNum5.dispose();
    _ctrlNum6.dispose();

    super.dispose();
  }

  countDown(){
    const oneDecimal = Duration(seconds: 1);
    Timer timer = Timer.periodic(
        oneDecimal,
        (Timer timer) =>
          setState(() {
            if (seconds == 0) {
              waiting = false;
              timer.cancel();
            } else {
              seconds -= 1;
            }
          })
    );
  }

  initWaiting() {
    setState(() {
        waiting = true;
        seconds = 10;
        countDown();
    });
  }

  initError({required String message}) async {
    setState(() {
      _hasError = true;
      _msgError = message;
    });
    Future.delayed(const Duration(seconds: 3), (){
      clearError();
    });
  }

  clearError() {
    setState(() {
      _hasError = false;
      _msgError = null;
    });
  }

  clearInputs() {
    _ctrlNum1.text = '';
    _ctrlNum2.text = '';
    _ctrlNum3.text = '';
    _ctrlNum4.text = '';
    _ctrlNum5.text = '';
    _ctrlNum6.text = '';
  }

  bool emptyInputs(){
    return _ctrlNum1.text.isEmpty &&
    _ctrlNum2.text.isEmpty &&
    _ctrlNum3.text.isEmpty &&
    _ctrlNum4.text.isEmpty &&
    _ctrlNum5.text.isEmpty &&
    _ctrlNum6.text.isEmpty;
  }


  evtSubmit(BuildContext context) async {
    if(_hasError){
      return;
    }
    if (_formKey.currentState!.validate()) {

      await validateCode();

    }
    else{
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Debe llenar todos los campos'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
    }
  }



  validateCode() async {
    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.
    dynamic snack = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Validando código...'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    String codigo = '${_ctrlNum1.text}${_ctrlNum2.text}${_ctrlNum3.text}${_ctrlNum4.text}${_ctrlNum5.text}${_ctrlNum6.text}';

    await validateOtp(codigo).then((Response value) async{
      if(value.status == 200){


        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        await changeEmail(widget.correo).then((bool value) async {

          Navigator.pop(context, true);
        }).catchError((err){

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${err.message}'),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        });

      }else{


        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Código inválido'),
        //     behavior: SnackBarBehavior.floating,
        //     duration: const Duration(seconds: 3),
        //   ),
        // );
        initError( message: value.error! );
      }

    }).catchError((err){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${err.message}'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    });
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
        title: const Text('Editar correo electrónico código', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding*2),
                    child: ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('Validación de código', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                            const SizedBox(height: 8),
                            const Text('Ingresa el código de validación que enviamos por correo electrónico a', style: TextStyle(), textAlign: TextAlign.center),
                            Text(widget.correo, style: const TextStyle(fontWeight: FontWeight.w500), textAlign: TextAlign.center),
                            const SizedBox(height: 100),

                            Center(
                              child: SizedBox(

                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: TextFormField(
                                          controller: _ctrlNum1,
                                          contextMenuBuilder:
                                              (BuildContext context, EditableTextState editableTextState) {
                                            return AdaptiveTextSelectionToolbar.editable(
                                              anchors: editableTextState.contextMenuAnchors,
                                              clipboardStatus: ClipboardStatus.notPasteable,
                                              // to apply the normal behavior when click on copy (copy in clipboard close toolbar)
                                              // use an empty function `() {}` to hide this option from the toolbar
                                              onCopy: () => editableTextState
                                                  .copySelection(SelectionChangedCause.toolbar),
                                              // to apply the normal behavior when click on cut
                                              onCut: () => editableTextState
                                                  .cutSelection(SelectionChangedCause.toolbar),
                                              onPaste: () {

                                                // HERE will be called when the paste button is clicked in the toolbar
                                                // apply your own logic here

                                                // to apply the normal behavior when click on paste (add in input and close toolbar)
                                                editableTextState.pasteText(SelectionChangedCause.tap);
                                              },
                                              // to apply the normal behavior when click on select all
                                              onSelectAll: () =>
                                                  editableTextState.selectAll(SelectionChangedCause.toolbar), onLookUp: () {  }, onSearchWeb: () {  }, onShare: () {  }, onLiveTextInput: () {  },
                                            );
                                          },
                                          onChanged: (value){
                                            if(value.length == 1){
                                              FocusScope.of(context).nextFocus();
                                            }
                                          },
                                          onSaved: (pin1){},
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Error";
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: _hasError ? kWarningColor : kDepilColor,
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    color: _hasError ? kWarningColor : kDepilColor,
                                                    width: 2.5,
                                                    style: BorderStyle.solid,
                                                    strokeAlign: BorderSide.strokeAlignOutside
                                                )
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: _hasError ? kWarningColor : kDepilColor,
                                                  width: 2.5,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide.strokeAlignOutside
                                              ),
                                            ),
                                            hintText: '0',
                                            hintStyle: const TextStyle(color: kGray300Color),
                                            errorMaxLines: 1,
                                            errorStyle: const TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),

                                      SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: TextFormField(
                                          controller: _ctrlNum2,
                                          onChanged: (value){
                                            if(value.length == 1){
                                              FocusScope.of(context).nextFocus();
                                            }else{
                                              FocusScope.of(context).previousFocus();
                                            }
                                          },
                                          onSaved: (pin2){},
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Error";
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: _hasError ? kWarningColor : kDepilColor,
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    color: _hasError ? kWarningColor : kDepilColor,
                                                    width: 2.5,
                                                    style: BorderStyle.solid,
                                                    strokeAlign: BorderSide.strokeAlignOutside
                                                )
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: _hasError ? kWarningColor : kDepilColor,
                                                  width: 2.5,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide.strokeAlignOutside
                                              ),
                                            ),
                                            hintText: '0',
                                            hintStyle: const TextStyle(color: kGray300Color),
                                            errorMaxLines: 1,
                                            errorStyle: const TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),

                                      SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: TextFormField(
                                          controller: _ctrlNum3,
                                          onChanged: (value){
                                            if(value.length == 1){
                                              FocusScope.of(context).nextFocus();
                                            }else{
                                              FocusScope.of(context).previousFocus();
                                            }
                                          },
                                          onSaved: (pin3){},
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Error";
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: _hasError ? kWarningColor : kDepilColor,
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          decoration:  InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    color: _hasError ? kWarningColor : kDepilColor,
                                                    width: 2.5,
                                                    style: BorderStyle.solid,
                                                    strokeAlign: BorderSide.strokeAlignOutside
                                                )
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: _hasError ? kWarningColor : kDepilColor,
                                                  width: 2.5,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide.strokeAlignOutside
                                              ),
                                            ),
                                            hintText: '0',
                                            hintStyle: const TextStyle(color: kGray300Color),
                                            errorMaxLines: 1,
                                            errorStyle: const TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),

                                      SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: TextFormField(
                                          controller: _ctrlNum4,
                                          onChanged: (value){
                                            if(value.length == 1){
                                              FocusScope.of(context).nextFocus();
                                            }else{
                                              FocusScope.of(context).previousFocus();
                                            }
                                          },
                                          onSaved: (pin4){},
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Error";
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: _hasError ? kWarningColor : kDepilColor,
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    color: _hasError ? kWarningColor : kDepilColor,
                                                    width: 2.5,
                                                    style: BorderStyle.solid,
                                                    strokeAlign: BorderSide.strokeAlignOutside
                                                )
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: _hasError ? kWarningColor : kDepilColor,
                                                  width: 2.5,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide.strokeAlignOutside
                                              ),
                                            ),
                                            hintText: '0',
                                            hintStyle: const TextStyle(color: kGray300Color),
                                            errorMaxLines: 1,
                                            errorStyle: const TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),

                                      SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: TextFormField(
                                          controller: _ctrlNum5,
                                          onChanged: (value){
                                            if(value.length == 1){
                                              FocusScope.of(context).nextFocus();
                                            }else{
                                              FocusScope.of(context).previousFocus();
                                            }
                                          },
                                          onSaved: (pin5){},
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Error";
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: _hasError ? kWarningColor : kDepilColor,
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    color: _hasError ? kWarningColor : kDepilColor,
                                                    width: 2.5,
                                                    style: BorderStyle.solid,
                                                    strokeAlign: BorderSide.strokeAlignOutside
                                                )
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: _hasError ? kWarningColor : kDepilColor,
                                                  width: 2.5,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide.strokeAlignOutside
                                              ),
                                            ),
                                            hintText: '0',
                                            hintStyle: const TextStyle(color: kGray300Color),
                                            errorMaxLines: 1,
                                            errorStyle: const TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),

                                      SizedBox(
                                        height: 80,
                                        width: 50,
                                        child: TextFormField(
                                          controller: _ctrlNum6,
                                          onChanged: (value) async {
                                            if(value.length == 1){
                                              FocusScope.of(context).nextFocus();
                                              if(!emptyInputs()){
                                                await evtSubmit(context);
                                              }
                                            }else{
                                              FocusScope.of(context).previousFocus();
                                            }
                                          },
                                          onSaved: (pin6){},
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "";
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: _hasError ? kWarningColor : kDepilColor,
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                borderSide: BorderSide(
                                                    color: _hasError ? kWarningColor : kDepilColor,
                                                    width: 2.5,
                                                    style: BorderStyle.solid,
                                                    strokeAlign: BorderSide.strokeAlignOutside
                                                )
                                            ),
                                            focusedBorder:  OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: _hasError ? kWarningColor : kDepilColor,
                                                  width: 2.5,
                                                  style: BorderStyle.solid,
                                                  strokeAlign: BorderSide.strokeAlignOutside
                                              ),
                                            ),
                                            hintText: '0',
                                            hintStyle: const TextStyle(color: kGray300Color),
                                            // errorMaxLines: 1,
                                            // errorStyle: const TextStyle(
                                            //   color: Colors.transparent,
                                            //   fontSize: 0,
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _hasError ? Text(_msgError!, textAlign: TextAlign.center, style: const TextStyle(color: kWarningColor, fontWeight: FontWeight.w500, fontSize: 14.0, height: 2)) : const Text(''),

                            const SizedBox(height: 50),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: waiting ? 'Podras solicitar un nuevo código en ' : '¿No haz recibido tu código?, ',
                                    style:  const TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: waiting ? '$seconds segundos' : 'Reenviar código',
                                    style:  const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {

                                        if(waiting){
                                          return;
                                        }

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

                                            // limpiar inputs
                                            clearInputs();


                                            bool otp = await generateOtp(widget.correo);
                                            if(otp){
                                              print('Código Opt generado con éxito');
                                              initWaiting();
                                            }else{
                                              print('No se pudo generar el Código Opt');
                                            }

                                        }


                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(defaultPadding*2),
                  child: Hero(
                    tag: "login_btn",
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDepilColor
                      ),
                      onPressed: () async {

                        await evtSubmit(context);

                      },
                      child: const Text('Validar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                    )
                  )
              )
            ],
          )
      ),
    );
  }


}