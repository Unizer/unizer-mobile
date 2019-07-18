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
            kBoxScreenShadow,
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
