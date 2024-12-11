import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../constants.dart';
import '../../Home/cliente_info_cita.dart';

class CitaItem extends StatefulWidget{
  final String titulo;

  const CitaItem({super.key, required this.titulo});

  @override
  State<CitaItem> createState() => _CitaItem();
}

class _CitaItem extends State<CitaItem> {

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        color: Colors.white,
        child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
              child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: kDepilLightColor,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: const Icon(
                          Symbols.calendar_clock_rounded,
                          color: kDepilColor,
                      )
                    ),
                    title: Text(widget.titulo, style: const TextStyle(color: kGray800Color, fontSize: 14, fontWeight: FontWeight.w500),),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Zona 1, zona 2, zona 3', style: TextStyle(fontSize: 12)),
                        Text('Zona 1, zona 2, zona 3', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      offset: const Offset(0, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                            onTap: ()  {
                              showInfoClientDialog(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(0, 0, defaultPadding/2, 0),
                                  child: const Icon(Icons.info_rounded),
                                ),
                                const Text("Info")
                              ],
                            )
                        ),
                        PopupMenuItem(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.fromLTRB(0, 0, defaultPadding/2, 0),
                                  child: const Icon(Icons.front_hand_rounded),
                                ),
                                const Text("Atender")
                              ],
                            )
                        ),
                      ],
                    ),
              )
        )
    );
  }
}