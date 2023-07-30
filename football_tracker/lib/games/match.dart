import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_tracker/games/add_goal.dart';

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
  bool finished = true;
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
              finished = data["finished"];
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
                          height: MediaQuery.of(context).size.height / 1.9,
                          width: MediaQuery.of(context).size.width / 1.05,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 25,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
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
                                          if (!finished)
                                            Row(
                                              children: [
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await ownRemoveScore(
                                                        widget.game);
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.red),
                                                ),
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AddGoalPage(
                                                            players: players,
                                                            game: widget.game);
                                                      },
                                                    );
                                                  },
                                                  child: const Icon(Icons.add,
                                                      color: Colors.green),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
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
                                          if (!finished)
                                            Row(
                                              children: [
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await opponentRemoveScore(
                                                        widget.game);
                                                    setState(() {});
                                                  },
                                                  child: const Icon(
                                                      Icons.remove,
                                                      color: Colors.red),
                                                ),
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await opponentAddScore(
                                                        widget.game);
                                                    setState(() {});
                                                  },
                                                  child: const Icon(Icons.add,
                                                      color: Colors.green),
                                                ),
                                                const Spacer(),
                                              ],
                                            ),
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
                                height: MediaQuery.of(context).size.height / 60,
                              ),
                              const Text("    Scorers:"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0;
                                      i < ((scorers.length) / 5).floor();
                                      i++)
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          for (int k = 0; k < 5; k++)
                                            Row(
                                              children: [
                                                Text(
                                                    "       ${(scorers[5 * i + k])['name']} :  ${"|" * (scorers[5 * i + k])['goals']}"),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Column(
                                      children: [
                                        for (int j = 0;
                                            j < scorers.length % 5;
                                            j++)
                                          Row(
                                            children: [
                                              Text(
                                                  "       ${(scorers[((scorers.length) / 5).floor() * 5 + j])['name']} :  ${"|" * (scorers[((scorers.length) / 5).floor() * 5 + j])['goals']}"),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  const Text("Selectie: "),
                  for (int i = 0; i < ((players.length) / 3).floor(); i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.6,
                          child: Text("${(players[3 * i])['name']}"),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3.6,
                            child: Text("${(players[3 * i + 1])['name']}")),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3.6,
                            child: Text("${(players[3 * i + 2])['name']}")),
                        const Spacer(),
                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      for (int j = 0; j < players.length % 3; j++)
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 3.6,
                            child: Text(
                                "${(players[((players.length) / 3).floor() * 3 + j])['name']}")),
                      for (int j = 0; j < 3 - players.length % 3; j++)
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.6,
                        ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  if (!finished)
                    ElevatedButton(
                      onPressed: () async {
                        await finishGame(widget.game);
                        setState(() {});
                      },
                      child: const Text("Wedstrijd beëindigen"),
                    ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                ],
              );
            }
          }

          return const Center(
            child: Text("  "),
          );
        },
      ),
    );
  }
}

Future<void> finishGame(DocumentReference<Map<String, dynamic>> game) async {
  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  List<dynamic> players = data['players'];
  for (int i = 0; i < games.length; i++) {
    if ((games[i])['game'] == game) {
      games[i]['finished'] = true;
    }
  }

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;
  bool finished = gameData['finished'];
  finished = true;
  game.update({'finished': finished});

  for (int i = 0; i < (gameData['players']).length; i++) {
    var playerDoc = await ((gameData['players'])[i])['player'].get();
    var playerData = playerDoc.data() as Map<String, dynamic>;
    int games = playerData['games'] + 1;
    int gamesLost = playerData['games lost'];
    int gamesWon = playerData['games won'];
    if (gameData['opponent score'] > gameData['own score']) {
      gamesLost += 1;
    }
    if (gameData['opponent score'] < gameData['own score']) {
      gamesWon += 1;
    }
    ((gameData['players'])[i])['player'].update(
        {'games': games, 'games lost': gamesLost, 'games won': gamesWon});

    for (int j = 0; j < players.length; j++) {
      if ((players[j])['player'] == ((gameData['players'])[i])['player']) {
        (players[j])['games'] = games;
        (players[j])['games lost'] = gamesLost;
        (players[j])['games won'] = gamesWon;
      }
    }
  }

  teamsCol
      .doc('mvc den derde helft')
      .update({'games': games, 'players': players});
}

Future<void> opponentAddScore(
    DocumentReference<Map<String, dynamic>> game) async {
  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  for (int i = 0; i < games.length; i++) {
    if ((games[i])['game'] == game) {
      games[i]['opponent score'] += 1;
    }
  }
  teamsCol.doc('mvc den derde helft').update({'games': games});

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;
  int opponentScore = gameData['opponent score'] += 1;
  game.update({'opponent score': opponentScore});
}

Future<void> opponentRemoveScore(
    DocumentReference<Map<String, dynamic>> game) async {
  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  for (int i = 0; i < games.length; i++) {
    if ((games[i])['game'] == game) {
      if (games[i]['opponent score'] > 0) {
        games[i]['opponent score'] -= 1;
      }
    }
  }
  teamsCol.doc('mvc den derde helft').update({'games': games});

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;
  int opponentsScore = 0;
  if (gameData['opponent score'] > 0) {
    opponentsScore = gameData['opponent score'] -= 1;
  }
  game.update({'opponent score': opponentsScore});
}

Future<void> ownRemoveScore(
    DocumentReference<Map<String, dynamic>> game) async {
  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  for (int i = 0; i < games.length; i++) {
    if ((games[i])['game'] == game) {
      if (games[i]['own score'] > 0) {
        games[i]['own score'] -= 1;
      }
    }
  }
  teamsCol.doc('mvc den derde helft').update({'games': games});

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;
  int ownScore = 0;
  if (gameData['own score'] > 0) {
    ownScore = gameData['own score'] -= 1;
  }
  game.update({'own score': ownScore});
}
