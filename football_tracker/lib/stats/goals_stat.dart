import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GoalsStatPage extends StatefulWidget {
  const GoalsStatPage({super.key});

  @override
  State<GoalsStatPage> createState() => _GoalsStatPageState();
}

class _GoalsStatPageState extends State<GoalsStatPage> {
  Map<String, double> chartMap = {};
  Map<String, double> cornersMap = {};

  Future<void> getGoalData() async {
    CollectionReference teamsCol =
        FirebaseFirestore.instance.collection('teams');
    final document = await teamsCol.doc('mvc den derde helft').get();
    final data = document.data() as Map<String, dynamic>;
    List<dynamic> players = data['players'];
    double goals = 0;
    double cornersScored = 0;
    for (int i = 0; i < players.length; i++) {
      goals += (players[i])['goals'].toDouble();
      cornersScored += (players[i])['corners scored'].toDouble();

      if ((players[i])['goals'] != 0) {
        chartMap[(players[i])['name'].toString()] =
            ((players[i])['goals']).toDouble();
      }
    }
    cornersMap["corners"] = cornersScored;
    cornersMap["veldgoals"] = goals - cornersScored;
    setState(() {});
  }

  @override
  void initState() {
    getGoalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text("Goals"),
                  if (chartMap.isNotEmpty) PieChart(dataMap: chartMap),
                  const Text("verdeling goals"),
                  if (cornersMap.isNotEmpty)
                    PieChart(
                      dataMap: cornersMap,
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
        ],
      ),
    );
  }
}
