
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../constants.dart';

class ZonaScreen extends StatefulWidget {
  final int idZona;
  const ZonaScreen(this.idZona, {super.key});

  @override
  State<ZonaScreen> createState() => _ZonaScreenState();

}

class _ZonaScreenState extends State<ZonaScreen> {

  ZonaPrecio? variantSelected;

  List<ZonaPrecio> precios = [
    ZonaPrecio(1, 2, 30, null),
    ZonaPrecio(2, 2, 60, null),
    ZonaPrecio(3, 2, 90, 120),
    ZonaPrecio(4, 2, 120, 150),
    ZonaPrecio(5, 2, 150, 180),
    ZonaPrecio(6, 2, 180, 210),
    ZonaPrecio(7, 2, 210, 240),
    ZonaPrecio(8, 2, 240, 270),
    ZonaPrecio(9, 2, 270, 300),
    ZonaPrecio(10, 2, 300, 330),
    ZonaPrecio(11, 2, 330, 360),
    ZonaPrecio(12, 2, 360, 390),
  ];


  _selectVariant(int variantSelected){
    setState(() {
      this.variantSelected = precios.firstWhere((dropdown)=>dropdown.id==variantSelected);
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            stretch: true,
            centerTitle: true,
            expandedHeight: 250.0,
            backgroundColor: kDepilColor,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Regresar', style: TextStyle(color: Colors.white)),
              background: Image.asset(
                "assets/images/items/espalda-completa.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Espalda Completa', style: TextStyle(color: dDarkColor, fontSize: dTitle, fontWeight: FontWeight.w500), textAlign: TextAlign.start),
                  const SizedBox(height: 20),
                  const Text('S/290.00 – S/1,040.00', style: TextStyle(color: dDarkColor, fontSize: dTitle, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
                  const SizedBox(height: 20.0),
                  const Text('Descripción', style: TextStyle(color: dDarkColor, fontSize: dText, fontWeight: FontWeight.w600), textAlign: TextAlign.left),
                  const SizedBox(height: 10.0),
                  const Text('Abarca finalizando la zona cervical hasta el borde superior de los glúteos.', style: TextStyle(color: dDarkColor, fontSize: dText, fontWeight: FontWeight.w400), textAlign: TextAlign.left),
                  const Divider( height: 40,),
                  const Text('Sesiones', style: TextStyle(color: dDarkColor, fontSize: dText, fontWeight: FontWeight.w600), textAlign: TextAlign.left),
                  const SizedBox(height: 10.0),

                  // Variantes
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                        spacing: 10,
                        children: [
            /*              OutlinedButton(
                            onPressed: () async {
                              // _selectService(0);
                            },
                            style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding/2, defaultPadding, defaultPadding/2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                backgroundColor: _servicioSelected == 0 ? kDepilLightColor : kGray200Color,
                                side:  BorderSide(
                                    color: _servicioSelected == 0 ? kDepilLightColor : kGray200Color,
                                    // width: 2.0
                                    width: 0
                                )
                            ),
                            child:  Text('Todos', style: TextStyle(color: _servicioSelected == 0 ? kDepilColor300 : kGray400Color )),
                          ),*/

                          for (var sesion = 1; sesion < 13; sesion++)
                            OutlinedButton(
                              onPressed: () async {
                                _selectVariant(sesion);
                              },
                              style: OutlinedButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  padding: const EdgeInsets.all(defaultPadding),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: variantSelected?.id == sesion ? kDepilColor100 : Colors.white,
                                  side:  BorderSide(
                                      color: variantSelected?.id == sesion ? kDepilColor100 : dLightColor,
                                      // width: 2.0
                                      width: 2
                                  )
                              ),
                              child: Text('$sesion', style: TextStyle(color: variantSelected?.id == sesion ? kDepilColor700 : dDarkColor, fontWeight: FontWeight.w600, fontSize: dSubTitle),),
                            )
                        ]
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: variantSelected != null ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10.0,
                      children: [
                        Text("S/ ${ variantSelected?.precioDescuento == null ? variantSelected?.precio.toStringAsFixed(2) : variantSelected?.precioDescuento?.toStringAsFixed(2) }", style: const TextStyle(color: dDarkColor, fontSize: dMaxTitle, fontWeight: FontWeight.w600)),
                        (variantSelected?.precioDescuento != null) ? Text("S/ ${variantSelected?.precio.toStringAsFixed(2)}", style: const TextStyle(color: dLightColor, fontSize: dSubTitle, fontWeight: FontWeight.w600, decoration: TextDecoration.lineThrough, decorationColor: dLightColor, decorationThickness: 2.85)) : const Text('')
                      ],
                    ) : const SizedBox(),
                  ),


                  const SizedBox(height: 50,),
                  const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text("Promociones", style: TextStyle(color: dDarkColor, fontSize: dText, fontWeight: FontWeight.w600)),
                      Text("Ver todo", style: TextStyle(color: kDepilColor, fontSize: dText, fontWeight: FontWeight.w400), textAlign: TextAlign.end,),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      InkWell(
                        onTap: (){ },
                        child: Card(
                          elevation: 0,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            'assets/images/discounts/promocion.jpg',
                            fit: BoxFit.cover,
                          ),
                        )
                      )

                    ],
                  ),


