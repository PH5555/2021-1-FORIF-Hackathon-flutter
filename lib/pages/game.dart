import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forif_hackthon_flutter/board_detail.dart';

class Game extends StatefulWidget {
  final List<String> players;
  const Game({Key? key, required this.players}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  StreamController<bool> diceController = StreamController<bool>();

  int lastDiceNumber = 1;
  int position = 1;
  List<int> strandedPeople = [];
  int currentPerson = 0;

  List<String> penalties = [
    '',
    'start',
    '지하철',
    '훈민정음',
    '다 같이 한잔',
    '소주 두 잔',
    '호빵 찐빵 대빵',
    '한 턴 쉬기',
    '이미지 게임',
    '두부',
    '사약 제조',
    '좋아 게임',
    '손병호',
    '나 빼고 다 마셔',
    '공산당',
    '랜덤 게임',
    '사약 마시기',
    '의리 게임',
    '딸기가 좋아',
  ];

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
                text: penalties[16]),
            BoardDetail(
                position: position,
                boardNumber: 17,
                color: Colors.orange,
                text: penalties[17]),
            BoardDetail(
                position: position,
                boardNumber: 18,
                color: Colors.yellow,
                text: penalties[18]),
            BoardDetail(
                position: position,
                boardNumber: 1,
                color: Colors.green,
                text: penalties[1]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 15,
                color: Colors.blue,
                text: penalties[15]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 2,
                color: Colors.purple,
                text: penalties[2]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 14,
                color: Colors.red,
                text: penalties[14]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 3,
                color: Colors.orange,
                text: penalties[3]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 13,
                color: Colors.yellow,
                text: penalties[13]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 4,
                color: Colors.green,
                text: penalties[4]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 12,
                color: Colors.blue,
                text: penalties[12]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 5,
                color: Colors.purple,
                text: penalties[5]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 11,
                color: Colors.red,
                text: penalties[11]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 6,
                color: Colors.orange,
                text: penalties[6]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 10,
                color: Colors.yellow,
                text: penalties[10]),
            BoardDetail(
                position: position,
                boardNumber: 9,
                color: Colors.green,
                text: penalties[9]),
            BoardDetail(
                position: position,
                boardNumber: 8,
                color: Colors.blue,
                text: penalties[8]),
            BoardDetail(
                position: position,
                boardNumber: 7,
                color: Colors.purple,
                text: penalties[7]),
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
              // 한 턴 쉬기 걸렸을 때 처리
              if (position == 7) {
                strandedPeople[currentPerson] += 1;
              }

              // 시작점을 돌 경우 처리
              if (position > 18) {
                position -= 18;
              }

              // 다음 사람 넘어가기
              currentPerson += 1;

              if (currentPerson >= widget.players.length) {
                currentPerson = 0;
              }

              // 다음 사람이 쉬는 사람일 경우 처리
              if (strandedPeople[currentPerson] != 0) {
                strandedPeople[currentPerson] -= 1;
                currentPerson += 1;

                if (currentPerson >= widget.players.length) {
                  currentPerson = 0;
                }
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
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          widget.players[currentPerson] + '님 주사위를 굴려주세요!',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  @override
  void initState() {
    diceController.add(false);
    for (int i = 0; i < widget.players.length; i++) {
      strandedPeople.add(0);
    }
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
