import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PlayerStatsPage extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>> player;
  const PlayerStatsPage({required this.player, super.key});

  @override
  State<PlayerStatsPage> createState() => _PlayerStatsPageState();
}

class _PlayerStatsPageState extends State<PlayerStatsPage> {
  String name = "";
  int number = 0;
  int games = 0;
  int goals = 0;
  int gamesWon = 0;
  int gamesLost = 0;
  int corners = 0;
  int cornersScored = 0;
  int cornersMissed = 0;

  Map<String, double> gamesMap = {};

  Future<void> getPlayerData() async {
    final document = await widget.player.get();
    final data = document.data() as Map<String, dynamic>;
    name = data['name'];
    number = data['number'];
    games = data['games'];
    goals = data['goals'];
    gamesWon = data['games won'];
    gamesLost = data['games lost'];
    corners = data['corners'];
    cornersScored = data['corners scored'];
    cornersMissed = data['corners missed'];

    gamesMap["gewonnen"] = gamesWon.toDouble();
    gamesMap["verloren"] = gamesLost.toDouble();
    gamesMap["gelijk"] = games.toDouble() - gamesLost.toDouble() - gamesWon.toDouble();

    setState(() {});
  }

  @override
  void initState() {
    getPlayerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Icon(
                Icons.sports_soccer_rounded,
                size: MediaQuery.of(context).size.width / 2.5,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 10,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      "Doelpunten",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                      ),
                    ),
                  ),
                  Text(
                    goals.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      "Cornerdoelpunten",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                      ),
                    ),
                  ),
                  Text(
                    cornersScored.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      "Gespeelde wedstrijden",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                      ),
                    ),
                  ),
                  Text(
                    games.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      "Gewonnen wedstrijden",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                      ),
                    ),
                  ),
                  Text(
                    gamesWon.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(
                      "Verloren wedstrijden",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 17,
                      ),
                    ),
                  ),
                  Text(
                    gamesLost.toString(),
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 17,
                    ),
                  ),
                ],
              ),
              if (gamesMap.isNotEmpty)
                PieChart(
                  dataMap: gamesMap,
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
