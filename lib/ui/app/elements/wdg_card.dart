import 'package:Unizer/packages.dart';

class UniCard extends StatelessWidget {
  UniCard({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: kCardMarginsTop,
        left: kCardMargins,
        right: kCardMargins,
      ),
      child: Container(
        padding: EdgeInsets.all(kCardMargins),
        constraints: BoxConstraints(maxWidth: kCardMaxWidth),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(51, 51, 51, 0.2),
              blurRadius: 2.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, move right 10
                2.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(kDefaultBorderRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}
