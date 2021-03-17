import 'package:flutter/material.dart';

class CategoryTypeHeader extends StatelessWidget {
  const CategoryTypeHeader(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
    );
  }
}
