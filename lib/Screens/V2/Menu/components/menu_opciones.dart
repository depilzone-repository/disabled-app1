
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Services/shared_preferences.dart';
import '../../../../constants.dart';
import '../../../Perfil/perfil_screen.dart';


class MenuOpciones extends StatelessWidget{
  const MenuOpciones({super.key});


  _launchWhatsapp() async {
    var contact = "+51980924651";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hola, necesito información";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hola, necesito información')}";

    try{
      if (!kIsWeb) {
        if(Platform.isIOS){
          // await launchUrl(Uri.parse(iosUrl));
          await launch(iosUrl);
        }
        else{
          // await launchUrl(Uri.parse(androidUrl));
          await launch(androidUrl);
        }
      }else{
        // await launchUrl(Uri.parse(iosUrl));
        await launch(iosUrl);
      }

    } on Exception{
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }



  @override
  Widget build(BuildContext context){


    return ListView(
      children: [
        ExpansionTile(
            shape: const Border(
              top: BorderSide.none,
              bottom: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
            ),
            initiallyExpanded: true,
            title: const Text("Cuenta Depilzone", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: kGray600Color)),
            backgroundColor: kGray200Color,
            collapsedBackgroundColor: kGray200Color,
            iconColor: kGray400Color,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0 ,0 , 0),
                color: Colors.white,
                child: Column(
                  children: [
          /*          ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const AgendarCitaScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(0.0, -1.0);
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
                        leading: Icon(Symbols.calendar_add_on_rounded, color: Colors.green[400],size: 34),
                        title: const Text('Agendar Cita', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kGray600Color)),
                        trailing: IconButton(
                            onPressed: (){},
                            icon: const Icon(Symbols.chevron_right_rounded, color: kDepilColor,)
                        )
                    ),
                    const Divider(height: 0),
                    ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const ListaCitasScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              )
                          );
                        },
                        leading: Icon(Symbols.ballot_rounded, color: Colors.indigo[400],size: 34),
                        title: const Text('Lista de Citas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kGray600Color)),
                        trailing: IconButton(
                            onPressed: (){},
                            icon: const Icon(Symbols.chevron_right_rounded, color: kDepilColor,)
                        )
                    ),
                    const Divider(height: 0),*/
                    ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
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
                        // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                        title: const Text('Información Personal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                        subtitle: const Text('Edita tu información personal, alias, foto de perfil, etc.', style: TextStyle(fontSize: 11)),
                        trailing: IconButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
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
                            icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                        )
                    ),
                    const Divider(height: 0),

                    // ListTile(
                    //     contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                    //     onTap: (){
                    //       Navigator.push(
                    //           context,
                    //           PageRouteBuilder(
                    //             pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                    //             transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    //               const begin = Offset(1.0, 0.0);
                    //               const end = Offset.zero;
                    //               const curve = Curves.ease;
                    //
                    //               var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    //
                    //               return SlideTransition(
                    //                 position: animation.drive(tween),
                    //                 child: child,
                    //               );
                    //             },
                    //           )
                    //       );
                    //     },
                    //     // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                    //     title: const Text('Información Personal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: kGray900Color)),
                    //     trailing: IconButton(
                    //         onPressed: (){
                    //           Navigator.push(
                    //               context,
                    //               PageRouteBuilder(
                    //                 pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                    //                 transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    //                   const begin = Offset(1.0, 0.0);
                    //                   const end = Offset.zero;
                    //                   const curve = Curves.ease;
                    //
                    //                   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    //
                    //                   return SlideTransition(
                    //                     position: animation.drive(tween),
                    //                     child: child,
                    //                   );
                    //                 },
                    //               )
                    //           );
                    //         },
                    //         icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                    //     )
                    // ),
                  ],
                ),
              )
            ],
        ),

        ExpansionTile(
          shape: const Border(
            top: BorderSide.none,
            bottom: BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
          ),
          initiallyExpanded: true,
          title: const Text("Tienda Depilzone", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: kGray600Color)),
          backgroundColor: kGray200Color,
          collapsedBackgroundColor: kGray200Color,
          iconColor: kGray400Color,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0 ,0 , 0),
              color: Colors.white,
              child: Column(
                children: [
                  /*          ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const AgendarCitaScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(0.0, -1.0);
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
                        leading: Icon(Symbols.calendar_add_on_rounded, color: Colors.green[400],size: 34),
                        title: const Text('Agendar Cita', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kGray600Color)),
                        trailing: IconButton(
                            onPressed: (){},
                            icon: const Icon(Symbols.chevron_right_rounded, color: kDepilColor,)
                        )
                    ),
                    const Divider(height: 0),
                    ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: (){
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const ListaCitasScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              )
                          );
                        },
                        leading: Icon(Symbols.ballot_rounded, color: Colors.indigo[400],size: 34),
                        title: const Text('Lista de Citas', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kGray600Color)),
                        trailing: IconButton(
                            onPressed: (){},
                            icon: const Icon(Symbols.chevron_right_rounded, color: kDepilColor,)
                        )
                    ),
                    const Divider(height: 0),*/
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      onTap: (){
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
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
                      // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                      title: const Text('Productos', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                      subtitle: const Text('Mira los productos que tenemos para ti.', style: TextStyle(fontSize: 11)),
                      trailing: IconButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
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
                          icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                      )
                  ),
                  const Divider(height: 0),
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      onTap: (){
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
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
                      // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                      title: const Text('Descuentos', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                      subtitle: const Text('Mira todos los descuentos que tienes por ser cliente depilzone', style: TextStyle(fontSize: 11)),
                      trailing: IconButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
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
                          icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                      )
                  ),
                ],
              ),
            )
          ],
        ),



        ExpansionTile(
          shape: const Border(
            top: BorderSide.none,
            bottom: BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
          ),
          initiallyExpanded: true,
          title: const Text("Atención al Cliente", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: kGray600Color)),
          backgroundColor: kGray200Color,
          collapsedBackgroundColor: kGray200Color,
          iconColor: kGray400Color,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0 ,0 , 0),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      onTap: (){
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
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
                      // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                      title: const Text('Preguntas Frecuentes', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                      subtitle: const Text('Mira los productos que tenemos para ti.', style: TextStyle(fontSize: 11)),
                      trailing: IconButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
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
                          icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                      )
                  ),
                  const Divider(height: 0),
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      onTap: (){
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
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
                      // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                      title: const Text('Términos y condiciones', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                      subtitle: const Text('Mira todos los descuentos que tienes por ser cliente depilzone', style: TextStyle(fontSize: 11)),
                      trailing: IconButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
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
                          icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                      )
                  ),

                  const Divider(height: 0),
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      onTap: (){
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
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
                      // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                      title: const Text('Política de Privacidad y Datos personales', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                      subtitle: const Text('Mira todos los descuentos que tienes por ser cliente depilzone', style: TextStyle(fontSize: 11)),
                      trailing: IconButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const MiPerfilScreen(),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
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
                          icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                      )
                  ),

                  const Divider(height: 0),
                  ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                      onTap: () async {
                        await _launchWhatsapp();
                      },
                      // leading: const Icon(FeatherIcons.user, color: kDepilColor,size: 30),
                      title: const Text('Escríbenos por whatsapp', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: kGray900Color)),
                      subtitle: const Text('Escribenos y uno de nuestros asesores te ayudara', style: TextStyle(fontSize: 11)),
                      trailing: IconButton(
                          onPressed: () async {
                            await _launchWhatsapp();
                          },
                          icon: const Icon(FeatherIcons.chevronRight, color: kDepilColor)
                      )
                  ),
                ],
              ),
            )
          ],
        ),

        Container(
            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2, defaultPadding, defaultPadding*2),
            child: InkWell(
                onTap: () async{

                  // Guardar el estado de inicio de sesión
                  await logout();

                  Navigator.pushReplacementNamed(context, '/login');

                },
                child: const Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: kDepilColor, decoration: TextDecoration.underline, fontWeight: FontWeight.w500,decorationColor: kDepilColor),
                    textAlign: TextAlign.center,
                )
            )
        ),
        const SizedBox(
          height: 100,
          child: Text(
              "v1.1.1",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kGray800Color
              )
          ),
        )
      ],
    );
  }

}