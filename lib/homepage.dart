import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool turn = true;
  List<String> displayOX = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var myTextStyle = TextStyle(fontSize: 30, color: Colors.white);
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        title: Text(
          'Tic Tac Toe',
          style: myNewFontWhite.copyWith(
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Player O',
                          style: myNewFontWhite,
                        ),
                        Text(
                          'Wins : ' + oScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Player X',
                          style: myNewFontWhite,
                        ),
                        Text(
                          'Wins : ' + xScore.toString(),
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext contex, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[700])),
                          child: Center(
                            child: Text(
                              displayOX[index],
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    'Created By : Faizan Shaikh',
                    style: myNewFontWhite.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (turn && displayOX[index] == '') {
        displayOX[index] = 'O';
        filledBoxes++;
      } else if (!turn && displayOX[index] == '') {
        displayOX[index] = 'X';
        filledBoxes++;
      }
      turn = !turn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    String winner = '';
    if (displayOX[0] == displayOX[1] &&
        displayOX[0] == displayOX[2] &&
        displayOX[0] != '') {
      winner = displayOX[0].toString();
      _showDialoge(winner);
    }
    if (displayOX[3] == displayOX[4] &&
        displayOX[3] == displayOX[5] &&
        displayOX[3] != '') {
      winner = displayOX[3].toString();
      _showDialoge(winner);
    }
    if (displayOX[6] == displayOX[7] &&
        displayOX[6] == displayOX[8] &&
        displayOX[6] != '') {
      winner = displayOX[6].toString();
      _showDialoge(winner);
    }
    if (displayOX[0] == displayOX[3] &&
        displayOX[0] == displayOX[6] &&
        displayOX[0] != '') {
      winner = displayOX[0].toString();
      _showDialoge(winner);
    }
    if (displayOX[1] == displayOX[4] &&
        displayOX[1] == displayOX[7] &&
        displayOX[1] != '') {
      winner = displayOX[1].toString();
      _showDialoge(winner);
    }
    if (displayOX[2] == displayOX[5] &&
        displayOX[2] == displayOX[8] &&
        displayOX[2] != '') {
      winner = displayOX[2].toString();
      _showDialoge(winner);
    }
    if (displayOX[0] == displayOX[4] &&
        displayOX[0] == displayOX[8] &&
        displayOX[0] != '') {
      winner = displayOX[0].toString();
      _showDialoge(winner);
    }
    if (displayOX[2] == displayOX[4] &&
        displayOX[2] == displayOX[6] &&
        displayOX[2] != '') {
      winner = displayOX[2].toString();
      _showDialoge(winner);
    } else if (filledBoxes == 9 && winner == '') {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Text('Match Draw'),
            actions: [
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showDialoge(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext contex) {
          return AlertDialog(
            title: Text('Winner is : Player "' + winner + '" !'),
            actions: [
              FlatButton(
                child: Text('Play Again'),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
    if (winner == 'O') {
      oScore++;
    }
    if (winner == 'X') {
      xScore++;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayOX[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
