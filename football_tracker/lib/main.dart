import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:football_tracker/games/games.dart';
import 'package:football_tracker/stats/stats.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyAppState extends ChangeNotifier {
  static MyAppState? appStateInstance;

  final List<List<dynamic>> players = [
    ['John', 5, 12, 17],
    ['Emily', 8, 14, 3],
    ['Michael', 10, 9, 18],
    ['Emma', 2, 7, 16],
    ['Daniel', 15, 4, 1],
    ['Olivia', 11, 19, 6],
  ];

  MyAppState() {
    appStateInstance ??= this;
  }

  static void delete() {
    appStateInstance = null;
  }

  static MyAppState? getInstance() {
    return appStateInstance;
  }

  List<List<dynamic>> getPlayers(){
    return players;
  }

  void addPlayer(String name, int goals, int games, int corners){
    List<dynamic> toAdd = <dynamic>[name,0,0,0];
    players.add(toAdd);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPage = 0;
  var appstate = MyAppState();
  @override
  Widget build(BuildContext context) {
    Widget page = const Placeholder();
    if(selectedPage == 0){
      page = const GamesPage();
    }else{
      page = const StatsPage();
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Mvc Den Derde Helft")),
      body: Center(
        child: page,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Wedstrijden'),
              onTap: () {
                // Update the state of the app
                selectedPage = 0;
                // Then close the drawer
                Navigator.pop(context);
                setState(() {
                  
                });
              },
            ),
            ListTile(
              title: const Text('Stats'),
              onTap: () {
                // Update the state of the app
                selectedPage = 1;
                // Then close the drawer
                Navigator.pop(context);
                setState(() {
                  
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
