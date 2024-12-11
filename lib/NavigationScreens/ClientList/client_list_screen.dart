import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../shared/components/listView/ListViewClienteEspera.dart';
import '../../shared/components/skeletons/list_item.dart';


class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {

  bool loading = true;

  @override
  void initState() {
    Timer(const Duration(seconds: 6), () {
      loading = false;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();

  }


  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children: [
        ClipPath(
          clipper:  ClipPathClass(),
          clipBehavior: Clip.hardEdge,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff0e2443),
            ),
            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, defaultPadding),
            child: const Column(
                children: [
                  Center(child: Text("En espera", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),)),
                  Center(child: Text("0", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),)),
                ]
            ),
          ),
        ),
        Expanded(
            child: Container(
                padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding, defaultPadding, 0),
                child: loading ?  const ListItemSkeleton(controller: null, itemCount: 10) : const ListViewClienteEspera(controller: null)
            ),
        )
      ],
    );
  }
}


class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}