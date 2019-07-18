/* --Flutter defaults --*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefs {
  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('userEmail').toString() ?? '';
  }

  /*-- Device Specs --*/
  static Future writeDeviceSpecs(BuildContext context) async {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    //print('Screenwidth: ' + ScreenUtil.screenWidth.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('deviceScreenHeight', ScreenUtil.screenHeight);
    prefs.setDouble('deviceScreenWidth', ScreenUtil.screenWidth);
    prefs.setDouble('deviceScreenHeightDp', ScreenUtil.screenHeightDp);
    prefs.setDouble('deviceScreenWidthDp', ScreenUtil.screenWidthDp);
    prefs.setDouble('devicePixelRatio', ScreenUtil.pixelRatio);
    prefs.setDouble('deviceTextScaleFactor', ScreenUtil.textScaleFactory);
    prefs.setDouble('deviceBottomBarHeight', ScreenUtil.bottomBarHeight);
    prefs.setDouble('deviceStatusBarHeight', ScreenUtil.statusBarHeight);
  }

  static Future writeInfoBoxSpecs({String screenID, bool expanded}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('infobox_$screenID+_expanded', expanded);
  }

  static Future<bool> getInfoBoxSpecs({String screenID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('infobox_$screenID+_expanded') ?? true;
  }

  static Future writeUserAccount(
      {String firstName,
      String lastName,
      String email,
      String displayName}) async {
    // obtain shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setString('userFirstname', firstName);
    prefs.setString('userLastname', lastName);
    prefs.setString('userEmail', email);
    prefs.setString('userDisplayname', displayName);
  }

  static Future<String> getUserAccountPrefs({Future<String> tag}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('$tag') ?? '';
  }
}
