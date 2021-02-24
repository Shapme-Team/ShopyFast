import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  final Color color;
  CircularLoadingWidget({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: color ?? Theme.of(context).primaryColor,
      )),
    );
  }
}
