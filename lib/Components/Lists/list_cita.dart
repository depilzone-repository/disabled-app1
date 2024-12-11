import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../Screens/Cita/cita_screen.dart';
import '../../Services/shared_preferences.dart';
import '../../constants.dart';
import '../../shared/components/skeletons/list_item.dart';
import '../../shared/models/Cita.dart';
import '../../shared/models/Usuario.dart';
import '../../shared/services/cita_service.dart';
import '../../shared/utils/colors.dart';

class ListCitaWidget extends StatefulWidget{
  final int idService;

  const ListCitaWidget({super.key, required this.idService});

  @override
  State<ListCitaWidget> createState() => _ListCitaWidgetState();

}

class _ListCitaWidgetState extends State<ListCitaWidget> {

    ScrollController scrollController = ScrollController();
    Usuario? currentUser;
    late Future _loadData;

    _init() async{
    }

    List<GrupoCita> grupoCitas = [];
    bool loading = false;

    // Future
    Future<List<GrupoCita>> _fetchCitas() async {
      List<GrupoCita> collection = [];
      Usuario? currentUser = await getUsuario();
      collection = await fetchCitasByService(currentUser!.id!, widget.idService);

      return collection;
    }
    // Future<void> _loadCitas() async{
    //   citas = await fetchCitasByService(currentUser!.id!, widget.idService);
    // }

    @override
    void initState() {
      // TODO: implement initState
      _loadData = _fetchCitas();
      super.initState();
    }

