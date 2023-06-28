import 'package:flutter/material.dart';
import 'package:football_tracker/main.dart';
import 'package:football_tracker/stats/add_player.dart';


class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  var appState = MyAppState.getInstance();

  @override
  Widget build(BuildContext context) {
    appState!.addListener(() {
      if (mounted) {
        setState(() {
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistieken'),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const AddPlayerPage()));
          },
          child: const Icon(Icons.add),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
              ),
              children: const [
                TableCell(
                  child: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(
                    'Value 1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(
                    'Value 2',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TableCell(
                  child: Text(
                    'Value 3',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            for (var row in appState!.players)
              TableRow(
                children: [
                  for (var item in row)
                    TableCell(
                      child: Text(item.toString()),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}