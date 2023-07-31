import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddGoalPage extends StatefulWidget {
  final List<dynamic> players;
  final DocumentReference<Map<String, dynamic>> game;
  const AddGoalPage({required this.players, required this.game, super.key});

  @override
  State<AddGoalPage> createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  final TextEditingController firstNameController = TextEditingController();
  List<bool> scorer = <bool>[];
  List<bool> goalType = <bool>[true, false];
  List<Widget> goalTypes = <Widget>[
    const Text('veldgoal'),
    const Text('corner'),
  ];

  @override
  void initState() {
    super.initState();
    scorer = List.filled(widget.players.length, false, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: MediaQuery.of(context).size.height / 1.3,
        child: 
        Column(
          children: <Widget>[
            const Text("doelpunt toevoegen"),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            const Text("type doelpunt"),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  // The button that is tapped is set to true, and the others to false.
                  for (int i = 0; i < goalType.length; i++) {
                    goalType[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red,
              selectedColor: Colors.white,
              fillColor: Colors.redAccent,
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: goalType,
              children: goalTypes,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            const Text("doelpuntenmaker"),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < ((widget.players.length) / 6).floor(); i++)
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Column(
                      children: [
                        for (int k = 0; k < 6; k++)
                          Row(children: [
                            Checkbox(
                              value: scorer[6 * i + k],
                              activeColor: Colors.green,
                              onChanged: (bool? value) {
                                scorer = List.filled(scorer.length, false,
                                    growable: true);
                                scorer[6 * i + k] = value!;
                                setState(() {});
                              },
                            ),
                            Text(
                                "${(widget.players[6 * i + k])['number']} ${(widget.players[6 * i + k])['name']}"),
                          ]),
                      ],
                    ),
                  ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: Column(
                    children: [
                      for (int j = 0; j < widget.players.length % 6; j++)
                        Row(children: [
                          Checkbox(
                            value: scorer[
                                ((widget.players.length) / 6).floor() * 6 + j],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              scorer = List.filled(scorer.length, false,
                                  growable: true);
                              scorer[((widget.players.length) / 6).floor() * 6 +
                                  j] = value!;
                              setState(() {});
                            },
                          ),
                          Text(
                              "${(widget.players[((widget.players.length) / 6).floor() * 6 + j])['number']} ${(widget.players[((widget.players.length) / 6).floor() * 6 + j])['name']}"),
                        ]),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                int location = scorer.indexWhere((player) => player == true);
                Map<String, dynamic> player = widget.players[location];
                ownAddScore(
                  widget.game,
                  player,
                  goalType[1],
                );
                Navigator.pop(context);
              },
              child: const Text("Voeg doelpunt toe"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> ownAddScore(DocumentReference<Map<String, dynamic>> game,
    Map<String, dynamic> player, bool corner) async {
  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  List<dynamic> players = data['players'];
  for (int i = 0; i < games.length; i++) {
    if ((games[i])['game'] == game) {
      games[i]['own score'] += 1;
    }
  }

  for (int i = 0; i < players.length; i++) {
    if ((players[i])['player'] == (player)['player']) {
      if (corner) {
        (players[i])['goals'] += 1;
        (players[i])['corners'] += 1;
        (players[i])['corners scored'] += 1;
      } else {
        (players[i])['goals'] += 1;
      }
    }
  }

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;
  int ownScore = gameData['own score'] += 1;

  bool inList = false;
  List gameScorers = gameData['scorers'];
  for (int i = 0; i < gameScorers.length; i++) {
    if ((gameScorers[i])['player'] == (player)['player']) {
      inList = true;
      (gameScorers[i])['goals'] += 1;
    }
  }
  if (!inList) {
    gameScorers.add(
        {'goals': 1, 'name': (player)['name'], 'player': (player)['player']});
  }

  game.update({'own score': ownScore, 'scorers': gameScorers});

  var playerDoc = await (player)['player'].get();
  var playerData = playerDoc.data() as Map<String, dynamic>;
  if (corner) {
    int goals = playerData['goals'] + 1;
    int corners = playerData['corners'] + 1;
    int cornersScored = playerData['corners scored'] + 1;
    (player)['player'].update(
        {'goals': goals, 'corners': corners, 'corners scored': cornersScored});
  } else {
    int goals = playerData['goals'] + 1;
    (player)['player'].update({
      'goals': goals,
    });
  }

  teamsCol
      .doc('mvc den derde helft')
      .update({'games': games, 'players': players});
}
