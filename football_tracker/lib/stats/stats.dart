import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:football_tracker/main.dart';
import 'package:football_tracker/stats/add_player.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<dynamic> players = <dynamic>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistieken'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPlayerPage()));
        },
        child: const Icon(Icons.add),
      ),
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
              players = data["players"];

              return Scrollbar(
                child: ListView(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultColumnWidth: const IntrinsicColumnWidth(),
                        border: TableBorder.all(
                            color: Colors.grey.shade200, width: 5),
                        children: [
                          const TableRow(children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Naam',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Nummer',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Goals',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Wedstrijden',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Gewonnen wedstrijden',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Verloren Wedstrijden',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Corners gescoord',
                                ))),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Corners gemist',
                                ))),
                          ]),
                          for (int i = 0; i < players.length; i++)
                            TableRow(children: [
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['name'],
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['number'].toString(),
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['goals'].toString(),
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['games'].toString(),
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['games won'].toString(),
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['games won'].toString(),
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['corners scored'].toString(),
                                  ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                      child: Text(
                                    (players[i])['corners missed'].toString(),
                                  ))),
                            ]),
                        ],
                      ),
                    ),
                  ],
                ),
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
