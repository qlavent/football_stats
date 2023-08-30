import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:football_tracker/stats/add_player.dart';
import 'package:football_tracker/stats/goals_stat.dart';
import 'package:football_tracker/stats/player_stats.dart';

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
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddPlayerPage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
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

              return Padding(
                padding: const EdgeInsets.all(16),
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  fixedLeftColumns: 1,
                  fixedColumnsColor: const Color.fromARGB(255, 247, 199, 199),
                  columns: [
                    const DataColumn2(
                      label: Text('Naam'),
                      fixedWidth: 80,
                    ),
                    const DataColumn2(
                      label: Text('Nummer'),
                      fixedWidth: 70,
                    ),
                    DataColumn2(
                      label: InkWell(
                        child: const Text(
                          'Goals',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GoalsStatPage()));
                        },
                      ),
                      fixedWidth: 50,
                    ),
                    const DataColumn2(
                      label: Text('Corners'),
                      fixedWidth: 80,
                    ),
                    const DataColumn2(
                      label: Text('Wedstrijden'),
                      fixedWidth: 88,
                    ),
                    const DataColumn2(
                      label: Text('Gewonnen wedstrijden'),
                      fixedWidth: 80,
                    ),
                    const DataColumn2(
                      label: Text('Verloren Wedstrijden'),
                      fixedWidth: 62,
                    ),
                    const DataColumn2(
                      label: Text('Pannas'),
                      fixedWidth: 62,
                    ),
                    /*DataColumn2(
                      label: Text('Corners gescoord'),
                      fixedWidth: 130,
                    ),
                    DataColumn2(
                      label: Text('Corners gemist'),
                      fixedWidth: 105,
                    ),*/
                  ],
                  rows: List<DataRow>.generate(
                    players.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(
                          Text(
                            (players[index])['name'],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PlayerStatsPage(
                                        player: (players[index])['player'])));
                          },
                        ),
                        DataCell(
                          Text(
                            (players[index])['number'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['goals'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['corners'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['games'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['games won'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['games lost'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['pannas'].toString(),
                          ),
                        ),
                        /*DataCell(
                          Text(
                            (players[index])['corners scored'].toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            (players[index])['corners missed'].toString(),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              );
              /*
              Scrollbar(
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlayerStatsPage(
                                                    player: (players[i])[
                                                        'player'])));
                                  },
                                  child: Center(
                                    child: Text(
                                      (players[i])['name'],
                                    ),
                                  ),
                                ),
                              ),
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
                                    (players[i])['games lost'].toString(),
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
              );*/
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
