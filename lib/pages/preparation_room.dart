import 'package:flutter/material.dart';

class PreparationRoom extends StatefulWidget {
  const PreparationRoom({Key? key}) : super(key: key);

  @override
  _PreparationRoomState createState() => _PreparationRoomState();
}

class _PreparationRoomState extends State<PreparationRoom> {
  List<String> participantsList = [];
  TextEditingController addParticipantController = TextEditingController();

  get mainAxisAlignment => null;

  @override
  Widget addParticipantArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: TextField(
            controller: addParticipantController,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: '참가자 이름을 입력해주세요',
              hintStyle: TextStyle(
                color: Colors.green[600],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          width: 500,
          height: 50,
        ),
        SizedBox(width: 20),
        Container(
          color: const Color(0xffF9C519),
          width: 100,
          height: 50,
          child: InkWell(
            onTap: () {
              print("유저 추가 성공! 이름 : " + addParticipantController.text);
              setState(() {
                participantsList.add(addParticipantController.text);
              });
              addParticipantController.text = '';
              print(participantsList);
            },
            child: Center(
                child: Text('추가',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ))),
          ),
        )
      ],
    );
  }

  Widget participantsListArea() {
    return Container(
      height: 180,
      child: Expanded(
        child: GridView.count(
            padding: EdgeInsets.only(
              left: 80,
              right: 80,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 6,
            children: List<Widget>.generate(participantsList.length, (idx) {
              return Column(
                children: [
                  Text(participantsList[idx],
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          participantsList.removeAt(idx);
                          print(participantsList);
                        });
                      },
                      icon: Icon(
                        Icons.person_remove,
                        color: Colors.black,
                        size: 20,
                      ))
                ],
              );
            }).toList()),
      ),
    );
  }

  Widget startArea() {
    return Container(
      color: Colors.amber,
      width: 200,
      height: 50,
      child: InkWell(
        onTap: () {
          // Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => const Game()));
        },
        child: Center(
            child: Text('시작하기',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ))),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              addParticipantArea(),
              SizedBox(height: 30),
              participantsListArea(),
              SizedBox(height: 10),
              startArea()
            ],
          ),
        ));
  }
}
