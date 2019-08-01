import 'package:Unizer/packages.dart';

class UnizerScreen extends StatefulWidget {
  static const String screenID = 'unizers';

  @override
  _UnizerScreenState createState() => _UnizerScreenState();
}

class _UnizerScreenState extends State<UnizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleBar(
        title: AppLocalizations.of(context).tr('lbl_unizers'),
      ),
      drawer: LeftMenu(),
      body: Container(
        decoration: kBoxScreenDecoration,
        constraints: BoxConstraints.expand(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: kCardMargins,
                    right: kCardMargins,
                  ),
                  child: UniInfoBox(
                    cardHeight: 140.0,
                    widgetContent: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                          child: Text(
                            AppLocalizations.of(context)
                                .tr('msg_unizer-home-info'),
                            style: kH2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        //TODO: Show proper button
                        UniOutlineButton(
                          color: UniColors.buttonGreen,
                          topMargin: 10.0,
                          label: AppLocalizations.of(context)
                              .tr('btn_invite-more-friends'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    screenID: UnizerScreen.screenID,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}
