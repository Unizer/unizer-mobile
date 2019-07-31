import 'package:Unizer/packages.dart';

class LeftMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<FirebaseUser>(context);
    String _userDisplayName = '';
    if (_user != null) {
      _userDisplayName = _user.displayName;
    }

    return Drawer(
      elevation: 8.0,
      child: Container(
        decoration: kMenuScreenDecoration,
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 5,
            bottom: 40.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Top part
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IconButton(
                      alignment: Alignment.topRight,
                      icon: Icon(Boxicons.bxX),
                      color: UniColors.buttonClose,
                      iconSize: kMenuIconSize,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'images/avatar-placeholder.png',
                        alignment: Alignment.topLeft,
                        width: 80.0,
                        height: 80.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              _userDisplayName,
                              softWrap: true,
                              style: kH1,
                            ),
                            SizedBox(
                              height: kLinkTextVerticalSpace,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .tr('lbl_visit-edit-profile'),
                              softWrap: true,
                              style: kLinkText,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MenuListItem(
                    key: UniqueKey(),
                    label: AppLocalizations.of(context).tr('lbl_unizers'),
                    icon: Boxicons.bxUser,
                    onPress: () {
                      Navigator.pushNamed(context, UnizerScreen.screenID);
                    },
                  ),
                  MenuListItem(
                    label: AppLocalizations.of(context).tr('lbl_teams'),
                    icon: Boxicons.bxGroup,
                  ),
                  MenuListItem(
                    label: AppLocalizations.of(context).tr('lbl_organisations'),
                    icon: Boxicons.bxBuilding,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  MenuListItem(
                    label: AppLocalizations.of(context).tr('lbl_logout'),
                    icon: Boxicons.bxLogOut,
                    onPress: () {
                      Navigator.popAndPushNamed(context, LoginScreen.screenID);
                    },
                  ),
                  MenuListItem(
                    label: AppLocalizations.of(context).tr('lbl_about'),
                    icon: Boxicons.bxInfoCircle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
