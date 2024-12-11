import 'package:depilzone_cliente/Screens/Tienda/Zona/store_screen.dart';
import 'package:depilzone_cliente/constants.dart';
import 'package:depilzone_cliente/shared/utils/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../shared/services/auth_service.dart';
import '../Perfil/perfil_screen.dart';

class MenuPrincipalScreen extends StatelessWidget{
  const MenuPrincipalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

        key: key,

        appBar: AppBar(
          // toolbarHeight: 70.0,
          centerTitle: true,
          // leading: IconButton(
          //   // style: IconButton.styleFrom(
          //   //   // backgroundColor: Colors.red
          //   // ),
          //   onPressed: (){
          //     Navigator.pop(context, false);
          //   },
          //   icon:const Icon(FeatherIcons.chevronLeft, size: 30),
          //   //replace with our own icon data.
          // ),
          backgroundColor: Colors.white,
          title: const Text('Menú Principal', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          leading: IconButton(
            // style: IconButton.styleFrom(
            //   // backgroundColor: Colors.red
            // ),
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(FeatherIcons.chevronLeft, size: 30),
            //replace with our own icon data.
          ),
        ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // Cuenta Depilzone
              ExpansionTile(
                  shape: const Border(
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                  ),
                  initiallyExpanded: true,
                  title: const Text("Cuenta Depilzone", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dDarkColor)),
                  backgroundColor: kIndigo10Color,
                  collapsedBackgroundColor: kIndigo10Color,
                  iconColor: dLightColor,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            visualDensity: const VisualDensity(vertical: 3),
                            leading: const Icon(Symbols.account_circle_sharp, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                            title: const Text("Mi Perfil", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                            // subtitle: const Text("Edita  tu información personal, alias, foto de perfil", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                            trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
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
                          )
                        ],
                      ),
                    ),
                  ]
              ),

              // Tienda Depilzone
              ExpansionTile(
                shape: const Border(
                  top: BorderSide.none,
                  bottom: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none,
                ),
                initiallyExpanded: true,
                title: const Text("Tienda Depilzone", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dDarkColor)),
                backgroundColor: kIndigo10Color,
                collapsedBackgroundColor: kIndigo10Color,
                iconColor: dLightColor,
                collapsedIconColor: dDarkColor,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.storefront_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Ir a la tienda", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Edita  tu información personal, alias, foto de perfil", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: (){
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => const StoreScreen(),
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
                        ),
                        const Divider(height: 0, color: dLightColor),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.featured_seasonal_and_gifts_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Descuentos", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Mira todos los descuentos que tienes por ser cliente depilzone.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: (){

                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // Atención al Cliente
              ExpansionTile(
                shape: const Border(
                  top: BorderSide.none,
                  bottom: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none,
                ),
                initiallyExpanded: true,
                title: const Text("Atención al Cliente", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dDarkColor)),
                backgroundColor: kIndigo10Color,
                collapsedBackgroundColor: kIndigo10Color,
                iconColor: dLightColor,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.help_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Preguntas Frecuentes", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Un listado de preguntas frecuentes que te ayudaran.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: (){

                          },
                        ),
                        const Divider(height: 0, color: dLightColor),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.unknown_document_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Términos y condiciones", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Mira todos los descuentos que tienes por ser cliente depilzone.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: (){

                          },
                        ),
                        const Divider(height: 0, color: dLightColor),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.privacy_tip_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Política de Privacidad de Datos personales", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Mira todos los descuentos que tienes por ser cliente depilzone.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: (){

                          },
                        ),
                        const Divider(height: 0, color: dLightColor),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.chat_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Escríbenos por whatsapp", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Mira todos los descuentos que tienes por ser cliente depilzone.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          trailing: const Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: () async {
                              await CoreUtil.launchWhatsapp();
                          },
                        ),
                        const Divider(height: 0, color: dLightColor),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.help_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: dBlackColor),
                          title: const Text("Ayuda", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: dBlackColor)),
                          // subtitle: const Text("Mira todos los descuentos que tienes por ser cliente depilzone.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          // trailing: Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: (){

                          },
                        ),
                        ListTile(
                          visualDensity: const VisualDensity(vertical: 3),
                          leading: const Icon(Symbols.exit_to_app_rounded, size: 32.0, weight: 450.0, opticalSize: 10, color: kWarningColor),
                          title: const Text("Cerrar sesión", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: kWarningColor)),
                          // subtitle: const Text("Mira todos los descuentos que tienes por ser cliente depilzone.", style: TextStyle(fontSize: 12, color: dBlackColor, fontWeight: FontWeight.w500),),
                          // trailing: Icon(Symbols.chevron_right_rounded, color: dDarkColor, weight: 450.0, opticalSize: 10,),
                          onTap: () async{

                            // Guardar el estado de inicio de sesión
                            await logout();

                            Navigator.pushReplacementNamed(context, '/login');

                          },
                        ),
                        const SizedBox(height: 100),
                        const Text("V 2.0.0", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, color: dDarkColor),)
                      ],
                    ),
                  ),

                ],
              ),
            ],
          )
        ],
      )


    );
  }

}