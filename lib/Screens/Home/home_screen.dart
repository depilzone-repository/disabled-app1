
import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../constants.dart';
import '../../responsive.dart';
import '../../shared/components/bottomSheet/bs_lista_clientes_espera.dart';
import 'descuentos.dart';


// This is the type used by the popup menu below.
enum SampleItem { itemOne, itemTwo, itemThree }


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileHomeScreen(),
          desktop: Row(
            children: [

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}



class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({
    super.key
  });

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();

}

class _MobileHomeScreenState extends State<MobileHomeScreen> {

  SampleItem? selectedMenu;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // color: kGray200Color,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff03b7f9), Color(0xff03466b)],
            stops: [0.1, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding*3),
            decoration: const BoxDecoration(
              // color: kDepilColor,
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: '!Hola, ',
                style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Poppins'),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Yosel',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  TextSpan(
                    text: '!',
                  ),
                ],
              ),
            )
          ),
          // const SizedBox(
          //   child: Descuentos()
          // ),

          Expanded(
            child: Container(
                color: kGray100Color,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, defaultPadding, 0, defaultPadding),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    for(int i = 0; i < 7; i++)
                                      boxPromociones(7, i)
                                  ]
                              )
                          )
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0 , defaultPadding, 0 , 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(defaultPadding, 0, 0, 0),
                              child: Text("Box disponibles 7/4", style: TextStyle(fontWeight: FontWeight.w500, color: kGray600Color, fontSize: 16)),
                            ),
                            const SizedBox(height: defaultPadding),
                            Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for(int i = 0; i < 7; i++)
                                        BoxButton(7, (i+1), context)
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                        Container(
                            padding:  const EdgeInsets.fromLTRB(defaultPadding*2, defaultPadding*2, defaultPadding*2, defaultPadding),
                            margin:  const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            alignment: Alignment.center,
                            child: const Row(
                              children: [
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text("Nombre: ", style: TextStyle(fontWeight: FontWeight.w500, color: kGray600Color, fontSize: 16)),
                                        Text("Hora Cita: ", style: TextStyle(fontWeight: FontWeight.w500, color: kGray600Color, fontSize: 16)),
                                        Text("Servicio: ", style: TextStyle(fontWeight: FontWeight.w500, color: kGray600Color, fontSize: 16)),
                                      ],
                                    )
                                )
                              ],
                            )
                        )
                    ]
                )
            )
          ),
        ],
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: avoid_print
  }
}





Widget BoxButton(int lenght, int index, BuildContext context){
  return Container(
      //padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
      margin: EdgeInsets.fromLTRB(defaultPadding, 0, (lenght == index) ? defaultPadding : 0, defaultPadding),
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: index % 2 == 0 ? const LinearGradient(colors: [kDepilColor, Colors.indigo]) : null,
      ),
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: index % 2 == 0 ? Colors.transparent : null,
            maximumSize: const Size.fromHeight(80),
            padding: const EdgeInsets.fromLTRB(defaultPadding + 10, defaultPadding/2, defaultPadding + 10, defaultPadding/2),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
            )
        ),
        onPressed: index % 2 == 0 ? (){
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 100
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                builder: (_) {
                  return const BottomSheetClientesEspera();
                },
            );
        } : null,
        child: Row(
          children: [
              Opacity(
                  opacity: index % 2 == 0 ? 1.0 : 0.5,
                  child: Image.asset(
                    index % 2 == 0 ? 'assets/images/door_open.png' : 'assets/images/door_close.png',
                    width: 50,
                  )
              ),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Box ${index.toString().padLeft(2,'0')}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                          Text(index % 2 == 0 ? "Disponible" : "Ocupado", style: const TextStyle(color: Colors.white, fontSize: 12)),
                          // Text("Servicios:  ${index.toString().padLeft(2,'0')}", style: TextStyle(color: Colors.white)),
                        ],
                      )
                  )
              )
          ],
        ),
      ),
  );
}

Widget BoxButtonSkeleton(int lenght, int index){
  return Container(
    //padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
    margin: EdgeInsets.fromLTRB(defaultPadding, 0, (lenght == index) ? defaultPadding : 0, defaultPadding),
    width: 280,
    child: ElevatedButton(
      style: OutlinedButton.styleFrom(
          maximumSize: const Size.fromHeight(80),
          padding: const EdgeInsets.fromLTRB(defaultPadding + 10, defaultPadding/2, defaultPadding + 10, defaultPadding/2),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))
          )
      ),
      onPressed: index % 2 == 0 ? (){} : null,
      child: Row(
        children: [
          Image.asset( index % 2 == 0 ? 'assets/images/door_open.png' : 'assets/images/door_close.png', width: 50,),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(defaultPadding, 0, 0, 0),
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Box ${index.toString().padLeft(2,'0')}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                      Text(index % 2 == 0 ? "Disponible" : "Ocupado", style: const TextStyle(color: Colors.white, fontSize: 12)),
                      // Text("Servicios:  ${index.toString().padLeft(2,'0')}", style: TextStyle(color: Colors.white)),
                    ],
                  )
              )

          )
        ],
      ),
    ),
  );
}

Widget boxPromociones(int lenght, int index){
  return Container(
      padding:  const EdgeInsets.fromLTRB(defaultPadding*2, defaultPadding*2, defaultPadding*2, defaultPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      margin: EdgeInsets.fromLTRB(defaultPadding, 0, ((lenght-1) == index) ? defaultPadding : 0 , defaultPadding),
      width: 280,
      alignment: Alignment.center,
      child: const Descuentos()
  );
}

class MyCustomClipper  extends CustomClipper<Path>{
  @override
  getClip(Size size){
    double w = size.width;
    double h = size.height;

    final path = Path();
    path.moveTo(0,0);
    path.lineTo(0, h);
    path.quadraticBezierTo(size.width*0.5,size.height-100,size.width*0.2625000,size.height*0.6660000);
    path.lineTo(h, w);
    path.lineTo(w, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

