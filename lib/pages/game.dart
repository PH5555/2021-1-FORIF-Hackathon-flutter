import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forif_hackthon_flutter/board_detail.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  StreamController<bool> diceController = StreamController<bool>();

  int lastDiceNumber = 1;
  int position = 1;

  List<String> diceImages = [
    '',
    'imgs/dice_1.png',
    'imgs/dice_2.png',
    'imgs/dice_3.png',
    'imgs/dice_4.png',
    'imgs/dice_5.png',
    'imgs/dice_6.png',
  ];

  Widget gameBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 16,
                color: Colors.red,
                text: ''),
            BoardDetail(
                position: position,
                boardNumber: 17,
                color: Colors.orange,
                text: ''),
            BoardDetail(
                position: position,
                boardNumber: 18,
                color: Colors.yellow,
                text: ''),
            BoardDetail(
                position: position,
                boardNumber: 1,
                color: Colors.green,
                text: '시작'),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 15,
                color: Colors.blue,
                text: ''),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 2,
                color: Colors.purple,
                text: ''),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 14,
                color: Colors.red,
                text: ''),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 3,
                color: Colors.orange,
                text: ''),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 13,
                color: Colors.yellow,
                text: ''),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 4,
                color: Colors.green,
                text: ''),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 12,
                color: Colors.blue,
                text: ''),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 5,
                color: Colors.purple,
                text: ''),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 11,
                color: Colors.red,
                text: ''),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 6,
                color: Colors.orange,
                text: ''),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 10,
                color: Colors.yellow,
                text: ''),
            BoardDetail(
                position: position,
                boardNumber: 9,
                color: Colors.green,
                text: ''),
            BoardDetail(
                position: position,
                boardNumber: 8,
                color: Colors.blue,
                text: ''),
            BoardDetail(
                position: position,
                boardNumber: 7,
                color: Colors.purple,
                text: ''),
          ],
        ),
      ],
    );
  }

  Widget diceArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder(
            stream: diceController.stream,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return Image.asset(
                    'imgs/dice_roll.gif',
                    height: 70,
                  );
                } else {
                  return Image.asset(
                    diceImages[lastDiceNumber],
                    height: 70,
                  );
                }
              } else {
                return Image.asset(
                  'imgs/dice_roll.gif',
                  height: 70,
                );
              }
            }),
        SizedBox(
          height: 6,
        ),
        InkWell(
          onTap: () {
            diceController.add(true);
            Future.delayed(Duration(seconds: 1), () {
              lastDiceNumber = Random().nextInt(6) + 1;
              position += lastDiceNumber;
              if (position > 18) {
                position -= 18;
              }
              diceController.add(false);
              setState(() {});
            });
          },
          child: Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Center(
                  child: Text(
                '주사위 굴리기',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))),
        )
      ],
    );
  }

  @override
  void initState() {
    diceController.add(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [gameBoard(), Center(child: diceArea())],
      ),
    );
  }
}