                  const SizedBox(height: 50),
                  const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Text("Zonas relacionadas", style: TextStyle(color: dDarkColor, fontSize: dText, fontWeight: FontWeight.w600)),
                      Text("Ver todo", style: TextStyle(color: kDepilColor, fontSize: dText, fontWeight: FontWeight.w400), textAlign: TextAlign.end,),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0,0,0,0),
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 10,
                      children: [
                        for(var zonasRel = 0; zonasRel < 8; zonasRel++)
                          // InkWell(
                          //     onTap: (){  },
                          //     child:
                            Card(
                                  elevation: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  // child: Image.asset(
                                  //   'assets/images/discounts/promocion.jpg',
                                  //   fit: BoxFit.cover,
                                  // ),
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  // ),
                                  child: InkWell(
                                      onTap: (){  },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.all(defaultPadding),
                                        color: kGray50Color,
                                        width: 250,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(0, 0, 0, defaultPadding/2),
                                              padding: const EdgeInsets.fromLTRB(defaultPadding/2 , defaultPadding/3, defaultPadding/2, defaultPadding/3),
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                  color: Colors.white
                                              ),
                                              child: const Text("50% DESC", style: TextStyle(color: dSecondaryColor, fontSize: dSmall, fontWeight: FontWeight.w600)),
                                            ),

                                            Container(
                                                margin: const EdgeInsets.fromLTRB(0, 0, 0, defaultPadding),
                                                child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                                    child: Image.asset('assets/images/items/brazos-completos.jpg')
                                                )
                                            ),

                                            const Text("Depilación Láser", style: TextStyle(color: kDepilColor, fontSize: dText, fontWeight: FontWeight.w400), textAlign: TextAlign.left),
                                            const Text("Brazos Completos", style: TextStyle(color: dDarkColor, fontSize: dText, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
                                            const SizedBox(height: 20),
                                            const Text("S/120.00 - S/407.00", style: TextStyle(color: kGray900Color, fontSize: dSubTitle, fontWeight: FontWeight.w500), textAlign: TextAlign.left),
                                          ],
                                        ),
                                      )
                                  ),



                              )
                          // )
                      ]
                    )
                  )




                ],
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(0),

          child: ElevatedButton(
            onPressed: (){},
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding)
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      )
                  )
              ),
            child: const Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              spacing: 5,
              children: [
                Icon(Symbols.add_shopping_cart_rounded),
                Text("Añadir al carrito", style: TextStyle(fontWeight: FontWeight.w300),)
              ],
            )
          ),

          /*child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('pinned'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        true = val;
                      });
                    },
                    value: true,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('snap'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _snap = val;
                        // Snapping only applies when the app bar is floating.
                        _floating = _floating || _snap;
                      });
                    },
                    value: _snap,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('floating'),
                  Switch(
                    onChanged: (bool val) {
                      setState(() {
                        _floating = val;
                        _snap = _snap && _floating;
                      });
                    },
                    value: _floating,
                  ),
                ],
              ),
            ],
          ),*/
        ),
      ),
    );
  }

}


class ZonaPrecio{
  late int id;
  late final int? idZona;
  late final double precio;
  late final double? precioDescuento;


  ZonaPrecio(
      int id, int? idZona, double precio, double? precioDescuento
      ){
    this.id = id;
    this.idZona = idZona;
    this.precio = precio;
    this.precioDescuento = precioDescuento;
  }
}