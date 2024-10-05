import 'package:flutter/material.dart';

class GameOver extends StatefulWidget {
  const GameOver({Key? key, required this.winner}) : super(key: key);
  final int winner;

  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,  // Prevents back button unless needed
      child: Material(
        color: Colors.white.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20.0,
                  ),
                ],
              ),
              child: Card(
                elevation: 1,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Center(
                        child: Text(
                          widget.winner != 0
                              ? 'Game Over\nPlayer ${widget.winner} wins'
                              : 'Draw Match',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Use this if you want to restart the game properly
                          setState(() {
                            Navigator.of(context).pop();

                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          width: 67,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          child: const Center(
                            child: Text(
                              'Restart',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
