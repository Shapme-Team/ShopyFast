import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:ShopyFast/utils/globals.dart';
import 'package:flutter/material.dart';

class PlusMinusWidget extends StatelessWidget {
  final int quantity;
  final Function onClick;

  const PlusMinusWidget(this.quantity, this.onClick);

  @override
  Widget build(BuildContext context) {
    return quantity > 0
        ? buildIncrementDecrement(context)
        : GestureDetector(
            onTap: () {
              onClick(IncrementDecrement.INCREMENT, context);
            },
            child: Container(
              width: getWidth(100),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Add',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          );
  }

  Widget buildIncrementDecrement(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 120),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          plusMinusButton(IncrementDecrement.DECREMENT, context),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Text(quantity.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          plusMinusButton(IncrementDecrement.INCREMENT, context),
        ],
      ),
    );
  }

  Widget plusMinusButton(IncrementDecrement idValue, BuildContext context) {
    var isIncrement = idValue == IncrementDecrement.INCREMENT;
    return GestureDetector(
      onTap: () => onClick(idValue, context),
      child: Container(
        // height: 30,
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.redAccent,
          ),
          borderRadius: BorderRadius.only(
            topLeft: !isIncrement ? Radius.circular(8) : Radius.zero,
            topRight: isIncrement ? Radius.circular(8) : Radius.zero,
            bottomLeft: !isIncrement ? Radius.circular(8) : Radius.zero,
            bottomRight: isIncrement ? Radius.circular(8) : Radius.zero,
          ),
        ),
        // width: 30,
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
