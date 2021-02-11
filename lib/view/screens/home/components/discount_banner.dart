import 'package:flutter/material.dart';

import '../../../../utils/constants/size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getWidth(20),
        vertical: getWidth(15),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "Shopy Fast Welcome Offer\n"),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: getWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
