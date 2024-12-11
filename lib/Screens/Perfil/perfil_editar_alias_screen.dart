import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../constants.dart';
import '../../shared/services/cliente_service.dart';

class EditarAliasScreen extends StatefulWidget {
  final String? alias;
  const EditarAliasScreen({super.key, required this.alias});

  @override
  State<StatefulWidget> createState() => _EditarAliasScreenState();
}

class _EditarAliasScreenState extends State<EditarAliasScreen>{

  final TextEditingController _ctrlAlias = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _hasError = false;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ctrlAlias.text = widget.alias != null ? widget.alias! : '';

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ctrlAlias.dispose();
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
            Navigator.pop(context);
          },
          icon:const Icon(FeatherIcons.chevronLeft, size: 30),
          //replace with our own icon data.
        ),
        backgroundColor: Colors.white,
        title: const Text('Editar Alias', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
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
                          const Text('Escoge tu nombre en depilzone', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                          const SizedBox(height: 8),
                          const Text('¿Como quieres que te llamemos?', style: TextStyle(), textAlign: TextAlign.center),
                          const SizedBox(height: 30),
                          TextFormField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              cursorColor: kPrimaryColor,
                              onSaved: (email) {},
                              controller: _ctrlAlias,

                              decoration: InputDecoration(

                                counterText: "",

                                labelText: 'Alias',
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
                    tag: "login_btn",
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDepilColor
                      ),
                      onPressed: () async {

                        if(loading){ return; }

                        if (_formKey.currentState!.validate()) {

                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enviando datos...'),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 1),
                            ),
                          );

                          changeAlias(_ctrlAlias.text).then((bool value){

                              Navigator.pop(context, true);
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
                      },
                      child: const Text('Guardar alias', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0),),
                    )
                  )
              )
            ],
          )
      ),
    );
  }
}