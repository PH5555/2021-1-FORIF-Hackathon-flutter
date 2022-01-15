import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final color;
  final text;
  const PopUp({Key? key, required this.color, required this.text})
      : super(key: key);

  dialogContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          width: 300,
          height: 400,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 24),
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
