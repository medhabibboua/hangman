import 'package:flutter/material.dart';
import 'package:hangman/UI/colors.dart';
import 'package:hangman/UI/widget/figure_image.dart';
import 'package:hangman/UI/widget/letter.dart';
import 'package:hangman/utils/game.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  String word = "العربية".toUpperCase();
  List<String> alphabets = [
    "ا",
    "ب",
    "ج",
    "د",
    "ه",
    "و",
    "ز",
    "ح",
    "ط",
    "ي",
    "ك",
    "ل",
    "م",
    "ن",
    "س",
    "ع",
    "ف",
    "ص",
    "ق",
    "ر",
    "ش",
    "ت",
    "ث",
    "خ",
    "ذ",
    "ض",
    "ظ",
    "غ",
    "ء",
    "",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("الجلاد"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                figureImage(Game.tries >= 0, "assets/hang.png"),
                figureImage(Game.tries >= 1, "assets/head.png"),
                figureImage(Game.tries >= 2, "assets/body.png"),
                figureImage(Game.tries >= 3, "assets/ra.png"),
                figureImage(Game.tries >= 4, "assets/la.png"),
                figureImage(Game.tries >= 5, "assets/rl.png"),
                figureImage(Game.tries >= 6, "assets/ll.png")
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: word
                .split('')
                .map((e) => letter(e.toUpperCase(),
                    !Game.selectedchar.contains(e.toUpperCase())))
                .toList(),
          ),
          SizedBox(
            width: double.infinity,
            height: 300.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedchar.contains(e)
                      ? null
                      : (() {
                          setState(() {
                            Game.selectedchar.add(e);
                            print(Game.selectedchar);
                            if (!word.split('').contains(e.toUpperCase())) {
                              Game.tries = Game.tries + 1;
                            }
                          });
                        }),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                  fillColor: Game.selectedchar.contains(e)
                      ? Colors.black87
                      : Colors.blue,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
