import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddGamePage extends StatefulWidget {
  const AddGamePage({super.key});

  @override
  State<AddGamePage> createState() => _AddGamePageState();
}

class _AddGamePageState extends State<AddGamePage> {
  final TextEditingController firstNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Voeg een wedstrijd",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
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
              height: MediaQuery.of(context).size.height / 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.height / 10,
              child: ElevatedButton(
                onPressed: () {
                  addGame(firstNameController.text.toString());
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
          ],
        ),
      ),
    );
  }
}

Future<void> addGame(String opponent,
    {int ownScore = 0,
    int opponentScore = 0}) async {
  CollectionReference gamesCol =
      FirebaseFirestore.instance.collection('games');

  final DocumentReference<dynamic> newDoc =
      await gamesCol.add(<String, dynamic>{
    'opponent': opponent,
    'own score': ownScore,
    'opponent score': opponentScore,
    'players': <Map<String,dynamic>>[],
    'scorers': <Map<String,dynamic>>[],
  });

  CollectionReference teamsCol = FirebaseFirestore.instance.collection('teams');
  final document = await teamsCol.doc('mvc den derde helft').get();
  final data = document.data() as Map<String, dynamic>;
  List<dynamic> players = data['games'];
  Map<String, dynamic> toAdd = <String, dynamic>{
    'opponent': opponent,
    'own score': ownScore,
    'opponent score': opponentScore,
    'game': newDoc,
  };
  players.add(toAdd);
  teamsCol.doc('mvc den derde helft').update({'games': players});
}
