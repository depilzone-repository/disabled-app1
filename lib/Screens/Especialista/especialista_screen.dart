import 'package:flutter/material.dart';

import '../../components/background.dart';
import '../../constants.dart';
import '../../responsive.dart';

class EspecialistaScreen extends StatefulWidget {
  const EspecialistaScreen({super.key});

  @override
  State<EspecialistaScreen> createState() => _EspecialistaScreenState();

}

class _EspecialistaScreenState extends State<EspecialistaScreen> {

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileEspecialistaScreen(),
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



class MobileEspecialistaScreen extends StatefulWidget {
  const MobileEspecialistaScreen({
    super.key
  });

  @override
  State<MobileEspecialistaScreen> createState() => _MobileEspecialistaScreenState();

}

class _MobileEspecialistaScreenState extends State<MobileEspecialistaScreen> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                         BoxShadow(
                            color: Colors.white,
                            blurRadius: 0.0,
                            offset: Offset(0, 0)
                        ),
                      ],
                    ),
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.transparent,
                      elevation:5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                "DEPILZONE",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: kGray900Color
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Text(
                                "Centro Depilación Láser",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: kGray500Color
                                )
                            ),
                            const SizedBox(height: defaultPadding * 2),
                            ElevatedButton(
                                onPressed: (){
                                  // ignore: avoid_print

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kDepilColor
                                ),
                                child:  const Row(
                                  children: [
                                      Icon(Icons.play_arrow, color: Colors.white),
                                      Expanded(
                                          child: Text(
                                              'Desliza para atender',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),
                                              textAlign: TextAlign.center,
                                          )
                                      ),
                                      Icon(Icons.play_arrow, color: Colors.white),
                                  ],
                                )
                            ),
                            const SizedBox(height: defaultPadding),
                            ElevatedButton(
                                onPressed: (){
                                  // ignore: avoid_print

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kDepilColor
                                ),
                                child:  const Row(
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    Expanded(
                                        child: Text(
                                          'Desliza para atender',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                    ),
                                    Icon(Icons.play_arrow, color: Colors.white),
                                  ],
                                )
                            ),
                            const SizedBox(height: defaultPadding),
                            ElevatedButton(
                                onPressed: (){
                                  // ignore: avoid_print

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kDepilColor
                                ),
                                child:  const Row(
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    Expanded(
                                        child: Text(
                                          'Siguiente',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                    ),
                                    Icon(Icons.play_arrow, color: Colors.white),
                                  ],
                                )
                            ),
                            const SizedBox(height: defaultPadding),
                            ElevatedButton(
                                onPressed: (){
                                  // ignore: avoid_print

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kDepilColor
                                ),
                                child:  const Row(
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    Expanded(
                                        child: Text(
                                          'Tarde',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                    ),
                                    Icon(Icons.play_arrow, color: Colors.white),
                                  ],
                                )
                            ),
                            const SizedBox(height: defaultPadding),
                            ElevatedButton(
                                onPressed: (){
                                  // ignore: avoid_print

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kDepilColor
                                ),
                                child:  const Row(
                                  children: [
                                    Icon(Icons.play_arrow, color: Colors.white),
                                    Expanded(
                                        child: Text(
                                          'Cerrar sesión',
                                          style: TextStyle(
                                              color: Colors.white
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                    ),
                                    Icon(Icons.play_arrow, color: Colors.white),
                                  ],
                                )
                            ),

                            const Text(
                                "3 personas en cola ❯",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: kGray500Color
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                ),
            )
          ],
        ),
        const Card(
          child: Column(
            children: [
              Text("Hola")
            ]
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ignore: avoid_print
  }
}
