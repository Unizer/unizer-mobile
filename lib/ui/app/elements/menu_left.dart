import 'package:Unizer/packages.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({
    Key key,
    @required String userDisplayName,
  })  : _userDisplayName = userDisplayName,
        super(key: key);

  final String _userDisplayName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8.0,
      child: Container(
        decoration: kMenuScreenDecoration,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 5,
          ),
          child: Column(
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
              ListTile(
                title: Text('Unizers'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
