import 'package:ShopyFast/view/screens/Auth/phoneAuth.dart';
import 'package:ShopyFast/view/screens/forms/components/signupform.dart';
import 'package:ShopyFast/view/screens/forms/customerdetailform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  final url;
  // const ProfilePic({
  //   Key key,
  // }) : super(key: key);
  ProfilePic(this.url);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
              // backgroundImage: NetworkImage(url.photoURL),
              ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 47,
              width: 47,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                  );
                },
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
