import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jigsawpuzzle/Widgets/jigsawWidget.dart';
import 'package:jigsawpuzzle/Screens/home_screen.dart';

Widget imagepar = const Text("bhgu");

class JigsawPuzzle extends StatefulWidget {
  const JigsawPuzzle({super.key});

  @override
  State<JigsawPuzzle> createState() => _JigsawPuzzleState();
}

final TextEditingController colController = TextEditingController();
final TextEditingController rowController = TextEditingController();

class _JigsawPuzzleState extends State<JigsawPuzzle> {
  GlobalKey<JigsawWidgetState> jigkey = GlobalKey<JigsawWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.lightBlue,
        Colors.lightBlueAccent,
        Color(0xFFA3ECFF),
        Colors.white
      ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              //color: Colors.redAccent,
            ),
            child: JigsawWidget(
              callbackFinish: () {
                if (kDebugMode) {
                  print("CallBackFinish");
                }
              },
              callbackSuccess: () {
                if (kDebugMode) {
                  print("CallBackSuccess");
                }
                updatePoint();
              },
              key: jigkey,
              // Container for jigsaw image
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    imageWidget(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 70,
              ),
              const Text(
                'Мөр: ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextField(
                    controller: rowController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 5,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const Text(
                'Багана: ',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextField(
                    controller: colController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 15,
                        bottom: 11,
                        top: 11,
                        right: 15,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                await jigkey.currentState!.generalJigsawCropImage();
              },
              icon: const Icon(
                CupertinoIcons.arrow_right,
                color: Colors.greenAccent,
              ),
              label: const Text("Start"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () {
                jigkey.currentState!.resetJigsaw();
              },
              icon: const Icon(
                CupertinoIcons.repeat,
                color: Color(0xFFFE0037),
              ),
              label: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(
                CupertinoIcons.arrow_left,
                color: Colors.blueAccent,
              ),
              label: const Text("Буцах"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }

  Widget imageWidget() {
    if (option == 1) {
      imagepar = Image.file(
        File(file!.path),
        fit: BoxFit.fill,
      );
    } else if (option == 2) {
      imagepar = Image.network(selectedFile, fit: BoxFit.fill);
    }
    return Expanded(
      child: imagepar,
    );
  }
}

Future<void> updatePoint() async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({
    'point': FieldValue.increment(1),
  });
}
