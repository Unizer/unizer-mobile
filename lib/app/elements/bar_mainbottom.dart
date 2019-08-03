import 'package:Unizer/connector.dart';

class MainBottomBar extends StatefulWidget {
  const MainBottomBar({Key key, this.screenId}) : super(key: key);
  final String screenId;

  @override
  _MainBottomBarState createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  int _selectedBottomBarIndex = 0;
  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedBottomBarIndex = index;
    });
    if (_selectedBottomBarIndex == 0) {
      Navigator.pushNamed(context, HomeScreen.screenID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: UniColors.iconMain,
      selectedItemColor: UniColors.black,
      selectedFontSize: 13.0,
      unselectedFontSize: 10.0,
      selectedIconTheme: IconThemeData(
        size: 26.0,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20.0,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      backgroundColor: UniColors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          activeIcon: Icon(LineIcons.home),
          icon: Icon(LineIcons.home),
          title: Text(AppLocalizations.of(context).tr('lbl_home')),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(LineIcons.calendar),
          icon: Icon(LineIcons.calendar_o),
          title: Text(AppLocalizations.of(context).tr('lbl_calendar')),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(LineIcons.flag),
          icon: Icon(LineIcons.flag_o),
          title: Text(AppLocalizations.of(context).tr('lbl_events')),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(LineIcons.bullhorn),
          icon: Icon(LineIcons.bullhorn),
          title: Text(AppLocalizations.of(context).tr('lbl_shouts')),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(LineIcons.comments),
          icon: Icon(LineIcons.comments),
          title: Text(AppLocalizations.of(context).tr('lbl_chat')),
        ),
      ],
      currentIndex: _selectedBottomBarIndex,
      onTap: _onBottomItemTapped,
    );
  }
}
