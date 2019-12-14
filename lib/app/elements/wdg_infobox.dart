import 'package:Unizer/connector.dart';

class UniInfoBox extends StatefulWidget {
  final Widget child;
  final String screenID;
  UniInfoBox({this.child, this.screenID});

  @override
  _UniInfoBoxState createState() => _UniInfoBoxState();
}

class _UniInfoBoxState extends State<UniInfoBox>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;

  bool _expanded = true;

  void toggleExpandedState() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
    });
    LocalPrefs.writeInfoBoxSpecs(
        screenID: widget.screenID, expanded: _expanded);
  }

  @override
  void initState() {
    _runExpandCheck();
    prepareAnimations();
    super.initState();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() async {
    _expanded = await LocalPrefs.getInfoBoxSpecs(screenID: widget.screenID);
    setState(() {
      if (_expanded) {
        expandController.forward();
      } else {
        expandController.reverse();
      }
    });
  }

  @override
  void didUpdateWidget(UniInfoBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_expanded == true || _expanded == null) {
      return Padding(
        padding: EdgeInsets.only(left: kCardMargins, right: kCardMargins),
        child: SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  kBoxScreenShadow,
                ],
                color: UniColors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(kDefaultBorderRadius),
                  bottomLeft: Radius.circular(kDefaultBorderRadius),
                ),
              ),
              padding: EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
              child: Column(
                children: <Widget>[
                  widget.child,
                  MaterialButton(
                    height: 15.0,
                    minWidth: 300.0,
                    onPressed: toggleExpandedState,
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 2.0,
                          thickness: 2.0,
                          color: UniColors.dividerLine,
                          indent: 60.0,
                          endIndent: 60.0,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Divider(
                          height: 2.0,
                          thickness: 2.0,
                          color: UniColors.dividerLine,
                          indent: 100.0,
                          endIndent: 100.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(left: 18.0, right: 18.0),
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              kBoxScreenShadow,
            ],
            color: UniColors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(kDefaultBorderRadius),
              bottomLeft: Radius.circular(kDefaultBorderRadius),
            ),
          ),
          height: 25.0,
          child: MaterialButton(
            height: 15.0,
            minWidth: 300.0,
            onPressed: toggleExpandedState,
            child: Column(
              children: <Widget>[
                Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: UniColors.dividerLine,
                  indent: 60.0,
                  endIndent: 60.0,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Divider(
                  height: 2.0,
                  thickness: 2.0,
                  color: UniColors.dividerLine,
                  indent: 100.0,
                  endIndent: 100.0,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
