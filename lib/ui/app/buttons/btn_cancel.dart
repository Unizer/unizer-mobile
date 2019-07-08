import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Cancel',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
