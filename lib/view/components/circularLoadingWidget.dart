import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatefulWidget {
  @override
  CircularLoadingWidgetState createState() => CircularLoadingWidgetState();
}

class CircularLoadingWidgetState extends State<CircularLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
