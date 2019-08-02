import 'package:Unizer/connector.dart';

//Defaults
//TODO: Determine card height based upon content
const double kInfoCardMaxHeight = 110.0;
const double kInfoCardMinHeight = 25.0;
const double kInfoCardMaxSpace = 10.0;
const double kInfoCardMinSpace = 0.0;
const double kInfoCardMaxMargins = 12.0;
const double kInfoCardMinMargins = 2.0;
const int kDurationMilliseconds = 400;

class UniInfoBox extends StatefulWidget {
  UniInfoBox(
      {Key key, this.widgetContent, @required this.screenID, this.cardHeight})
      : super(key: key);

  final Widget widgetContent;
  final String screenID;
  final double cardHeight;

  @override
  _UniInfoBoxState createState() => _UniInfoBoxState();
}

class _UniInfoBoxState extends State<UniInfoBox> {
  bool _infoCardExpanded = true;
  double _infoCardHeight = kInfoCardMaxHeight;
  bool _visibleStatus = true;
  double _infoCardSpace = kInfoCardMaxSpace;
  double _infoCardMargins = kInfoCardMaxMargins;
  int _durationMilliseconds = kDurationMilliseconds;
  double _defaultCardHeight = kInfoCardMaxHeight;

  Future getBoxExpandedStatus() async {
    final bool _expanded =
        await LocalPrefs.getInfoBoxSpecs(screenID: widget.screenID);
    _infoCardExpanded = _expanded;
    _expanded
        ? _durationMilliseconds = kDurationMilliseconds
        : _durationMilliseconds = 0; //Don't animate when status is collapsed
    resizeCard();
  }

  void resizeCard() {
    _defaultCardHeight = widget.cardHeight ?? kInfoCardMaxHeight;
    _infoCardExpanded
        ? _infoCardHeight = _defaultCardHeight
        : _infoCardHeight = kInfoCardMinHeight;
    _infoCardExpanded
        ? _infoCardSpace = kInfoCardMaxSpace
        : _infoCardSpace = kInfoCardMinSpace;
    _infoCardExpanded
        ? _infoCardMargins = kInfoCardMaxMargins
        : _infoCardMargins = kInfoCardMinMargins;
    _infoCardExpanded ? _visibleStatus = true : _visibleStatus = false;
  }

  void toggleCard() {
    setState(() {
      _infoCardExpanded = !_infoCardExpanded;
    });
    _durationMilliseconds = kDurationMilliseconds;
    resizeCard();
    LocalPrefs.writeInfoBoxSpecs(
        screenID: widget.screenID, expanded: _infoCardExpanded);
  }

  @override
  void initState() {
    super.initState();
    getBoxExpandedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: AnimatedContainer(
        duration: Duration(milliseconds: _durationMilliseconds),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            kBoxScreenShadow,
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(kDefaultBorderRadius),
            bottomLeft: Radius.circular(kDefaultBorderRadius),
          ),
        ),
        curve: Curves.decelerate,
        constraints: BoxConstraints.expand(
          height: _infoCardHeight,
        ),
        padding: EdgeInsets.all(_infoCardMargins),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: Visibility(
                maintainState: true,
                visible: _visibleStatus,
                child: widget.widgetContent,
              ),
            ),
            Visibility(
              visible: _visibleStatus,
              child: SizedBox(
                height: _infoCardSpace,
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 2.0,
                  color: UniColors.dividerLine,
                  width: 100.0,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                  height: 2.0,
                  color: UniColors.dividerLine,
                  width: 60.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
