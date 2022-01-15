import 'package:flutter/material.dart';
import 'package:forif_hackthon_flutter/pop_up_dialog.dart';

class BoardDetail extends StatelessWidget {
  final position;
  final boardNumber;
  final color;
  final text;
  const BoardDetail(
      {Key? key,
      required this.position,
      required this.boardNumber,
      required this.color,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PopUp(color: color, text: text);
                });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 7,
            height: MediaQuery.of(context).size.height / 4,
            color: color,
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width / 14 - 15,
          top: MediaQuery.of(context).size.height / 8 - 15,
          child: Visibility(
              visible: position == boardNumber,
              child: ClipRRect(
                child: Container(
                  color: Colors.white,
                  width: 30,
                  height: 30,
                  child: Center(child: Text('말')),
                ),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              )),
        )
      ],
    );
  }
}
