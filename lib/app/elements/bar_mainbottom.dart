import 'package:Unizer/packages.dart';

class UniMainBottomBar extends StatefulWidget {
  const UniMainBottomBar({
    Key key,
  }) : super(key: key);

  @override
  _UniMainBottomBarState createState() => _UniMainBottomBarState();
}

class _UniMainBottomBarState extends State<UniMainBottomBar> {
  int _selectedBottomBarIndex = 0;
  void _onBottomItemTapped(int index) {
    setState(() {
      _selectedBottomBarIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: UniColors.h2,
      selectedItemColor: UniColors.black,
      selectedFontSize: 10.0,
      unselectedFontSize: 10.0,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      backgroundColor: UniColors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Boxicons.bxHome),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Boxicons.bxCalendar),
          title: Text('Agenda'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Boxicons.bxFlag),
          title: Text('Events'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Boxicons.bxExclamation),
          title: Text('Shouts'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Boxicons.bxMessage),
          title: Text('Chat'),
        ),
      ],
      currentIndex: _selectedBottomBarIndex,
      onTap: _onBottomItemTapped,
    );
  }
}
