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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
