import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>> game;
  const MatchPage({required this.game, super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  String opponent = "";
  int ownScore = 0;
  int opponentScore = 0;
  List<dynamic> players = [];
  List<dynamic> scorers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: widget.game.snapshots(),
        builder: (
          BuildContext buildContext,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            Map<String, dynamic>? data = snapshot.data!.data();
            if (data != null) {
              opponent = data["opponent"];
              ownScore = data["own score"];
              opponentScore = data["opponent score"];
              players = data["players"];
              scorers = data["scorers"];
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width / 1.05,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 25,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 5.6,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                80,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    300,
                                              ),
                                              shape: BoxShape.circle,
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "images/logo.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const Text("mvc Den Derde Helft"),
                                        ],
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "$ownScore - $opponentScore",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                80,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    300,
                                              ),
                                              shape: BoxShape.circle,
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "images/logo.png"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(opponent),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 25,
                              ),
                              Text("    Scorers:"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Klassen",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
