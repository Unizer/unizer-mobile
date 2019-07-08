/* --Flutter defaults --*/
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalPrefs {
  static Future writeUserEmail({@required String email}) async {
    // obtain shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // set value
    prefs.setString('userEmail', email);
  }

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
}
