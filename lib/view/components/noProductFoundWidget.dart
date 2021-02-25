import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/size_config.dart';

class NoProductFoundWidget extends StatelessWidget {
  NoProductFoundWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            Icons.error,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nothing Found',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
