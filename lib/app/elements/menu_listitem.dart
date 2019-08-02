import 'package:Unizer/connector.dart';

class MenuListItem extends StatelessWidget {
  MenuListItem({Key key, this.label, this.icon, this.onPress})
      : super(key: key);

  final String label;
  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        right: 20.0,
      ),
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  label,
                  style: kMenuText,
                ),
                Icon(
                  icon,
                  size: kMenuIconSize,
                  color: UniColors.iconMain,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              child: Container(
                height: 2.0,
                color: UniColors.dividerLine,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
