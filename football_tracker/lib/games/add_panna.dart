import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPannaPage extends StatefulWidget {
  final List<dynamic> players;
  final DocumentReference<Map<String, dynamic>> game;
  const AddPannaPage({required this.players, required this.game, super.key});

  @override
  State<AddPannaPage> createState() => _AddPannaPageState();
}

class _AddPannaPageState extends State<AddPannaPage> {
  final TextEditingController firstNameController = TextEditingController();
  List<bool> panna = <bool>[];

  @override
  void initState() {
    super.initState();
    panna = List.filled(widget.players.length, false, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 1.5,
          child: ListView(
            children: <Widget>[
              const Center(
                child: Text("panna toevoegen"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              const Center(
                child: Text("gepanneerde"),
              ),
              for (int i = 0; i < ((widget.players.length) / 2).floor(); i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Row(
                        children: [
                          Checkbox(
                            value: panna[2 * i],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              panna = List.filled(panna.length, false,
                                  growable: true);
                              panna[2 * i] = value!;
                              setState(() {});
                            },
                          ),
                          Text(
                              "${(widget.players[2 * i])['number']} ${(widget.players[2 * i])['name']}"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Row(
                        children: [
                          Checkbox(
                            value: panna[2 * i + 1],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              panna = List.filled(panna.length, false,
                                  growable: true);
                              panna[2 * i + 1] = value!;
                              setState(() {});
                            },
                          ),
                          Text(
                              "${(widget.players[2 * i + 1])['number']} ${(widget.players[2 * i + 1])['name']}"),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  for (int j = 0; j < widget.players.length % 2; j++)
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: Row(
                        children: [
                          Checkbox(
                            value: panna[
                                ((widget.players.length) / 2).floor() * 2 + j],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              panna = List.filled(panna.length, false,
                                  growable: true);
                              panna[((widget.players.length) / 2).floor() * 2 +
                                  j] = value!;
                              setState(() {});
                            },
                          ),
                          Text(
                              "${(widget.players[((widget.players.length) / 2).floor() * 2 + j])['number']} ${(widget.players[((widget.players.length) / 2).floor() * 2 + j])['name']}"),
                        ],
                      ),
                    ),
                  for (int j = 0; j < 2 - widget.players.length % 2; j++)
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                    ),
                  const Spacer(),
                ],
              ),

              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0;
                      i < ((widget.players.length) / 6).floor();
                      i++)
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.7,
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
                    width: MediaQuery.of(context).size.width / 2.7,
                    child: Column(
                      children: [
                        for (int j = 0; j < widget.players.length % 6; j++)
                          Row(children: [
                            Checkbox(
                              value: scorer[
                                  ((widget.players.length) / 6).floor() * 6 +
                                      j],
                              activeColor: Colors.green,
                              onChanged: (bool? value) {
                                scorer = List.filled(scorer.length, false,
                                    growable: true);
                                scorer[
                                    ((widget.players.length) / 6).floor() * 6 +
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
              ),*/
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 10,
                child: ElevatedButton(
                  onPressed: () async {
                    int location =
                        panna.indexWhere((player) => player == true);
                    Map<String, dynamic> player = widget.players[location];
                    ownAddScore(
                      widget.game,
                      player,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Voeg panna toe"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> ownAddScore(DocumentReference<Map<String, dynamic>> game,
    Map<String, dynamic> player) async {
  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  List<dynamic> players = data['players'];

  for (int i = 0; i < players.length; i++) {
    if ((players[i])['player'] == (player)['player']) {
      
      (players[i])['pannas'] += 1;
      
    }
  }

  var gameDoc = await game.get();
  var gameData = gameDoc.data() as Map<String, dynamic>;

  bool inList = false;
  List gamePannas = gameData['pannas'];
  for (int i = 0; i < gamePannas.length; i++) {
    if ((gamePannas[i])['player'] == (player)['player']) {
      inList = true;
      (gamePannas[i])['pannas'] += 1;
    }
  }
  if (!inList) {
    gamePannas.add(
        {'pannas': 1, 'name': (player)['name'], 'player': (player)['player']});
  }

  game.update({'pannas': gamePannas});

  var playerDoc = await (player)['player'].get();
  var playerData = playerDoc.data() as Map<String, dynamic>;
  
  int pannas = playerData['pannas'] + 1;
  (player)['player'].update({
    'pannas': pannas,
  });
  

  teamsCol
      .doc('mvc den derde helft')
      .update({'games': games, 'players': players});
}
