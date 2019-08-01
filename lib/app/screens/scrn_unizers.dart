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
                CardWidget(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'images/avatar-placeholder.png',
                            alignment: Alignment.topLeft,
                            width: 70.0,
                            height: 70.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Alex Jonathan',
                                style: kH1.copyWith(color: UniColors.blue),
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Boxicons.bxGroup,
                                    color: UniColors.subheader,
                                    size: kH5TextSize + 2,
                                  ),
                                  SizedBox(
                                    width: kTextFieldVerticalSpace,
                                  ),
                                  Text(
                                    'Unizer sinds',
                                    style: kH5,
                                  ),
                                  SizedBox(
                                    width: kTextFieldVerticalSpace,
                                  ),
                                  Text(
                                    '1 aug 2019',
                                    style: kH5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Boxicons.bxMessage,
                          color: UniColors.buttonGreen,
                          size: kMenuIconSize,
                        ),
                      ),
                    ],
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
