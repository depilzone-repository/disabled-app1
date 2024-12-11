import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../shared/components/skeletons/list_item.dart';
import '../../../shared/models/Cita.dart';
import '../../../shared/models/Usuario.dart';
import '../../../shared/services/cita_service.dart';
import '../../../shared/services/shared_pref.dart';

import 'package:intl/intl.dart';

import 'package:android_intent_plus/android_intent.dart';

import '../../constants.dart';

import 'package:intl/date_symbol_data_local.dart';

import '../../shared/utils/text.dart';

class CitaScreen extends StatefulWidget {
  final int idCita;
  final Cita cita;
  const CitaScreen({super.key, required this.idCita, required this.cita});

  @override
  State<CitaScreen> createState() => _CitaScreenState();

}

class _CitaScreenState extends State<CitaScreen> {


  final bool _pinned = true;
  final bool _snap = false;
  final bool _floating = false;

  Usuario? currentUser;
  final SharedPref sharedPref = SharedPref();
  Cita? currentCita;
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerCita(widget.idCita);
  }

  void saveTheDate(Cita cita) {


    final intent = AndroidIntent(
      action: 'android.intent.action.INSERT', // Important
      data: 'content://com.android.calendar/event', // Important
      type: "vnd.android.cursor.dir/event", // Important
      arguments: <String, dynamic>{
        'title': 'Depilzone cita agendada: ${cita.servicio}',
        'allDay': false,
        'beginTime': cita.fecha!.millisecondsSinceEpoch,
        'endTime': cita.fechaHoraFin!.millisecondsSinceEpoch,
        'description': '',
        'hasAlarm': 1,
        'calendar_id': cita.idCita,
        'eventTimezone': 'America/Lima',
        'where': 'Lima',
        'eventLocation': 'DepilZONE - SURCO',
        'location': 'Av. Primavera 870, Santiago de Surco 15039',
      },
    );

    intent.launchChooser("Elija una aplicación para guardar la cita");
  }


  @override
  void dispose() {
    super.dispose();
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

    initializeDateFormatting();
    DateFormat formatDate = DateFormat("EEE. d 'de' MMM.", "es");
    DateFormat formatHour = DateFormat("jm");

    String imageService = '';
    switch(currentCita?.idServicio){
      case 1: imageService = 'assets/images/services/depilacion_laser.jpg';break;
      case 2: imageService = 'assets/images/services/blanqueamiento.jpg';break;
      case 3: imageService = 'assets/images/services/corporal_360.jpg';break;
      case 4: imageService = 'assets/images/services/tratamiento_facial.jpg';break;
      default:  imageService = 'assets/images/services/depilacion_laser.jpg';break;
    }

    return Scaffold(
      key: widget.key,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: kDepilColor,
          elevation: 0,
          leading: IconButton(
            // style: IconButton.styleFrom(
            //   // backgroundColor: Colors.red
            // ),
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(FeatherIcons.chevronLeft, size: 30, color: Colors.white),
            //replace with our own icon data.
          ),
          title: Text("Cita #${widget.idCita}", style: const TextStyle(fontSize: 16, color: Colors.white)),
          actions: [
            PopupMenuButton<int>(
              elevation: 5,
              surfaceTintColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              iconColor: Colors.white,
              initialValue: 0,
              // Callback that sets the selected popup menu item.
              onSelected: (int value) {
                // saveTheDate(currentCita);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  padding: EdgeInsets.fromLTRB(defaultPadding*2, defaultPadding, defaultPadding*2, defaultPadding),
                  value: 1,
                  child: Text('Añadir al calendario'),
                ),
              ],
            ),
          ],
      ),
      body: Container(
          child: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      color: kDepilColor
                    ),
                  ),
                  Positioned(
                    bottom: -70,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70.0,
                      child: Material(
                        shape: const CircleBorder(side: BorderSide.none),
                        elevation: 7.0,
                        child: loading ? const ItemSkeleton(width: 120.0,height: 120.0,radius: 120 ,margin: EdgeInsets.all(0)) : CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(imageService),
                        ),
                      ),
                    )
                  )

                ],
              ),
              const SizedBox(height: 80),
              loading ? const ItemSkeleton(width: 100.0,height: 20.0,radius: 5.0,margin: EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0)) : Padding(padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0), child: Text(currentCita!.servicio!, style: const TextStyle(color: dDarkColor, fontSize: 16, fontWeight: FontWeight.w500), textAlign: TextAlign.center,)),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3.0,
                              color: dLightColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                          child: Column(
                            children: [
                              const Text('Sede', style: TextStyle(fontSize: 12.0, color: dSecondaryColor), textAlign: TextAlign.center),
                              loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(currentCita!.sede!, style: const TextStyle(color: dDarkColor, fontSize: 14, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,), textAlign: TextAlign.center),
                            ],
                          ),
                        )

                    )),
                    Expanded(child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3.0,
                              color: dLightColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                          child: Column(
                            children: [
                              const Text('Fecha', style: TextStyle(fontSize: 12.0, color: dSecondaryColor), textAlign: TextAlign.center),
                              loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(TextUtil.capitalizeDateFormat1(formatDate.format(currentCita!.fecha!)), style: const TextStyle(color: dDarkColor, fontSize: 14, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,), textAlign: TextAlign.center),
                            ],
                          ),
                        )

                    )),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3.0,
                              color: dLightColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                          child: Column(
                            children: [
                              const Text('Hora', style: TextStyle(fontSize: 12.0, color: dSecondaryColor), textAlign: TextAlign.center),
                              loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(formatHour.format(currentCita!.fecha!), style: const TextStyle(color: dDarkColor, fontSize: 14, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,), textAlign: TextAlign.center),
                            ],
                          ),
                        )

                    )),
                    Expanded(child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3.0,
                              color: dLightColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                          child: Column(
                            children: [
                              const Text('Duración', style: TextStyle(fontSize: 12.0, color: dSecondaryColor), textAlign: TextAlign.center),
                              loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text('${currentCita!.fechaHoraFin!.difference(currentCita!.fecha!).inMinutes.toString()} min.', style: const TextStyle(color: dDarkColor, fontSize: 14, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,), textAlign: TextAlign.center),
                            ],
                          ),
                        )

                    )),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3.0,
                              color: dLightColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                          child: Column(
                            children: [
                              const Text('Tipo Cita', style: TextStyle(fontSize: 12.0, color: dSecondaryColor), textAlign: TextAlign.center),
                              loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(currentCita!.tipoCita!, style: const TextStyle(color: dDarkColor, fontSize: 14, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis,), textAlign: TextAlign.center),
                            ],
                          ),
                        )

                    )),
                    Expanded(child: Card(
                        elevation: 0.0,
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              width: 3.0,
                              color: dLightColor
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                          child: Column(
                            children: [
                              const Text('Estado', style: TextStyle(fontSize: 12.0, color: dSecondaryColor), textAlign: TextAlign.center),
                              loading ? const ItemSkeleton(width: 80.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(currentCita!.estado!, style: const TextStyle(color: dDarkColor, fontSize: 14, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center),
                            ],
                          ),
                        )

                    )),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                child: const Card(
                  elevation: 0.0,
                  color: dDarkColor,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                    child: Text("Zonas / Servicios", style: TextStyle(color: dLightColor), textAlign: TextAlign.center,),
                  ),
                ),
              ),


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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for ( var zona in currentCita!.zonas!)

                          Padding(
                              padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                              child: Card(
                                elevation: 0.0,
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2,
                                      color: dDarkColor
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),

                                child: Container(
                                    child: ListTile(
                                      title: Text(zona.nombre!, style: const TextStyle(color: dDarkColor, fontWeight: FontWeight.w500, fontSize: 14.0), textAlign: TextAlign.start),
                                      trailing: Text('Sesión ${zona.sesion}', style: const TextStyle(color: dSecondaryColor, fontSize: 12.0), textAlign: TextAlign.end),
                                    )

                                  // child: Row(
                                  //   mainAxisSize: MainAxisSize.max,
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   // crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     Text('${zona.nombre!}', maxLines: 5 , softWrap: true, style: TextStyle(color: dDarkColor, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                                  //     Text('Sesión ${zona.sesion}', style: TextStyle(color: dSecondaryColor, fontSize: 12.0), textAlign: TextAlign.end),
                                  //   ],
                                  // )
                                ),
                              ),
                          ),
                            //
                            // Column(
                            //   children: [
                            //     ListTile(
                            //       title: Text(zona.nombre!.toUpperCase(), style: const TextStyle(fontSize: 10.0)),
                            //       trailing: Text(zona.sesion.toString()),
                            //     ),
                            //     const Divider(height: 0),
                            //   ],
                            // )

                      ],
                  ) ,

              Container(
                  padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                  margin: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2, defaultPadding, 0),
                  child: const Text('Presenta el código QR al asistir a tu cita', style: TextStyle(color: dSecondaryColor, fontSize: 12.0), textAlign: TextAlign.center,)
              ),

              Center(
                child: loading ?
                const Padding(
                    padding: EdgeInsets.all(defaultPadding*2),
                    child: ItemSkeleton(width: 220.0,height: 220.0,radius: 30.0,margin: EdgeInsets.all(0)),
                ) :
                Container(
                  margin: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding*5),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: kDepilColor, width: 2.0)
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                    child: QrImageView(
                        padding: const EdgeInsets.all(defaultPadding/2),
                        backgroundColor: Colors.white,
                        data: '${widget.idCita}',
                        version: 4,
                        size: 150.0,
                        eyeStyle: const QrEyeStyle(
                            color: kDepilColor
                        ),
                        // embeddedImageStyle: const QrEmbeddedImageStyle(
                        //     color: Colors.red
                        // )
                      // foregroundColor: kDepilColor,
                    ),
                  )
                )

              )

            ],
          )
      ),


      /*body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            toolbarHeight: 60.0,
            // title: Text("Cita #${currentCita!.idCita.toString().padLeft(7,'0')!}"),
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(vertical: defaultPadding),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${currentCita!.servicio!}"),
                    Text("Cita #${currentCita!.idCita.toString().padLeft(7,'0')!}"),
                  ],
                )
              ),
              expandedTitleScale: 1.0,
              background: Image.asset(
                  imageService,
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(.5),
              ),
              // titlePadding: EdgeInsets.all(0),
              // background: Image.asset(imageService),
              // collapseMode: CollapseMode.parallax,
              // background: FlutterLogo(),
            ),
            backgroundColor: kIndigo100Color,
          ),

          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
              child: Center(
                child: Text('Scroll to see the SliverAppBar in effect.'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child:
                    Text('$index', textScaler: const TextScaler.linear(5)),
                  ),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),*/

    );
  }



}