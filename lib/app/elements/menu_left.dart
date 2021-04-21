import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class LeftMenu extends StatefulWidget {
  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenu> {
  String userDisplayName = '';

  getUserDisplayname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userDisplayName = prefs.get('userDisplayname').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDisplayname();
  }

  @override
  Widget build(BuildContext context) {
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
                      icon: Icon(BoxIcons.bx_x),
                      color: UniColors.buttonClose,
                      iconSize: kMenuIconSize + 8,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          'images/Karel.png',
                          alignment: Alignment.topLeft,
                          width: 80.0,
                          height: 80.0,
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              userDisplayName,
                              softWrap: true,
                              style: kH1,
                            ),
                            SizedBox(
                              height: kLinkTextVerticalSpace,
                            ),
                            Text(
                              tr('lbl_visit-edit-profile'),
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
                    label: tr('lbl_unizers'),
                    icon: BoxIcons.bx_user,
                    onPress: () {
                      Navigator.pushNamed(context, UnizerScreen.screenID);
                    },
                  ),
                  MenuListItem(
                    key: UniqueKey(),
                    label: tr('lbl_teams'),
                    icon: BoxIcons.bx_group,
                  ),
                  MenuListItem(
                    key: UniqueKey(),
                    label: tr('lbl_organisations'),
                    icon: BoxIcons.bx_building_house,
                    onPress: () {
                      Navigator.pushNamed(
                          context, OrganisationListScreen.screenID);
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  MenuListItem(
                    label: tr('lbl_logout'),
                    icon: BoxIcons.bx_log_out,
                    onPress: () {
                      Navigator.popAndPushNamed(context, LoginScreen.screenID);
                    },
                  ),
                  MenuListItem(
                    label: tr('lbl_about'),
                    icon: BoxIcons.bx_info_circle,
                    onPress: () {
                      Navigator.pushNamed(context, AboutScreen.screenID);
                      Scaffold.of(context).openEndDrawer(); //close Drawer
                    },
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
