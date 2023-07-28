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
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width / 1.05,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 25,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 5.6,
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
                              const Text("    Scorers:"),
                              for (int i = 0; i < scorers.length; i++)
                                Text(
                                    "       ${(scorers[i])['name']} :  ${"|" * (scorers[i])['goals']}"),
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
                      children: [
                        const Spacer(),
                        Text("${(players[3 * i])['name']}"),
                        const Spacer(),
                        Text("${(players[3 * i + 1])['name']}"),
                        const Spacer(),
                        Text("${(players[3 * i + 2])['name']}"),
                        const Spacer(),
                      ],
                    ),
                  Row(
                    children: [
                      const Spacer(),
                      for (int j = 0; j < players.length % 3; j++)
                        Text(
                            "${(players[((players.length) / 3).floor() * 3 + j])['name']}"),
                      const Spacer(),
                    ],
                  ),
                  if (!finished)
                    ElevatedButton(
                      onPressed: () async {
                        await finishGame(widget.game);
                        setState(() {
                        });
                      },
                      child: const Text("Wedstrijd beëindigen"),
                    )
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
  teamsCol.doc('mvc den derde helft').update({'games': games});

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;
  bool finished = gameData['finished'];
  game.update({'finished': finished});

  for(int i = 0; i<(gameData['players']).length;i++){
    var playerDoc = await ((gameData['players'])[i])['player'].get();
    var playerData = playerDoc.data() as Map<String, dynamic>;
    int games = playerData['games'] +1;
    int gamesLost = playerData['games lost'];
     int gamesWon = playerData['games won'];
    if(gameData['opponent score'] > gameData['own score']){
      gamesLost+=1;
    }
    if(gameData['opponent score'] < gameData['own score']){
      gamesWon+=1;
    }
    ((gameData['players'])[i])['player'].update({'games':games, 'games lost': gamesLost, 'games won': gamesWon});

    for(int j = 0; j< players.length;j++){
      if((players[j])['player'] == ((gameData['players'])[i])['player']){
        (players[j])['games'] = games;
        (players[j])['games lost'] = gamesLost;
        (players[j])['games won'] = gamesWon;
      }
    }
  }

  teamsCol.doc('mvc den derde helft').update({'games': games,'players':players});
}



