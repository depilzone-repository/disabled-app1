import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../constants.dart';
import '../../../shared/models/Servicio.dart';
import '../../../shared/services/servicio_service.dart';
import 'components/CitaItem.dart';
import 'components/lista_citas_filtro.dart';

class ListaCitasScreen extends StatelessWidget{
  const ListaCitasScreen({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
        key: key,
        endDrawer: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: 300,//Your height goes here
            child: Drawer(
              backgroundColor: Colors.white, //Your background color goes here.
              child: ListView(
                children: const [
                  Text("Filtros")
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(
              color: kGray400Color,
            ),
            backgroundColor: Colors.white,
            title: const Text(
              "Citas",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const ListaCitasFiltro(),
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
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.indigo[50]
                  ),
                  icon: const Icon(Symbols.tune_rounded, color: Colors.indigo)
              )
            ],
        ),
        body: Column(
            children: [
                Expanded(
                    child: Container(
                        color: kGray200Color,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder<List<Servicio>>(
                            future: fetchServicios(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Servicio> servicios = snapshot.data ?? [];
                                return ListView.builder(
                                    padding: const EdgeInsets.all(defaultPadding),
                                    itemCount: servicios.length,
                                    itemBuilder: (context, index) {
                                      Servicio servicio = servicios[index];
                                      return CitaItem(
                                          titulo: servicio.nombre
                                      );
                                    });
                              }else{
                                return const Center(child: Text("No se encontraron datos"));
                              }

                            })

                    )
                )
            ]
        )
    );
  }
}