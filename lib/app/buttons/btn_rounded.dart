import 'package:Unizer/connector.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.color,
      @required this.label,
      this.onPressed,
      this.topMargin,
      this.elevation,
      this.height,
      this.icon});
  final Color color;
  final String label;
  final Function onPressed;
  final double topMargin;
  final double elevation;
  final double height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    bool showIcon = false;
    if (icon != null) showIcon = true;

    return Padding(
      padding: EdgeInsets.only(top: topMargin ?? kButtonTopMargin),
      child: Material(
        elevation: elevation ?? 3.0,
        color: color, //Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(kButtonBorderRadius),
        child: MaterialButton(
          onPressed:
              onPressed, //Navigator.pushNamed(context, LoginScreen.screenID);
          minWidth: 100.0,
          height: height ?? kButtonHeight,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Text(
                label,
                style: kButtonText,
              ),
              Visibility(
                visible: showIcon,
                child: Icon(
                  icon,
                  size: kMenuIconSize + 2,
                  color: UniColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
