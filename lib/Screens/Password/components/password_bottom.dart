import 'package:flutter/material.dart';

class PasswordBottom extends StatelessWidget {
  const PasswordBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

          GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(5, (index) {
              return Center(
                child: Text(
                  'Item $index'
                ),
              );
            }),
          ),

      ],
    );
  }
}
