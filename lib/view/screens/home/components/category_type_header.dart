import 'package:flutter/material.dart';

class CategoryTypeHeader extends StatelessWidget {
  const CategoryTypeHeader(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
            ),
          )
        ],
      ),
    );
  }
}
