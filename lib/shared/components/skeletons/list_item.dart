import 'package:flutter/material.dart';

import '../../../constants.dart';

class ListItemSkeleton extends StatelessWidget{

  final int itemCount;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  const ListItemSkeleton({
    super.key,
    required this.itemCount,
    this.controller,
    this.padding,
  });



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: padding ?? const EdgeInsets.all(defaultPadding),
        itemCount: 10,
        controller: controller, // set this too
        itemBuilder: (_, i) => Card(
          color: kGray100Color,
          elevation: 0,
          child: ListTile(
            horizontalTitleGap: 10,
            minVerticalPadding: defaultPadding,
            leadingAndTrailingTextStyle: const TextStyle(
                fontSize: 30
            ),
            leading: const ItemSkeleton(
              height: 50,
              width: 50,
              radius: 100,
            ),
            title: ItemSkeleton(
              height: 18,
              width: MediaQuery.of(context).size.width,
              radius: 5,
            ),
            subtitle: const ItemSkeleton(
              height: 10,
              width: 100,
              radius: 5,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            trailing: const ItemSkeleton(
              height: 30,
              width: 15,
              radius: 100,
            )
          ),
        ),
    );
  }
}




class ItemSkeleton extends StatefulWidget{
  const ItemSkeleton({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
    this.margin,
  });

  final double width;
  final double height;
  final double radius;
  final EdgeInsetsGeometry? margin;

  @override
  _ItemSkeleton createState() => _ItemSkeleton();
}

class _ItemSkeleton extends State<ItemSkeleton> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Color?> colorAnimation;

  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this,)..repeat(reverse: true);
    colorAnimation = ColorTween(begin: kGray200Color, end: kGray300Color).animate(_controller);
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
              alignment: Alignment.center,
              width: widget.width,
              height: widget.height,
              margin: widget.margin,
              decoration: BoxDecoration(
                color: colorAnimation.value,
                borderRadius: BorderRadius.circular(widget.radius)
              ),
            );
        });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}