    @override
    void dispose() {
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      // DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");

      return Container(
          child: FutureBuilder(
            future: _loadData,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Column(
                      children: [
                        Expanded(
                            child: ListItemSkeleton(
                              itemCount: 10,
                              padding: EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, defaultPadding),
                            )
                        )
                      ]
                  );
                case ConnectionState.done:

                  if (snapshot.connectionState == ConnectionState.none && !snapshot.hasData) {
                    return const Padding( padding: EdgeInsets.all(defaultPadding*2), child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Por el momento no tienes citas registradas.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kIndigo,
                              fontWeight: FontWeight.w500,
                              // fontSize: 10
                            ),
                          )
                        ]
                    ));
                  }

                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(0,0,0,100),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      GrupoCita grupo = snapshot.data[index];
                      DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");

                      return Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: kGradiantHorizontalColor
                                ),
                                child: ListTile(
                                    contentPadding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
                                    horizontalTitleGap: 10,
                                    minVerticalPadding: defaultPadding,
                                    leadingAndTrailingTextStyle: const TextStyle(
                                        fontSize: 30
                                    ),
                                  leading: const Icon(Symbols.calendar_month_rounded, color: Colors.white, size: 30,opticalSize: 1),
                                  title: Text(grupo.texto!.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                                )
                                // child: RichText(text: TextSpan(children:[
                                //   WidgetSpan(
                                //     child: Icon(Symbols.calendar_month_rounded, color: Colors.white, size: 30,opticalSize: 1,),
                                //   ),
                                //   TextSpan(text: grupo.texto!.toUpperCase(), style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                                // ]))
                              ),
                              Container(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      shrinkWrap: true,
                                      itemCount: grupo.citas!.length,
                                      controller: scrollController,
                                      itemBuilder: (BuildContext context, int index){
                                        return Column(
                                            children: [
                                                // index > 0 ? const Divider(height: 0) :  SizedBox(),
                                                InkWell(
                                                  onTap: () async {
                                                    await Navigator.push(
                                                        context,
                                                        PageRouteBuilder(
                                                          pageBuilder: (context, animation, secondaryAnimation) => CitaScreen(idCita: grupo.citas![index].idCita!, cita: grupo.citas![index]),
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
                                                  },
                                                  child: Card(
                                                    elevation: 0,
                                                    surfaceTintColor: kGray100Color,
                                                    color: kGray100Color,
                                                    shadowColor: kGray200Color,
                                                    child: ListTile(
                                                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
                                                      horizontalTitleGap: 10,
                                                      minVerticalPadding: defaultPadding,
                                                      leadingAndTrailingTextStyle: const TextStyle(
                                                          fontSize: 30
                                                      ),
                                                      leading: CircleAvatar(
                                                        radius: 30,
                                                        child: SvgPicture.asset(
                                                          'assets/images/calendario_dia_${grupo.citas![index].fecha!.day}.svg',
                                                          height: 100.0,
                                                          width: 100.0,
                                                          allowDrawingOutsideViewBox: false,
                                                        ),
                                                      ),
                                                      title: Text(grupo.citas![index].servicio!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),),
                                                      subtitle: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(format.format(grupo.citas![index].fecha!), style: const TextStyle(fontSize: 12)),
                                                          Container(
                                                              padding: const EdgeInsets.fromLTRB(defaultPadding, 2, defaultPadding, 2),
                                                              decoration: BoxDecoration(
                                                                  color: HexColor(grupo.citas![index].colorEstado!),
                                                                  borderRadius: const BorderRadius.all(Radius.circular(15.0))
                                                              ),
                                                              child: Text(grupo.citas![index].estado!.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w500))
                                                          )
                                                        ],
                                                      ),
                                                      trailing: const Icon(Icons.favorite_rounded),
                                                    ),
                                                  ),

                                                ),
                                            ]
                                        );
                                      },
                                  ),
                              )
                            ],
                          )
                        ],
                      );

                      return ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
                        horizontalTitleGap: 10,
                        minVerticalPadding: defaultPadding,
                        leadingAndTrailingTextStyle: const TextStyle(
                            fontSize: 30
                        ),
                        // leading: CircleAvatar(
                        //   radius: 30,
                        //   child: SvgPicture.asset(
                        //     'assets/images/calendario_dia_${cita.fecha!.day}.svg',
                        //     height: 100.0,
                        //     width: 100.0,
                        //     allowDrawingOutsideViewBox: false,
                        //   ),
                        // ),
                        title: Text(grupo.texto!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),),
                        // subtitle: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text(format.format(cita.fecha!), style: const TextStyle(fontSize: 12)),
                        //     Container(
                        //         padding: const EdgeInsets.fromLTRB(defaultPadding, 2, defaultPadding, 2) ,
                        //         decoration: BoxDecoration(
                        //             color: HexColor(cita.colorEstado!),
                        //             borderRadius: const BorderRadius.all(Radius.circular(15.0))
                        //         ),
                        //         child: Text(cita.estado!.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w500))
                        //     )
                        //   ],
                        // ),
                      );
                    },
                  );



                  // return ListView.builder(
                  //   controller: scrollController,
                  //   padding: const EdgeInsets.fromLTRB(0,0,0,100),
                  //   itemCount: snapshot.data.length,
                  //   itemBuilder: (context, index) {
                  //     Cita cita = snapshot.data[index];
                  //     DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");
                  //
                  //     return Column(
                  //       children: [
                  //         InkWell(
                  //           onTap: () async {
                  //
                  //             await Navigator.push(
                  //                 context,
                  //                 PageRouteBuilder(
                  //                   pageBuilder: (context, animation, secondaryAnimation) => CitaScreen(idCita: cita.idCita!),
                  //                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  //                     const begin = Offset(0.0, 1.0);
                  //                     const end = Offset.zero;
                  //                     const curve = Curves.ease;
                  //
                  //                     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  //
                  //                     return SlideTransition(
                  //                       position: animation.drive(tween),
                  //                       child: child,
                  //                     );
                  //                   },
                  //                 )
                  //             );
                  //
                  //           },
                  //           // child: ListTile(
                  //           //   contentPadding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
                  //           //   horizontalTitleGap: 10,
                  //           //   minVerticalPadding: defaultPadding,
                  //           //   leadingAndTrailingTextStyle: const TextStyle(
                  //           //       fontSize: 30
                  //           //   ),
                  //           //   leading: CircleAvatar(
                  //           //     radius: 30,
                  //           //     child: SvgPicture.asset(
                  //           //       'assets/images/calendario_dia_${cita.fecha!.day}.svg',
                  //           //       height: 100.0,
                  //           //       width: 100.0,
                  //           //       allowDrawingOutsideViewBox: false,
                  //           //     ),
                  //           //   ),
                  //           //   title: Text(cita.servicio!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),),
                  //           //   subtitle: Column(
                  //           //     crossAxisAlignment: CrossAxisAlignment.start,
                  //           //     children: [
                  //           //       Text(format.format(cita.fecha!), style: const TextStyle(fontSize: 12)),
                  //           //       Container(
                  //           //           padding: const EdgeInsets.fromLTRB(defaultPadding, 2, defaultPadding, 2) ,
                  //           //           decoration: BoxDecoration(
                  //           //               color: HexColor(cita.colorEstado!),
                  //           //               borderRadius: const BorderRadius.all(Radius.circular(15.0))
                  //           //           ),
                  //           //           child: Text(cita.estado!.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w500))
                  //           //       )
                  //           //     ],
                  //           //   ),
                  //           // ),
                  //         ),
                  //         const Divider(height: 0)
                  //       ],
                  //     );
                  //   },
                  // );

                case ConnectionState.none:
                  return const Text('Press button to start.');
              }
            },

          )
      );

    }

}