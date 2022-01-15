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

StreamController<int> penaltyController = StreamController<int>();

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

class _GameState extends State<Game> {
  StreamController<bool> diceController = StreamController<bool>();

  int lastDiceNumber = 1;
  int position = 1;
  List<int> strandedPeople = [];
  int currentPerson = 0;

  List<String> diceImages = [
    '',
    'imgs/dice_1.png',
    'imgs/dice_2.png',
    'imgs/dice_3.png',
    'imgs/dice_4.png',
    'imgs/dice_5.png',
    'imgs/dice_6.png',
  ];

  List<String> explanations = [
    '',
    '시작점입니다!',
    '처음 시작하는 사람은 2호선, 7호선 등 지하철 노선 중 하나를 정한 후, 왼쪽으로 돌아가며 차례대로 그 노선에 속한 역의 이름을 말하면 됩니당~ 만약 이전 사람이 외친 지하철역이 환승역인 경우엔 환승역이 속한 다른 노선으로 변경이 가능합니당 예를 들어 앞사람이 "선릉"을 외쳤다면, 그 다음 사람은 분당선의 역 이름을 말해도 됩니다!',
    '처음 시작하는 사람은 엄지손가락을 내밀며 초성 문제를 냅니다! 주어진 초성이 들어간 단어를 말하며 엄지손가락을 빠르게 잡아주세용~ 단어를 생각하지 못하거나, 다른 사람과 동일한 단어를 외치거나, 다른 사람보다 한 발 늦어 엄지손가락을 잡지 못하면 벌주에 당첨됩니당',
    '마셔마셔',
    '마셔마셔',
    '처음 시작하는 사람은 공격할 사람을 정해 지목을 하며 "호! 찐! 빵!" 중 한가지를 골라 외칩니당 만약 "호!"에 지목을 당했다면, 지목 당한 사람이 두 손을 들며 "빵!"을 크게 외칩니다. 그리고 다시 "호! 찐! 대! 중 하나를 골라 외치며 공격할 사람을 지목합니당 "찐!"으로 지목을 받았다면, 지목 당한 사람은 가만히 있고 지목을 당한 사람의 양 옆 사람이 두 손을 들며 "빵!"을 외칩니다. "대!"로 지목을 받았다면, 모든 사람이 "빵!"을 외치며 두 손을 올립니다. "빵"을 엉뚱하게 외치면 벌주',
    '걸린 사람은 한 턴 쉬기!',
    '이미지 게임',
    '두부',
    '사약 제조하기!',
    '좋아 게임',
    '손병호 게임',
    '나 빼고 다 마시기!',
    '',
    '랜덤 게임!',
    '사약 마시기!!',
    '의리 게임',
    '딸기가 좋아',
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
                text: penalties[16],
                explanation: explanations[16]),
            BoardDetail(
                position: position,
                boardNumber: 17,
                color: Colors.orange,
                text: penalties[17],
                explanation: explanations[17]),
            BoardDetail(
                position: position,
                boardNumber: 18,
                color: Colors.yellow,
                text: penalties[18],
                explanation: explanations[18]),
            BoardDetail(
                position: position,
                boardNumber: 1,
                color: Colors.green,
                text: penalties[1],
                explanation: explanations[1]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 15,
                color: Colors.blue,
                text: penalties[15],
                explanation: explanations[15]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 2,
                color: Colors.purple,
                text: penalties[2],
                explanation: explanations[2]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 14,
                color: Colors.red,
                text: penalties[14],
                explanation: explanations[14]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 3,
                color: Colors.orange,
                text: penalties[3],
                explanation: explanations[3]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 13,
                color: Colors.yellow,
                text: penalties[13],
                explanation: explanations[13]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 4,
                color: Colors.green,
                text: penalties[4],
                explanation: explanations[4]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 12,
                color: Colors.blue,
                text: penalties[12],
                explanation: explanations[12]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 5,
                color: Colors.purple,
                text: penalties[5],
                explanation: explanations[5]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 11,
                color: Colors.red,
                text: penalties[11],
                explanation: explanations[11]),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
            ),
            BoardDetail(
                position: position,
                boardNumber: 6,
                color: Colors.orange,
                text: penalties[6],
                explanation: explanations[6]),
          ],
        ),
        Column(
          children: [
            BoardDetail(
                position: position,
                boardNumber: 10,
                color: Colors.yellow,
                text: penalties[10],
                explanation: explanations[10]),
            BoardDetail(
                position: position,
                boardNumber: 9,
                color: Colors.green,
                text: penalties[9],
                explanation: explanations[9]),
            BoardDetail(
                position: position,
                boardNumber: 8,
                color: Colors.blue,
                text: penalties[8],
                explanation: explanations[8]),
            BoardDetail(
                position: position,
                boardNumber: 7,
                color: Colors.purple,
                text: penalties[7],
                explanation: explanations[7]),
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
    penaltyController.add(0);
    for (int i = 0; i < widget.players.length; i++) {
      strandedPeople.add(0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<int>(
          stream: penaltyController.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasData) {
              explanations[snapshot.data!] = '';
              print(penalties);
              return Stack(
                children: [gameBoard(), Center(child: diceArea())],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
