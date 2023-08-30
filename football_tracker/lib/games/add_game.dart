import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGamePage extends StatefulWidget {
  final List<dynamic> players;
  const AddGamePage({required this.players, super.key});

  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final TextEditingController firstNameController = TextEditingController();
  List<bool> selection = <bool>[];

  @override
  void initState() {
    super.initState();
    selection = List.filled(widget.players.length, false, growable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Voeg een wedstrijd toe",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
              ),
              Text(
                "tegenstander",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 10,
                child: TextFormField(
                  autofocus: true,
                  controller: firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'tegenstander',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    errorStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 25,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 25,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 60,
              ),
              const Text("Selecteer spelers"),
              for (int i = 0; i < ((widget.players.length) / 2).floor(); i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        children: [
                          Checkbox(
                            value: selection[2 * i],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              selection[2 * i] = value!;
                              setState(() {});
                            },
                          ),
                          Text(
                              "${(widget.players[2 * i])['number']} ${(widget.players[2 * i])['name']}"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        children: [
                          Checkbox(
                            value: selection[2 * i+1],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              selection[2 * i+1] = value!;
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
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Row(
                        children: [
                          Checkbox(
                            value: selection[
                                ((widget.players.length) / 2).floor() * 2 + j],
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              selection[
                                  ((widget.players.length) / 2).floor() * 2 +
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
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                  const Spacer(),
                ],
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0;
                      i < ((widget.players.length) / 10).floor();
                      i++)
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Column(
                        children: [
                          for (int k = 0; k < 10; k++)
                            Row(children: [
                              Checkbox(
                                value: selection[10 * i + k],
                                activeColor: Colors.green,
                                onChanged: (bool? value) {
                                  selection[10 * i + k] = value!;
                                  setState(() {});
                                },
                              ),
                              Text(
                                  "${(widget.players[10 * i + k])['number']} ${(widget.players[10 * i + k])['name']}"),
                            ]),
                        ],
                      ),
                    ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: Column(
                      children: [
                        for (int j = 0; j < widget.players.length % 10; j++)
                          Row(children: [
                            Checkbox(
                              value: selection[
                                  ((widget.players.length) / 10).floor() * 10 +
                                      j],
                              activeColor: Colors.green,
                              onChanged: (bool? value) {
                                selection[
                                    ((widget.players.length) / 10).floor() *
                                            10 +
                                        j] = value!;
                                setState(() {});
                              },
                            ),
                            Text(
                                "${(widget.players[((widget.players.length) / 10).floor() * 10 + j])['number']} ${(widget.players[((widget.players.length) / 10).floor() * 10 + j])['name']}"),
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
                  onPressed: () {
                    List<Map<String, dynamic>> toAdd = <Map<String, dynamic>>[];
                    for (int i = 0; i < selection.length; i++) {
                      if (selection[i]) {
                        Map<String, dynamic> element = {
                          'number': (widget.players[i])['number'],
                          'name': (widget.players[i])['name'],
                          'player': (widget.players[i])['player']
                        };
                        toAdd.add(element);
                      }
                    }
                    addGame(firstNameController.text.toString(), toAdd,
                        ownScore: 0, opponentScore: 0);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: const Text("voeg toe"),
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

Future<void> addGame(
    String opponent, List<Map<String, dynamic>> selectedPlayers,
    {int ownScore = 0, int opponentScore = 0}) async {
  CollectionReference gamesCol = FirebaseFirestore.instance.collection('games');

  final DocumentReference<dynamic> newDoc =
      await gamesCol.add(<String, dynamic>{
    'finished': false,
    'opponent': opponent,
    'own score': ownScore,
    'opponent score': opponentScore,
    'players': selectedPlayers,
    'scorers': <Map<String, dynamic>>[],
    'pannas': <Map<String, dynamic>>[],
  });

  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> games = data['games'];
  Map<String, dynamic> toAdd = <String, dynamic>{
    'finished': false,
    'opponent': opponent,
    'own score': ownScore,
    'opponent score': opponentScore,
    'game': newDoc,
  };
  games.add(toAdd);
  teamsCol.doc('mvc den derde helft').update({'games': games});

  // to be able to add the game for the player
  /*for(int i = 0; i< selectedPlayers.length;i++){
    var playerDoc = await (selectedPlayers[i])['player'].get();
    var playerData = playerDoc.data() as Map<String, dynamic>;
    int games = playerData['games'];
    print(games);
    (selectedPlayers[i])['player'].update({'games':games+1});
  }*/
}
