import 'package:Unizer/connector.dart';

class OrganisationListScreen extends StatefulWidget {
  static const String screenID = 'organisations_list';

  @override
  _OrganisationListScreenState createState() => _OrganisationListScreenState();
}

class _OrganisationListScreenState extends State<OrganisationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleBar(
        title: AppLocalizations.of(context).tr('lbl_organisations'),
      ),
      drawer: LeftMenu(),
      body: Container(
        decoration: kBoxScreenDecoration,
        constraints: BoxConstraints.expand(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.center,
              runSpacing: kCardVerticalSpace,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: kCardMargins,
                    right: kCardMargins,
                  ),
                  child: UniInfoBox(
                    cardHeight: 170.0,
                    widgetContent: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                          child: Text(
                            AppLocalizations.of(context)
                                .tr('msg_organisations-list-info'),
                            style: kH2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: kTextFieldVerticalSpace),
                          child: UniOutlineButton(
                            icon: BoxIcons.bx_building_house,
                            color: UniColors.buttonGreen,
                            topMargin: 10.0,
                            label: AppLocalizations.of(context)
                                .tr('btn_register-organisation'),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterOrgScreen.screenID);
                            },
                          ),
                        ),
                      ],
                    ),
                    screenID: OrganisationListScreen.screenID,
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
