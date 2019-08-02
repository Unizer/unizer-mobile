import 'package:Unizer/connector.dart';

class AboutScreen extends StatelessWidget {
  static const String screenID = 'about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleBar(
        title: AppLocalizations.of(context).tr('lbl_about'),
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
                    AppLocalizations.of(context)
                        .tr('lbl_appversion', args: [kAppVersion]),
                    style: kH3,
                  ),
                  SizedBox(
                    height: kLinkTextVerticalSpace,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppLocalizations.of(context).tr('lbl_history'),
                      style: kH3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).tr('txt_history'),
                    style: kBodyText,
                  ),
                  SizedBox(
                    height: kLinkTextVerticalSpace,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      AppLocalizations.of(context).tr('lbl_mission'),
                      style: kH3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context).tr('txt_mission'),
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
