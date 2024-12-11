import 'dart:async';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../listView/ListViewClienteEspera.dart';
import '../skeletons/list_item.dart';

class BottomSheetClientesEspera extends StatefulWidget{
  const BottomSheetClientesEspera({super.key});

  @override
  State<BottomSheetClientesEspera> createState() => _BottomSheetClientesEsperaState();

}



class _BottomSheetClientesEsperaState extends State<BottomSheetClientesEspera> {

  bool loading = true;


  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      loading = false;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return DraggableScrollableSheet(
      expand: false,
      builder: (_, controller) {
        return ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            child: Container(
                color: Colors.white,
                child: Column(
                    children: [
                      ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(defaultPadding*2, defaultPadding, defaultPadding*2, defaultPadding),
                          leading: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.arrow_back_rounded) // the arrow back icon
                            ),
                          ),
                          title: const Center(
                              child: Text(
                                "0 Clientes en espera",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                              ) // Your desired title
                          ),
                          trailing: InkWell(
                              onTap: (){},
                              child: const Icon(Icons.refresh_rounded) // the arrow back icon
                          )
                      ),
                      Expanded(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(defaultPadding, 0, defaultPadding, defaultPadding),
                            child: loading ?  ListItemSkeleton(controller: controller, itemCount: 10) : ListViewClienteEspera(controller: controller)
                          )
                      )
                    ]
                )
            )
        );
      },
    );
  }
}