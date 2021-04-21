import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class AboutScreen extends StatelessWidget {
  static const String screenID = 'about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleBar(
        title: tr('lbl_about'),
      ),
      body: Container(
        decoration: kBoxScreenDecoration,
        constraints: BoxConstraints.expand(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            CardWidget(
              child: Column(
                children: <Widget>[
                  Text(
                    tr('lbl_appversion', args: [kAppVersion]),
                    style: kH3,
                  ),
                  SizedBox(
                    height: kLinkTextVerticalSpace,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      tr('lbl_history'),
                      style: kH3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    tr('txt_history'),
                    style: kBodyText,
                  ),
                  SizedBox(
                    height: kLinkTextVerticalSpace,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      tr('lbl_mission'),
                      style: kH3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    tr('txt_mission'),
                    style: kBodyText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
