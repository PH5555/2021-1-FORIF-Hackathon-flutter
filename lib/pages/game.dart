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

StreamController<int> penaltyController = StreamController<int>.broadcast();

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
  StreamController<bool> diceController = StreamController<bool>.broadcast();

  int lastDiceNumber = 1;
  int position = 1;
  List<int> strandedPeople = [];
  int currentPerson = 0;

  List<String> explanations = [
    '',
    '시작점입니다!',
    '처음 시작하는 사람은 2호선, 7호선 등 지하철 노선 중 하나를 정한 후, 왼쪽으로 돌아가며 차례대로 그 노선에 속한 역의 이름을 말하면 됩니당~ 만약 이전 사람이 외친 지하철역이 환승역인 경우엔 환승역이 속한 다른 노선으로 변경이 가능합니당 예를 들어 앞사람이 "선릉"을 외쳤다면, 그 다음 사람은 분당선의 역 이름을 말해도 됩니다!',
    '처음 시작하는 사람은 엄지손가락을 내밀며 초성 문제를 냅니다! 주어진 초성이 들어간 단어를 말하며 엄지손가락을 빠르게 잡아주세용~ 단어를 생각하지 못하거나, 다른 사람과 동일한 단어를 외치거나, 다른 사람보다 한 발 늦어 엄지손가락을 잡지 못하면 벌주에 당첨됩니당',
    '다 같이 마셔 마셔! 먹고 뒤져! 청!바!지! 청춘은! 바로! 지금!!!!!!!!',
    '설마 ㅋ 꺾어 마시겠어?? 동구 밭 과수원 샷 아카시아 꽃이 활짝 투 샷 쓰리 샷~~~~~~~!!! >-<',
    '처음 시작하는 사람은 공격할 사람을 정해 지목을 하며 "호! 찐! 빵!" 중 한가지를 골라 외칩니당 만약 "호!"에 지목을 당했다면, 지목 당한 사람이 두 손을 들며 "빵!"을 크게 외칩니다. 그리고 다시 "호! 찐! 대! 중 하나를 골라 외치며 공격할 사람을 지목합니당 "찐!"으로 지목을 받았다면, 지목 당한 사람은 가만히 있고 지목을 당한 사람의 양 옆 사람이 두 손을 들며 "빵!"을 외칩니다. "대!"로 지목을 받았다면, 모든 사람이 "빵!"을 외치며 두 손을 올립니다. "빵"을 엉뚱하게 외치면 벌주',
    '걸린 사람은 한 턴 쉬기!',
    '이미지 게임은 먼저 팀을 나눠야 합니다. 그리고 처음 시작하는 사람은 상대팀의 누군가에게 연상되는 이미지와 함께 수를 같이 외쳐야 합니다. 예를 들자면, "탈모 셋!" 이렇게 말이죠. 그러면 이제 상대팀 중 누군가가 세 번의 기회 안에 반드시 공격을 받아야 합니다. 만약 받은 사람이 여러 명 이거나, 세 번의 기회를 모두 놓쳤다면 해당 팀원들은 모두 한 잔 씩 마셔야 합니당.. 공격 방어에 성공하면 이제 반대로 상대팀을 공격하면 됩니다.',
    '두부는 총 일 모, 이 모, 삼 모, 사 모, 오 모가 있습니다. 처음 시작하는 사람이 두부 세 모 입니다. 그리고 그 사람을 기준으로 바로 왼쪽 사람은 두 모, 왼왼쪽 사람은 한 모, 오른쪽 사람은 네 모, 오른오른쪽 사람은 다섯 모 입니다. 처음 시작하는 사람이 "두부 네 모" 이렇게 외치면 바로 오른쪽 사람이 공격을 받아쳐야 합니다. 그리고 공격을 받아치는 사람이 세 모가 됩니다..!! 다시 그 사람을 기준으로 한 모, 두 모, 네 모, 다섯 모가 정해지는 것이죠.. 꽤나 어려워용ㅜㅜ',
    '사약 제조하기... 사랑하는 만큼 하트핱흐 ♥♡♥♡♥♡',
    '아 술도 마셨는데~ 좋아 게임할까!! 처음 시작하는 사람은 누군가를 속으로 정하고, 그 사람을 부르며 "OO 좋아!" 라고 외칩니당~ 그러면 그 OO이는 두 가지로 받아칠 수 있는데요? 첫 번째, "나도 좋아 >0<", 두 번째, "카아앜; 퉤;;" 그 이의 사랑을 수락한다면, 이제 그 사람이 다른 사람을 향해 "ㅁㅁ 좋아!!"를 하며 계속 돌아가며 게임을 진행합니다. 그런데 만약 침을 맞으며 비굴하게 거절을 당했다면.. 다시 누군가에게 좋다고 고백을 해야 합니다.. 그런데 거절을 총 세 번 당하면 이제 그 사람은 술을 마셔야 합니다.. 모두에게 사랑도 못 받고, 벌주까지 마셔야 하죠 ㅠ',
    '차례를 돌아가며 특정 조건의 사람은 손가락을 하나씩 접게 하고, 만약 손이 다 접히면 그 사람이 걸리게 됩니다.. 손가락을 몇 개 필 지는 인원수에 적당하게 정합니다! 그런데 반대로, 손을 등 뒤에 숨겨서 몇 개 남았는 지 안보이게끔 하는 손병호 게임도 있습니다. 이 경우에는 손가락이 다 접힌 사람이 생겼을 경우, 해당 턴의 사람이 술을 마시게 됩니다.. 즉, 내가 누군가를 죽이지 않게끔 해야된다는 것이죠..',
    '나 빼고 다 마셔!!!! 하~ 속상해라 ㅋ',
    '작정하고 한 사람 죽이는 으마무시한 게임!! 주최자부터 "동무" 하고 누군가를 지목합니당. 그러면 그 사람이 "동무"하며 다시 누군가를 지목합니다. 이렇게 계~속 동무동무하며 돌아가다가........? 누군가 다른 누군가를 지목하며"마시라우~" 외치면?! 그 사람이 마셔야 되는 거죠.. 그럼 목표는 누구 목표는 누구!!!!!!!!!!!!!!!',
    '랜덤 게임~ 랜덤 게임~ OO이가 좋아하는 랜덤 게임~!',
    '사약 마시기!! 아까 만들었던 사랑이 가득 담긴 사약을 마실 사람은 누구~~~~~~~~~? 사약 아직 안 만들어졌으면 PASS',
    '돌아가면서 왕창 큰 술 잔에 술을 일단 넣어볼까요? 흐흐.. 그리고 가위바위보로 1등을 정한 뒤, 그 사람이 돌아갈 방향을 정합니다! 이제 1등부터 그 방향으로 돌아가면서 마시면 되는데용~ 마지막에 남은 사람은 남은 술 다 마셔야 하는 거 알죠????????????????? 애들아 의리 알지?',
    '딸기 게임은 아이엠그라운드 8박자로 진행되는데용~ 방향을 정해서 차례대로 1부터 시작해서 8까지 간 다음에, 다시 1까지 돌아와야 합니다. 이렇게 1에서 8, 8에서 1을 반복하다가 누군가 틀리면? 그 사람이 마시는 거죠~~ 이 게임은 비교적 쉬우니 다들 좀 취해서 정신을 못 차릴 때 하는 게 뽀인트;;',
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

  Widget verticalBoard(List<int> numbers, List<Color> colors) {
    return Column(
      children: [
        BoardDetail(
          position: position,
          boardNumber: numbers[0],
          color: colors[0],
          text: penalties[numbers[0]],
          explanation: explanations[numbers[0]],
        ),
        BoardDetail(
            position: position,
            boardNumber: numbers[1],
            color: colors[1],
            text: penalties[numbers[1]],
            explanation: explanations[numbers[1]]),
        BoardDetail(
            position: position,
            boardNumber: numbers[2],
            color: colors[2],
            text: penalties[numbers[2]],
            explanation: explanations[numbers[2]]),
        BoardDetail(
            position: position,
            boardNumber: numbers[3],
            color: colors[3],
            text: penalties[numbers[3]],
            explanation: explanations[numbers[3]]),
      ],
    );
  }

  Widget horizontalBoard(List<int> numbers, List<Color> colors) {
    return Column(
      children: [
        BoardDetail(
            position: position,
            boardNumber: numbers[0],
            color: colors[0],
            text: penalties[numbers[0]],
            explanation: explanations[numbers[0]]),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
        ),
        BoardDetail(
            position: position,
            boardNumber: numbers[1],
            color: colors[1],
            text: penalties[numbers[1]],
            explanation: explanations[numbers[1]]),
      ],
    );
  }

  Widget gameBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalBoard([16, 17, 18, 1],
            [Colors.red, Colors.orange, Colors.yellow, Colors.green]),
        horizontalBoard([15, 2], [Colors.blue, Colors.purple]),
        horizontalBoard([14, 3], [Colors.red, Colors.orange]),
        horizontalBoard([13, 4], [Colors.green, Colors.blue]),
        horizontalBoard([12, 5], [Colors.blue, Colors.red]),
        horizontalBoard([11, 6], [Colors.red, Colors.orange]),
        verticalBoard([10, 9, 8, 7],
            [Colors.yellow, Colors.green, Colors.blue, Colors.purple]),
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
                  diceImages[lastDiceNumber],
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
    for (int i = 0; i < widget.players.length; i++) {
      strandedPeople.add(0);
    }
    Future.delayed(Duration(milliseconds: 200), () {
      diceController.add(false);
      penaltyController.add(0);
    });
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
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
