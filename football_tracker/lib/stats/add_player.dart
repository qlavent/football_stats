import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({super.key});

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Voeg een speler toe",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              "Voornaam",
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
                  labelText: 'Voornaam',
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
              height: MediaQuery.of(context).size.height / 40,
            ),
            Text(
              "Nummer",
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
                controller: numberController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
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
              height: MediaQuery.of(context).size.height / 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                onPressed: () {
                  if (int.tryParse(numberController.text) != null) {
                    if (int.parse(numberController.text) > 0) {
                      addPlayer(firstNameController.text.toString(),
                          int.parse(numberController.text));
                      Navigator.pop(context);
                    }
                  }
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
          ],
        ),
      ),
    );
  }
}

Future<void> addPlayer(String name, int number,
    {int games = 0,
    int goals = 0,
    int gamesWon = 0,
    int gamesLost = 0,
    int corners = 0,
    int cornersScored = 0,
    int cornersMissed = 0}) async {
  CollectionReference playersCol =
      FirebaseFirestore.instance.collection('players');

  final DocumentReference<dynamic> newDoc =
      await playersCol.add(<String, dynamic>{
    'name': name,
    'number': number,
    'games': games,
    'goals': goals,
    'games won': gamesWon,
    'games lost': gamesLost,
    'corners': corners,
    'corners scored': cornersScored,
    'corners missed': cornersMissed,
  });

  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> players = data['players'];
  Map<String, dynamic> toAdd = <String, dynamic>{
    'name': name,
    'number': number,
    'games': games,
    'goals': goals,
    'games won': gamesWon,
    'games lost': gamesLost,
    'corners': corners,
    'corners scored': cornersScored,
    'corners missed': cornersMissed,
    'player': newDoc,
  };
  players.add(toAdd);
  teamsCol.doc('mvc den derde helft').update({'players': players});
}
