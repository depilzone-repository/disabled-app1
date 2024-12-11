import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../shared/components/skeletons/list_item.dart';
import '../../shared/helpers/image_helper.dart';
import '../../shared/helpers/text_helper.dart';
import '../../shared/models/Cliente.dart';
import '../../shared/services/cliente_service.dart';
import 'perfil_editar_alias_screen.dart';
import 'perfil_editar_correo_screen.dart';

class MiPerfilScreen extends StatefulWidget{
  const MiPerfilScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MiPerfilScreenState();

}

final imageHelper = ImageHelper();
final textHelper = TextHelper();

class _MiPerfilScreenState extends State<MiPerfilScreen>{

  Cliente? _currentClient;

  bool loading = false;
  XFile? _image;
  final picker = ImagePicker();

  Future getImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  File? _imageFile;


  Future<void> _getProfile() async {
    setState(() {
      loading = true;
    });

    Cliente client = await getProfile();
    setState(() {
      _currentClient = client;
      loading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getProfile();


  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kGray100Color,
      key: widget.key,
      appBar: AppBar(
        // toolbarHeight: 70.0,
        centerTitle: true,
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
        backgroundColor: Colors.white,
        title: const Text('Mi Perfil', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(defaultPadding),
                // color: Colors.red,
                width: 160,
                height: 160,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      // backgroundImage: _image != null ? FileImage(File(_image!.path)) : null,
                      foregroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      backgroundColor: kGray300Color,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: kDepilColor,
                          ),
                          onPressed: () async {
                            final files = await imageHelper.pickImage();
                            if(files!.isNotEmpty){
                              final croppedFile = await imageHelper.crop(
                                  file: files.first!,
                                  cropStyle: CropStyle.rectangle
                              );
                              if(croppedFile != null){
                                setState(() {
                                  _imageFile = File(croppedFile.path);

                                });
                              }

                            }
                          },
                          icon: const Icon(Icons.photo_camera, color: Colors.white),
                        )
                    )
                  ],
                ),
              ),
              const Text('Información personal', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.0), textAlign: TextAlign.right),
              Card(
                margin: const EdgeInsets.all(defaultPadding),
                color: Colors.white,
                surfaceTintColor: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(defaultPadding/2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        minVerticalPadding: 0,
                        contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                        title: const Text('Nombres completos', style: TextStyle(fontSize: 12.0, color: kGray400Color, fontWeight: FontWeight.w400)),
                        subtitle: loading ? const ItemSkeleton(width: 10.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(_currentClient!.nombres.toString(), style: const TextStyle(color: kGray800Color, fontWeight: FontWeight.w500)),
                        // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : const Icon(FeatherIcons.edit3, color: kDepilColor,)
                        // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Icon(FeatherIcons.edit3) )
                      ),
                      // SizedBox(height: 1),
                      ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                          title: const Text('Apellidos completos', style: TextStyle(fontSize: 12.0, color: kGray400Color, fontWeight: FontWeight.w400)),
                          subtitle: loading ? const ItemSkeleton(width: 10.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(_currentClient!.apellidos.toString(), style: const TextStyle(color: kGray800Color, fontWeight: FontWeight.w500)),
                          // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : const Icon(FeatherIcons.edit3, color: kDepilColor,)
                        // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Icon(FeatherIcons.edit3) )
                      ),
                      ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                          title: const Text('Alias', style: TextStyle(fontSize: 12.0, color: kGray400Color, fontWeight: FontWeight.w400)),
                          subtitle: loading ? const ItemSkeleton(width: 10.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(_currentClient!.alias.toString(), style: const TextStyle(color: kGray800Color, fontWeight: FontWeight.w500)),
                          trailing: loading ?
                          const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) :
                          InkWell(
                              onTap: () async {
                                final result = await Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => EditarAliasScreen(alias: _currentClient!.alias),
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

                                // When a BuildContext is used from a StatefulWidget, the mounted property
                                // must be checked after an asynchronous gap.
                                if (!mounted) return;


                                // After the Selection Screen returns a result, hide any previous snackbars
                                // and show the new result.
                                if(result){
                                  _getProfile();
                                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                }

                              },
                              child: const SizedBox(width: 30,height: 30, child: Icon(FeatherIcons.edit3, color: kDepilColor))
                          )
                        // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Icon(FeatherIcons.edit3) )
                      ),
                      ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                          title: const Text('Celular', style: TextStyle(fontSize: 12.0, color: kGray400Color, fontWeight: FontWeight.w400)),
                          subtitle: loading ? const ItemSkeleton(width: 10.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(textHelper.hideText(_currentClient!.celular1), style: const TextStyle(color: kGray800Color, fontWeight: FontWeight.w500)),
                          trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : const Icon(FeatherIcons.chevronRight, color: kDepilColor,)
                        // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Icon(FeatherIcons.edit3) )
                      ),
                      ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, 0),
                          title: const Text('Correo Electrónico', style: TextStyle(fontSize: 12.0, color: kGray400Color, fontWeight: FontWeight.w400)),
                          subtitle: loading ? const ItemSkeleton(width: 10.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Text(_currentClient!.correo.toString(), style: const TextStyle(color: kGray800Color, fontWeight: FontWeight.w500)),
                          trailing: loading ?
                          const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) :
                          InkWell(
                              onTap: () async {
                                final result = await Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => EditarCorreoScreen(correo: _currentClient!.correo),
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

                                // When a BuildContext is used from a StatefulWidget, the mounted property
                                // must be checked after an asynchronous gap.
                                if (!mounted) return;


                                // After the Selection Screen returns a result, hide any previous snackbars
                                // and show the new result.
                                if(result){
                                    _getProfile();
                                }


                              },
                              child: const SizedBox(width: 30,height: 30, child: Icon(FeatherIcons.edit3, color: kDepilColor))
                          )
                        // trailing: loading ? const ItemSkeleton(width: 20.0,height: 20.0,radius: 5.0,margin: EdgeInsets.all(0)) : Icon(FeatherIcons.edit3) )
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}