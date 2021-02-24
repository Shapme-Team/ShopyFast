import 'package:ShopyFast/domain/models/customer.dart';
import 'package:ShopyFast/domain/provider/authprovider.dart';
import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/utils/constants/size_config.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = "/sign_up";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _addressController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SingupScreenArg arg = ModalRoute.of(context).settings.arguments;
    var customer = arg.customer;
    _nameController.text = customer.name;
    _addressController.text = customer.address;
    print('building signup screen: ${customer.toString()}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Complete Profile"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildNameFormField(customer.name),
                          buildAdressFormField(customer.address),
                        ],
                      )),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              customer.name = _nameController.text;
              customer.address = _addressController.text;
              await getIt<AuthProvider>().updateCurrentCustomer(customer);
              Navigator.of(context).pop();
            }
          },
          // backgroundColor: Theme.of(context).primaryColor,
          label: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('save', style: TextStyle(fontSize: 16))),
        ),
      ),
    );
  }

  TextFormField buildmobileFormField(String phoneNumber) {
    return TextFormField(
      initialValue: phoneNumber,
      style: TextStyle(fontSize: 18),
      onChanged: (value) {
        if (value.isNotEmpty) {
        } else if (value.length != 10) {}
      },
      validator: (value) {
        if (value.isEmpty || value.length != 10)
          return "mobile no must be of 10 digit";

        return null;
      },
      decoration: InputDecoration(
        labelText: "Mobile Number",
        hintText: "Enter your Mobile Number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildNameFormField(String name) {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      style: TextStyle(fontSize: 18),
      onSaved: (newValue) => name = newValue,
      validator: (value) {
        if (value.isEmpty) {
          return 'enter your name';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAdressFormField(String address) {
    return TextFormField(
      controller: _addressController,
      keyboardType: TextInputType.name,
      // onSaved: (newValue) => name = newValue,
      style: TextStyle(fontSize: 18),
      maxLines: 5,
      minLines: 1,
      validator: (value) {
        if (value.isEmpty) {
          return "address can't be empty ";
        } else
          return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Rohini sec 13, xyz apartment, house no a/56",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

class SingupScreenArg {
  final Customer customer;
  SingupScreenArg(this.customer);
}
