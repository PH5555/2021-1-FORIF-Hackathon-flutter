import 'package:flutter/material.dart';
import 'package:forif_hackthon_flutter/pages/game.dart';

class PopUp extends StatefulWidget {
  final color;
  final position;
  dynamic explanantion;
  dynamic text;
  PopUp(
      {Key? key,
      required this.color,
      required this.text,
      required this.explanantion,
      required this.position})
      : super(key: key);

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  TextEditingController gameNameController = TextEditingController();
  bool gameNameReadOnly = true;
  bool isModifying = false;

  dialogContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(10)),
        width: 300,
        height: 400,
        child: Stack(children: [
          Positioned(
            top: 10,
            left: 50,
            child: Container(
              width: 200,
              child: TextField(
                readOnly: gameNameReadOnly,
                controller: gameNameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.text,
                  hintStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: gameNameReadOnly == true
                        ? Colors.black
                        : Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 70,
              left: 25,
              child: Center(
                  child: Container(
                width: 250,
                height: 195,
                child: SingleChildScrollView(
                  child: Text(widget.explanantion,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ))),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
                onPressed: () {
                  if (isModifying) {
                    widget.text = gameNameController.text;
                    penalties[widget.position] = widget.text;
                    penaltyController.add(widget.position);
                    Navigator.pop(context);
                    return;
                  }

                  setState(() {
                    gameNameReadOnly = false;
                    widget.text = '입력해주세요 Click!';
                    widget.explanantion = '';
                    isModifying = true;
                  });
                },
                icon: isModifying == false
                    ? Icon(
                        Icons.border_color_outlined,
                        color: Colors.black,
                        size: 40,
                      )
                    : Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 40,
                      )),
          )
        ]),
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
