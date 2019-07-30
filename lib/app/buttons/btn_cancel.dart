import 'package:Unizer/packages.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Text(
          AppLocalizations.of(context).tr('btn_cancel'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
