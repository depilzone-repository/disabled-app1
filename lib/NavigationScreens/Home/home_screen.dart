import 'package:depilzone_cliente/shared/services/cita_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../Screens/Cita/cita_screen.dart';
import '../../Services/shared_preferences.dart';
import '../../constants.dart';
import '../../shared/components/skeletons/list_item.dart';
import '../../shared/models/Cita.dart';
import '../../shared/models/Servicio.dart';
import '../../shared/models/Usuario.dart';
import '../../shared/services/servicio_service.dart';
import '../../shared/services/shared_pref.dart';
import '../../shared/utils/colors.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {

  ScrollController scrollController = ScrollController();

  Usuario? currentUser;
  final SharedPref sharedPref = SharedPref();

  bool loadingServices = false;
  List<Servicio> services = [];

  bool loadingCita = false;
  List<GrupoCita> grupoCitas = [];

  int _servicioSelected = 0;

  Future<void> _cargarUsuario() async {
    Usuario? user = await getUsuario();
    setState(() {
      currentUser = user!;
    });
  }

  _loadServices()  async {
    setState(() { loadingServices = true; });
    services = await fetchServicios();
    setState(() { loadingServices = false; });
  }

  _selectService(int idService) async {
    setState(() {
      _servicioSelected = idService;
    });
    await _loadCitas();
  }

  _loadCitas()  async {
    Usuario? currentUser = await getUsuario();
    setState(() { loadingCita = true; });
    grupoCitas = await fetchCitasByService(currentUser!.id!, _servicioSelected);
    setState(() { loadingCita = false; });
  }

  final Future<String> _promociones = Future<String>.delayed(
    const Duration(seconds: 5),
        () => "Todavia no tiene promociones activas",
  );




  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cargarUsuario();
    _loadServices();
    _loadCitas();

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   _incrementCounter();
    // });


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    DateFormat format = DateFormat("dd/MM/yyyy hh:mm a");


    return Column(
      children: [
        Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.fromLTRB(0, defaultPadding, 0, defaultPadding),
                    child: loadingServices ? SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(defaultPadding,0,defaultPadding,defaultPadding),
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                          spacing: 10,
                          children: [
                            for (var i = 0; i < 5 ; i++)
                              const ItemSkeleton(width: 100,height: 40,radius: 25,)
                          ]
                      ),
                    ) :
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(defaultPadding,0,defaultPadding,0),
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                          spacing: 10,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                _selectService(0);
                              },
                              style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  backgroundColor: _servicioSelected == 0 ? kDepilLightColor : kGray200Color,
                                  side:  BorderSide(
                                      color: _servicioSelected == 0 ? kDepilLightColor : kGray200Color,
                                      // width: 2.0
                                      width: 0
                                  )
                              ),
                              child:  Text('Todos', style: TextStyle(color: _servicioSelected == 0 ? kDepilColor300 : kGray400Color )),
                            ),

                            for (var servicio in services)
                              OutlinedButton(
                                onPressed: () async {
                                  _selectService(servicio.id);
                                },
                                style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    backgroundColor: _servicioSelected == servicio.id ? kDepilLightColor : kGray200Color,
                                    side:  BorderSide(
                                        color: _servicioSelected == servicio.id ? kDepilLightColor : kGray200Color,
                                        // width: 2.0
                                        width: 0
                                    )
                                ),
                                child: Text(servicio.nombre, style: TextStyle(color: _servicioSelected == servicio.id ? kDepilColor300 : kGray400Color)),
                              )
                          ]
                      ),
                    )
                  ),
                /*  Container(
                      padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                      decoration: const BoxDecoration(
                        color: kIndigo,
                        boxShadow: [
                          BoxShadow(
                            color: kGray300Color,
                            blurRadius: 2,
                            offset: Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total: ${grupoCitas.map((e) => e.citas?.length).reduce((value, element) => value! + element!)}', style: const TextStyle( fontWeight: FontWeight.w600, color: Colors.white )),
                          const Text('', textAlign: TextAlign.start, style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: kGray800Color )),
                        ],
                      )

                  ),*/

                  Expanded(
                      child: loadingCita ? const ListItemSkeleton(
                        itemCount: 10,
                        padding: EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, defaultPadding),
                      ) :
                      SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, defaultPadding*6),
                        child: Column(
                          children: [
                            for(var group in grupoCitas)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(defaultPadding, 5, defaultPadding, 5),
                                      margin: const EdgeInsets.symmetric(vertical: defaultPadding),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kIndigo20Color
                                      ),
                                      child: Text(group.texto!, style: const TextStyle(color: kGray600Color, fontSize: 12, fontWeight: FontWeight.w500))
                                    ),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                      padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                                      shrinkWrap: true,
                                      itemCount: group.citas!.length,
                                      controller: scrollController,
                                      itemBuilder: (BuildContext context, int index){

                                        String imageService = '';
                                        switch(group.citas![index].idServicio){
                                          case 1: imageService = 'assets/images/services/depilacion_laser.jpg';break;
                                          case 2: imageService = 'assets/images/services/blanqueamiento.jpg';break;
                                          case 3: imageService = 'assets/images/services/corporal_360.jpg';break;
                                          case 4: imageService = 'assets/images/services/tratamiento_facial.jpg';break;
                                          default:  imageService = 'assets/images/services/depilacion_laser.jpg';break;
                                        }


                                        return Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: defaultPadding/2, horizontal: 0),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  alignment: AlignmentDirectional.bottomEnd,
                                                  children: [
                                                    Hero(
                                                      tag: 'cita-hero',
                                                      child: Card(
                                                        clipBehavior: Clip.antiAlias,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.0),
                                                        ),
                                                        elevation: 10.0,
                                                        color: kIndigo100Color,
                                                        child: ListTile(
                                                          dense: false,
                                                          contentPadding: const EdgeInsets.fromLTRB(defaultPadding/2, 0, defaultPadding/2, 0),
                                                          horizontalTitleGap: defaultPadding,
                                                          minVerticalPadding: defaultPadding,
                                                          minLeadingWidth: 20,
                                                          leadingAndTrailingTextStyle: const TextStyle(
                                                              fontSize: 12
                                                          ),
                                                          leading: CircleAvatar(
                                                              backgroundColor: kIndigo50Color,
                                                              radius: 30,
                                                              child: CircleAvatar(
                                                                radius: 22,
                                                                backgroundImage: AssetImage(imageService),
                                                              )
                                                          ),
                                                          title: Text(group.citas![index].servicio!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, color: Colors.white),),
                                                          subtitle: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('#${group.citas![index].idCita!.toString().padLeft(7,'0')}', style: const TextStyle(fontSize: 12, color: Colors.white)),
                                                              Text(format.format(group.citas![index].fecha!), style: const TextStyle(fontSize: 12, color: Colors.white)),
                                                              /* Container(
                                                              padding: const EdgeInsets.fromLTRB(defaultPadding, 2, defaultPadding, 2) ,
                                                              decoration: BoxDecoration(
                                                                  color: HexColor(group.citas![index].colorEstado!),
                                                                  borderRadius: const BorderRadius.all(Radius.circular(15.0))
                                                              ),
                                                              child: Text(group.citas![index].estado!.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w500))
                                                          )*/
                                                            ],
                                                          ),
                                                          trailing: const Icon(Symbols.chevron_right_rounded, color: Colors.white, size: 40.0),
                                                          onTap: (){
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute<Widget>(builder: (BuildContext context) {
                                                                return CitaScreen(idCita: group.citas![index].idCita!, cita: group.citas![index]);
                                                              }),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: -25,
                                                      right: 40,
                                                      child: Card(
                                                          margin: const EdgeInsets.all(defaultPadding),
                                                          clipBehavior: Clip.antiAlias,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          elevation: 10.0,
                                                          color: HexColor(group.citas![index].colorEstado!),
                                                          child: Container(
                                                              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/3, defaultPadding, defaultPadding/3),
                                                              child: Text(group.citas![index].estado!, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),)
                                                          )
                                                      ),
                                                    ),

                                                  ],
                                                ),

                                              ),

                                              // index > 0 ? const Divider(height: 0) :  SizedBox(),
                                              /*InkWell(
                                                onTap: () async {
                                                  await Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (context, animation, secondaryAnimation) => CitaScreen(idCita: group.citas![index].idCita!),
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
                                                  color: Colors.indigo,
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
                                                        'assets/images/calendario_dia_${group.citas![index].fecha!.day}.svg',
                                                        height: 100.0,
                                                        width: 100.0,
                                                        allowDrawingOutsideViewBox: false,
                                                      ),
                                                    ),
                                                    title: Text(group.citas![index].servicio!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),),
                                                    subtitle: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(format.format(group.citas![index].fecha!), style: const TextStyle(fontSize: 12)),
                                                        Container(
                                                            padding: const EdgeInsets.fromLTRB(defaultPadding, 2, defaultPadding, 2) ,
                                                            decoration: BoxDecoration(
                                                                color: HexColor(group.citas![index].colorEstado!),
                                                                borderRadius: const BorderRadius.all(Radius.circular(15.0))
                                                            ),
                                                            child: Text(group.citas![index].estado!.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w500))
                                                        )
                                                      ],
                                                    ),
                                                    trailing: Icon(Symbols.chevron_right_rounded, color: Colors.white),
                                                  ),
                                                ),

                                              ),*/
                                            ]
                                        );
                                      },
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      )

                  ),
                ],
              ),


            )
        )
      ],
    );
  }
}