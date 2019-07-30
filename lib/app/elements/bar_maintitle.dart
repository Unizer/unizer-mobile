import 'package:Unizer/packages.dart';

class MainTitleBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  MainTitleBar({this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2.0,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
            alignment: Alignment.center,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
      title: Text(
        title,
        style: kTopMenubarTitle,
      ),
      backgroundColor: UniColors.appBarBackground,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
