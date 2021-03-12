import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VerticalProductShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width / 3,
      // height: 300,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  5,
                  (index) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 3,
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8),
                          Container(
                            height: getHeight(30),
                            color: Colors.white,
                          ),
                          SizedBox(height: getHeight(8)),
                          Container(
                            height: getHeight(10),
                            color: Colors.white,
                          ),
                          SizedBox(height: getHeight(8)),
                          Container(
                            height: getHeight(10),
                            color: Colors.white,
                          ),
                          SizedBox(height: getHeight(8)),
                          Container(
                            height: getHeight(30),
                            color: Colors.white,
                          ),
                          SizedBox(height: getHeight(8)),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(width: getWidth(20)),
              ],
            ),
          )),
    );
  }
}
