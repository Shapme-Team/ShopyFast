import 'package:ShopyFast/view/screens/SearchScreen/searchScreen.dart';
import 'package:ShopyFast/view/screens/categoryDetailScreen/categoryDetailScreen.dart';
import 'package:flutter/widgets.dart';

import '../../view/helper/wrapper.dart';
import '../../view/screens/bottomNavScreens/categories/categories.dart';
import '../../view/screens/bottomNavScreens/orders/orders.dart';
import '../../view/screens/bottomNavScreens/profile/profile_screen.dart';
import '../../view/screens/cart/cart_screen.dart';
import '../../view/screens/details/details_screen.dart';
import '../../view/screens/home/home.dart';
// import 'package:shop_app/screens/login_success/login_success_screen.dart';
// import 'package:shop_app/screens/otp/otp_screen.dart';
// import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
// import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
// import 'package:shop_app/screens/splash/splash_screen.dart';
// import 'screens/sign_up/sign_up_screen.dart';
//import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => SplashScreen(),
  // SignInScreen.routeName: (context) => SignInScreen(),
  // ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  // SignUpScreen.routeName: (context) => SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  Wrapper.routeName: (context) => Wrapper(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CategoriesScreen.routeName: (context) => CategoriesScreen(),
  OrdersScreen.routeName: (context) => OrdersScreen(),
  CategoryDetailScreen.routeName: (context) => CategoryDetailScreen(),
};
