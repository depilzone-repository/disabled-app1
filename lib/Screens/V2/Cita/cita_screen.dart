import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../constants.dart';
import '../../../shared/components/skeletons/list_item.dart';
import '../../../shared/models/Cita.dart';
import '../../../shared/models/Usuario.dart';
import '../../../shared/services/cita_service.dart';
import '../../../shared/services/shared_pref.dart';

import 'package:intl/intl.dart';

import '../../../shared/utils/colors.dart';

class CitaScreen extends StatefulWidget {
  final int idCita;
  const CitaScreen({super.key, required this.idCita});

  @override
  State<CitaScreen> createState() => _CitaScreenState();

}


class _CitaScreenState extends State<CitaScreen> {

  Usuario? currentUser;
  final SharedPref sharedPref = SharedPref();
  Cita? currentCita;
  bool loading = true;


  DateFormat formatDate = DateFormat("dd/MM/yyyy");
  DateFormat formatHour = DateFormat("jm");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerCita(widget.idCita);
    saveTheDate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveTheDate() {
    final intent = AndroidIntent(
      action: 'android.intent.action.INSERT', // Important
      data: 'content://com.android.calendar/event', // Important
      type: "vnd.android.cursor.dir/event", // Important
      arguments: <String, dynamic>{
        'title': 'sssss',
        'allDay': true,
        'beginTime': DateTime.now().microsecondsSinceEpoch + 3600000 * 2,
        'endTime': DateTime.now().microsecondsSinceEpoch + 3600000 * 2,
        'description': '',
        'eventLocation': '',
        'hasAlarm': 1,
        'calendar_id': 1,
        'eventTimezone': 'Europe/Berlin'
      },
    );
    print('intent');
    intent.launchChooser("Choose an App to save the Date");
  }

  obtenerCita(int idCita) async {
    setState(() {
      loading = true;
    });
    currentCita = await fetchCita(idCita);
    setState(() {
      loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: kDepilColor,
          elevation: 0,
          title: Text("Cita #${widget.idCita}", style: const TextStyle(fontSize: 16, color: Colors.white))
      ),
      body: Container(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Servicios', style: TextStyle(fontSize: 14.0, color: kGray800Color, fontWeight: FontWeight.w500),),
                trailing: loading ? const ItemSkeleton(width: 100.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(currentCita!.servicio!.toUpperCase(), style: const TextStyle(color: kGray600Color)),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Sede', style: TextStyle(fontSize: 14.0, color: kGray800Color, fontWeight: FontWeight.w500),),
                trailing: loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(currentCita!.sede!.toUpperCase(), style: const TextStyle(color: kGray600Color)),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Fecha', style: TextStyle(fontSize: 14.0, color: kGray800Color, fontWeight: FontWeight.w500),),
                trailing: loading ? const ItemSkeleton(width: 60.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(formatDate.format(currentCita!.fecha!), style: const TextStyle(color: kGray600Color)),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Hora', style: TextStyle(fontSize: 14.0, color: kGray800Color, fontWeight: FontWeight.w500),),
                trailing: loading ? const ItemSkeleton(width: 60.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(formatHour.format(currentCita!.fecha!), style: const TextStyle(color: kGray600Color)),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Tipo Cita', style: TextStyle(fontSize: 14.0, color: kGray800Color, fontWeight: FontWeight.w500),),
                trailing: loading ? const ItemSkeleton(width: 100.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(currentCita!.tipoCita!.toUpperCase(), style: const TextStyle(color: kGray600Color)),
              ),
              const Divider(height: 0),
              ListTile(
                title: const Text('Estado', style: TextStyle(fontSize: 14.0, color: kGray800Color, fontWeight: FontWeight.w500),),
                trailing: loading ? const ItemSkeleton(width: 100.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Container(padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/3, defaultPadding, defaultPadding/3) ,decoration: BoxDecoration( color: HexColor(currentCita!.colorEstado!), borderRadius: const BorderRadius.all(Radius.circular(15.0)) ),child: Text(currentCita!.estado!.toUpperCase(), style: const TextStyle(color: Colors.white))),
              ),
              const Divider(height: 0),
              const ListTile(
                tileColor: kGray400Color,
                textColor: Colors.white,
                title: Text('ZONAS Y/O SERVICIOS', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500)),
                trailing: Text('N° SESIÓN', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500)),
              ),
              const Divider(height: 0),

              loading
                  ? Column(
                      children: [
                        for (int i = 0; i < 5; i ++)
                          const ListTile(
                              title: ItemSkeleton(width: 60.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)),
                              trailing: ItemSkeleton(width: 10.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0))
                          ),
                          const Divider(height: 0),
                      ],
                  )
                  : Column(
                      children: [
                        for ( var zona in currentCita!.zonas!)
                            Column(
                              children: [
                                ListTile(
                                  title: Text(zona.nombre!.toUpperCase(), style: const TextStyle(fontSize: 10.0)),
                                  trailing: Text(zona.sesion.toString()),
                                ),
                                const Divider(height: 0),
                              ],
                            )

                      ],
                  ) ,



              Center(
                child: loading ?
                const Padding(
                    padding: EdgeInsets.all(defaultPadding*2),
                    child: ItemSkeleton(width: 220.0,height: 220.0,radius: 30.0,margin: EdgeInsets.all(0)),
                ) :
                Container(
                  margin: const EdgeInsets.all(defaultPadding*2),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: kDepilColor, width: 3.0)
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                    child: QrImageView(
                        padding: const EdgeInsets.all(defaultPadding),
                        backgroundColor: Colors.white,
                        data: '${widget.idCita}',
                        version: 4,
                        size: 250.0,
                        eyeStyle: const QrEyeStyle(
                            color: kDepilColor
                        ),
                        embeddedImageStyle: const QrEmbeddedImageStyle(
                            color: Colors.red
                        )
                      // foregroundColor: kDepilColor,
                    ),
                  )
                )
                
              )

            ],
          )
      ),
    );
  }



}