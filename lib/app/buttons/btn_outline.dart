import 'package:Unizer/connector.dart';

class UniOutlineButton extends StatelessWidget {
  const UniOutlineButton(
      {@required this.color,
      @required this.label,
      this.onPressed,
      this.topMargin});
  final Color color;
  final String label;
  final Function onPressed;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topMargin ?? kButtonTopMargin),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.all(Radius.circular(kDefaultBorderRadius)),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            label,
            style: kButtonText.copyWith(color: color),
          ),
        ),
      ),
    );

//    return Padding(
//      padding: EdgeInsets.only(top: topMargin ?? kButtonTopMargin),
//      child: Material(
//        elevation: 3.0,
//        color: color, //Colors.lightBlueAccent,
//        borderRadius: BorderRadius.circular(kButtonBorderRadius),
//        child: MaterialButton(
//          onPressed:
//              onPressed, //Navigator.pushNamed(context, LoginScreen.screenID);
//          minWidth: 100.0,
//          height: 42.0,
//          child: Text(
//            label,
//            style: kButtonText,
//          ),
//        ),
//      ),
//    );
  }
}
