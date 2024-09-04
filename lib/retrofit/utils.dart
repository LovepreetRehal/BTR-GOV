import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static List<String> monthsAdded = [];
  static const String baseURL = 'api.learnwithchoudhary.com';
  static const String lists = '/api/farmers/head/lists';
  static const String store = '/api/farmers/details/store';
  static const String stats = '/api/admin/dashboard/stats';
  static const String dashboard = '/api/admin/dashboard';
  static const String editDetail = '/api/farmers/details/show/';
  static const String deleteDetail = '/api/farmers/details/delete/';

  // static const String logo = 'assets/images/logo.svg';
  // static const String downArrow = 'assets/images/arrow-down-fill.svg';

  //shared preferences
  static const String tokenKey = 'accessToken';
  static const String signInUserIdKey = 'signInUserId';
  static const String fullName = 'fullName';
  static const String email = 'email';
  static const String userType = 'userType';
  static const String stripeId = 'stripe_id';
  static String? deviceType;
  static String? anotherToken;

  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static navigateToScreen(
      BuildContext context, String routeName, Widget screen, bool withNavbar,
      {String? email}) {
    print('route name: $routeName');
  }

  // static Widget loadingIndicator() {
  //   return const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.logoColor));
  // }

  static toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static Widget setSvgImg(
      String path, double width, double height, Color color) {
    return SvgPicture.asset(
      path,
      /*width: width,
      height: height,*/
      //color: color,
    );
  }
}
