import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../../utils/constants/enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  HomeScreen({this.user});
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'ShopyFast',
          style: TextStyle(
            color: Colors.red[200],
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Icon(Icons.menu),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.exit_to_app),
          //   onPressed: () async {
          //     await FirebaseAuth.instance.signOut();
          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: (context) => LoginScreen()),
          //         (route) => false);
          //   },
          // ),
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          IconButton(
            color: Colors.grey,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
      body: Body()
      // Container(
      //   padding: EdgeInsets.all(32),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text(
      //         "You are Logged in succesfully",
      //         style: TextStyle(color: Colors.lightBlue, fontSize: 32),
      //       ),
      //       SizedBox(
      //         height: 16,
      //       ),
      //       Text(
      //         "${user.phoneNumber}",
      //         style: TextStyle(
      //           color: Colors.grey,
      //         ),
      //       ),
      //     ],
      //   ),
      // )
      ,
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
