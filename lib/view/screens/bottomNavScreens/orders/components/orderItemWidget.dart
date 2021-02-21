import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/models/order.dart';
import '../../../../../utils/constants/constants.dart';
import '../orderDetailScreen.dart';

class OrderItemWidget extends StatelessWidget {
  final Order _order;
  OrderItemWidget(this._order);

  @override
  Widget build(BuildContext context) {
    // _order.deliveryStatus = StatusConstant.DONE;
    bool _isActive = false;

    if (_order.deliveryStatus != StatusConstant.DONE) {
      _isActive = true;
    }
    print('datetime of orderItem : ${_order.dateTime}');
    var date = DateFormat('dd MMM yyyy').format(_order.dateTime);
    // Color primary = Theme.of(context).primaryColor;
    Color primary = Colors.blueGrey[50];
    Color white = _isActive ? Colors.black87 : Colors.white;

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(OrderDetailScreen.routeName,
          arguments: OrderDetailScreenArg(_order)),
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: _isActive ? primary : white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: _isActive ? 0 : 1, color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rs ${_order.amount}',
                  style: TextStyle(
                    fontSize: 22,
                    color: _isActive ? white : Colors.black,
                  ),
                ),
                Text(date,
                    style: TextStyle(
                        fontSize: 16, color: _isActive ? white : Colors.black)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: _isActive ? kSecondaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text('${_order.deliveryStatus}',
                      style: TextStyle(
                          color: _isActive ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600)),
                ),
                Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 28,
                  color: Colors.black87,
                )
                // IconButton(
                //   icon: Icon(
                //     Icons.chevron_right_rounded,
                //     // size: 28,
                //   ),
                //   onPressed: () {
                //     Provider.of<CartProvider>(context, listen: false)
                //         .deleteOrder(_order);
                //   },
                // )
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
