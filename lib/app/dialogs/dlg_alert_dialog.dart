import 'package:flutter/material.dart';

class UniAlertDialog extends StatelessWidget {
  const UniAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text('Alert'),
      content: Text('Weet je het zeker?'),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, child: Text('Yes',),),
        FlatButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, child: Text('No',),),
      ],
    );
  }
}

