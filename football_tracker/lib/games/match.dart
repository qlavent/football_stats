import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_tracker/games/add_goal.dart';
import 'package:football_tracker/games/add_panna.dart';
import 'package:unicons/unicons.dart';

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
  List<dynamic> pannas = [];
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
              pannas = data["pannas"];
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height /
                                          2.38 +
                                      MediaQuery.of(context).size.height /
                                          32 *
                                          scorers.length +
                                      MediaQuery.of(context).size.height /
                                          32 *
                                          pannas.length,
                                  width:
                                      MediaQuery.of(context).size.width / 1.05,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                25,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            80,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            300,
                                                      ),
                                                      shape: BoxShape.circle,
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                            "images/logo.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    child: const Text(
                                                        "Mvc Den Derde Helft"),
                                                  ),
                                                  if (!finished)
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                          child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              await ownRemoveScore(
                                                                  widget.game);
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                                Icons.remove,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                          child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AddGoalPage(
                                                                      players:
                                                                          players,
                                                                      game: widget
                                                                          .game);
                                                                },
                                                              );
                                                            },
                                                            icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      25,
                                                ),
                                                Text(
                                                  "$ownScore - $opponentScore",
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            80,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            300,
                                                      ),
                                                      shape: BoxShape.circle,
                                                      image:
                                                          const DecorationImage(
                                                        image: AssetImage(
                                                            "images/logo.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            50,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    child: Text(opponent),
                                                  ),
                                                  if (!finished)
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                          child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              await opponentRemoveScore(
                                                                  widget.game);
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                                Icons.remove,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                          child: IconButton(
                                                            onPressed:
                                                                () async {
                                                              await opponentAddScore(
                                                                  widget.game);
                                                              setState(() {});
                                                            },
                                                            icon: const Icon(
                                                                Icons.add,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                60,
                                      ),
                                      Text(
                                        "    Scorers:",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      //test of new format
                                      for (int i = 0; i < scorers.length; i++)
                                        Row(
                                          children: [
                                            Text(" ${(scorers[i])['name']} : "),
                                            for (int l = 0;
                                                l < (scorers[i])['goals'];
                                                l++)
                                              Icon(
                                                Icons.sports_soccer_rounded,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                              ),
                                          ],
                                        ),

                                      /*Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  ((scorers.length) / 5)
                                                      .floor();
                                              i++)
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.2,
                                              child: Column(
                                                children: [
                                                  for (int k = 0; k < 5; k++)
                                                    Row(
                                                      children: [
                                                        Text(
                                                            " ${(scorers[5 * i + k])['name']} : "),
                                                        for (int l = 0;
                                                            l <
                                                                (scorers[5 * i +
                                                                        k])[
                                                                    'goals'];
                                                            l++)
                                                          Icon(
                                                            Icons
                                                                .sports_soccer_rounded,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                30,
                                                          ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              children: [
                                                for (int j = 0;
                                                    j < scorers.length % 5;
                                                    j++)
                                                  Row(
                                                    children: [
                                                      Text(
                                                          " ${(scorers[((scorers.length) / 5).floor() * 5 + j])['name']} : "),
                                                      for (int l = 0;
                                                          l <
                                                              (scorers[((scorers.length) /
                                                                              5)
                                                                          .floor() *
                                                                      5 +
                                                                  j])['goals'];
                                                          l++)
                                                        Icon(
                                                          Icons
                                                              .sports_soccer_rounded,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              30,
                                                        ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),*/
                                      Row(
                                        children: [
                                          Text(
                                            "    Pannas:",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          if (!finished)
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  8,
                                              child: IconButton(
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AddPannaPage(
                                                          players: players,
                                                          game: widget.game);
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                    UniconsLine.archway,
                                                    color: Colors.green),
                                              ),
                                            ),
                                        ],
                                      ),

                                      //test of new format
                                      for (int i = 0; i < pannas.length; i++)
                                        Row(
                                          children: [
                                            Text(" ${(pannas[i])['name']} : "),
                                            for (int l = 0;
                                                l < (pannas[i])['pannas'];
                                                l++)
                                              Icon(
                                                UniconsLine.archway,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                              ),
                                          ],
                                        ),

                                      /*
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          for (int i = 0;
                                              i < ((pannas.length) / 5).floor();
                                              i++)
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.2,
                                              child: Column(
                                                children: [
                                                  for (int k = 0; k < 5; k++)
                                                    Row(
                                                      children: [
                                                        Text(
                                                            " ${(pannas[5 * i + k])['name']} : "),
                                                        for (int l = 0;
                                                            l <
                                                                (pannas[5 * i +
                                                                        k])[
                                                                    'pannas'];
                                                            l++)
                                                          Icon(
                                                            UniconsLine.camera,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                30,
                                                          ),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              children: [
                                                for (int j = 0;
                                                    j < pannas.length % 5;
                                                    j++)
                                                  Row(
                                                    children: [
                                                      Text(
                                                          " ${(pannas[((pannas.length) / 5).floor() * 5 + j])['name']} : "),
                                                      for (int l = 0;
                                                          l <
                                                              (pannas[((pannas.length) /
                                                                              5)
                                                                          .floor() *
                                                                      5 +
                                                                  j])['pannas'];
                                                          l++)
                                                        Icon(
                                                          UniconsLine.camera,
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              30,
                                                        ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),*/
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
                          for (int i = 0;
                              i < ((players.length) / 3).floor();
                              i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.6,
                                  child: Text("${(players[3 * i])['name']}"),
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.6,
                                    child: Text(
                                        "${(players[3 * i + 1])['name']}")),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.6,
                                    child: Text(
                                        "${(players[3 * i + 2])['name']}")),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int j = 0; j < players.length % 3; j++)
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3.6,
                                    child: Text(
                                        "${(players[((players.length) / 3).floor() * 3 + j])['name']}")),
                              for (int j = 0; j < 3 - players.length % 3; j++)
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.6,
                                ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(-0.97, -0.95),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.undo,
                      ),
                    ),
                  ),
                  if (!finished)
                    Container(
                      alignment: Alignment.bottomCenter,//const Alignment(-0.97, -0.95),
                      child: ElevatedButton(
                        onPressed: () async {
                          await finishGame(widget.game);
                          setState(() {});
                        },
                        child: const Text("Wedstrijd beëindigen"),
                      ),
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
