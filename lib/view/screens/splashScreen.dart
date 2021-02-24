import 'package:ShopyFast/view/components/circularLoadingWidget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ShopyFast',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentColor),
              ),
              CircularLoadingWidget()
            ],
          ),
        ),
      ),
    );
  }
}
