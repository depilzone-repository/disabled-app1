
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../constants.dart';

class ListaCitasFiltro extends StatefulWidget{
  const ListaCitasFiltro({super.key});

  @override
  State<StatefulWidget> createState() => _ListaCitasFiltro();
}

class _ListaCitasFiltro extends State<ListaCitasFiltro>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          color: Colors.indigo[300],
        ),
        backgroundColor: Colors.indigo[50],
        title: const Text(
          "Filtros",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
        )
      ),
      body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(defaultPadding),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.none,
                  cursorColor: kPrimaryColor,
                  readOnly: true,
                  onTap: () async{
                    DateTime? tiempo = await showDatePicker(context: context,
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2022)
                    );

                  },
                  onSaved: (email) {},

                  decoration: InputDecoration(

                    counterText: "",

                    labelText: 'Fecha Cita',
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
                      child: Icon(Symbols.calendar_today_rounded),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                ),
              ],
            )
          )
      )
    );
  }

}