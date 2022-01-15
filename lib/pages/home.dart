import 'package:flutter/material.dart';
import 'package:forif_hackthon_flutter/pages/preparation_room.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PreparationRoom()));
      },
      child: Container(
        child: Scaffold(
          backgroundColor: Color(0xff6DA95F),
          body: Stack(
            children: [
              Center(
                child: Column(children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset("imgs/homebackground.png", width: 500),
                ]),
              ),
              Positioned(
                bottom: 50,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "터치하여 시작",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
