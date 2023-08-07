import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_tracker/games/add_game.dart';

import 'match.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  List<dynamic> games = <dynamic>[];
  List<dynamic> players = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('teams')
            .doc('mvc den derde helft')
            .snapshots(),
        builder: (
          BuildContext buildContext,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            Map<String, dynamic>? data = snapshot.data!.data();
            if (data != null) {
              games = data["games"];
              players = data["players"];

              return Scrollbar(
                child: ListView(
                  children: [
                    for (int i = games.length - 1; i >= 0; i--)
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MatchPage(
                                      game: ((games[i])["game"])
                                          as DocumentReference<
                                              Map<String, dynamic>>)));
                        },
                        child: Card(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                80,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                8,
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
                                            image:
                                                AssetImage("images/logo.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Text("Mvc Den Derde Helft"),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    if((games[i])['finished'])
                                      const Text("AFGELOPEN"),
                                    if(!(games[i])['finished'])
                                      const Text("  "),
                                    Text(
                                      "${(games[i])['own score'].toString()} - ${(games[i])['opponent score'].toString()}",
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                80,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                8,
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
                                            image:
                                                AssetImage("images/logo.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Text((games[i])['opponent'].toString()),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          }

          return const Center(
            child: Text("  "),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddGamePage(players: players)));
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
