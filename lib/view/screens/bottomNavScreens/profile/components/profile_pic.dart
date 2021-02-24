import 'package:ShopyFast/view/screens/forms/signUpScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String url;
  ProfilePic(this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            CachedNetworkImage(
              imageUrl: url,
              fadeInDuration: Duration(milliseconds: 250),
              imageBuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
              ),
            ),
            // Positioned(
            //   right: -16,
            //   bottom: 0,
            //   child: SizedBox(
            //     height: 47,
            //     width: 47,
            //     child: FlatButton(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50),
            //         side: BorderSide(color: Colors.white),
            //       ),
            //       color: Color(0xFFF5F6F9),
            //       onPressed: onEditPressed,
            //       child: Icon(
            //         Icons.edit,
            //         size: 20,
            //         color: Colors.grey[600],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
