import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/customer.dart';
import '../../../../../domain/provider/authprovider.dart';
import '../../../../helper/AppBarWidget.dart';
import '../profile_screen.dart';
import 'editProfileScreen.dart';
import 'profile_pic.dart';

class ProfileHome extends StatefulWidget {
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  Customer currentCustomer;
  Future _fetchFuture;
  @override
  void initState() {
    _fetchFuture =
        Provider.of<AuthProvider>(context, listen: false).getCurrentCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPhotoUrl = Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUser
        .photoURL;
    // print('customer address : ${customer.address}');
    return Scaffold(
        appBar: AppBarWidget(
          context: context,
          routeName: ProfileScreen.routeName,
        ),
        // appBar: AppBar(
        //   elevation: 1,
        //   title: GestureDetector(
        //     onTap: () {
        //       // Provider.of<AuthProvider>(context, listen: false).logout();
        //     },
        //     child: Text('Profile',
        //         style: TextStyle(
        //           color: Theme.of(context).primaryColor,
        //           fontSize: 23,
        //           fontWeight: FontWeight.w600,
        //         )),
        //   ),
        //   // actions: [IconButton(icon: Icon(Icons.feedback), onPressed: null)],
        // ),
        body: FutureBuilder(
            future: _fetchFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else {
                currentCustomer =
                    Provider.of<AuthProvider>(context).getCustomer;
                // print(
                //     'currentCustomer is: profile: ${currentCustomer.toString()}');
                return currentCustomer != null
                    ? SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ProfilePic(userPhotoUrl ?? ''),
                              SizedBox(height: 8.0),
                              insideContainer(
                                  value: currentCustomer.name,
                                  describeText: 'name'),
                              insideContainer(
                                  value: currentCustomer.email,
                                  describeText: 'email id'),
                              insideContainer(
                                  value: currentCustomer.phoneNumber.toString(),
                                  describeText: 'phone no'),
                              insideContainer(
                                  value: currentCustomer.address,
                                  describeText: 'address'),

                              SizedBox(height: 50),
                              // FlatButton(
                              //   child: Text("Sign out", style: theme.textTheme.button),
                              //   onPressed: () async {
                              //   },
                              // )
                            ],
                          ),
                        ),
                      )
                    : Center(child: Text('customer data is null'));
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).pushNamed(
              EditProfileScreen.routeName,
              arguments: SingupScreenArg(currentCustomer)),
          // backgroundColor: Theme.of(context).primaryColor,
          label: Text('edit profile', style: TextStyle(fontSize: 16)),
        ));
  }

  Widget insideContainer({
    String describeText,
    String value,
  }) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Text(describeText),
          ),
          Container(
            child: Text(
                value != null && value.length > 0 ? value : 'not available',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                )),
          ),
        ],
      ),
    );
  }
}
