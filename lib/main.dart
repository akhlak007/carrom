
import 'package:carrom_game/views/game_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Strike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        key: UniqueKey(),
        title: 'Clean Strike',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required Key key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _tapped1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Opacity(
                    opacity: 0.95,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: const AssetImage('assets/carrom.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              backgroundColor: _tapped1
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.25),
                            ),
                            child: Text(
                              'Start Game',
                              style: TextStyle(
                                color: _tapped1 ? Colors.blue : Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _tapped1 = true;
                              });
                              Navigator.of(context)
                                  .push(
                                CupertinoPageRoute<Widget>(
                                  builder: (BuildContext context) =>
                                      CleanStrike(
                                        key: UniqueKey(),
                                        gameType: 1,
                                      ),
                                ),
                              )
                                  .then((dynamic value) {
                                setState(() {
                                  _tapped1 = false;
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//This code replaces the undefined `flotButton` with `ElevatedButton`, which is part of the Flutter Material library. The button now properly responds to the tap event and navigates to the `CleanStrike` page.