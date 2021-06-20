import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int player = 1;
  List<int> matrix = [0,0,0,0,0,0,0,0,0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TrisEvolution"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 25),
          Text(
              "Player" + player.toString(),
              style: TextStyle(fontSize:50)
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              ElevatedButton(
                  onPressed: ()=>{
                    setState(() {
                      if (player!=1){
                        player = 1;
                      } else {
                        player = 2;
                      }
                    })
                  },
                  child: Text("Switch Player")
              ),
              SizedBox(width: 15),
              ElevatedButton(
                  onPressed: ()=>{
                    setState(() {
                      matrix = [0,0,0,0,0,0,0,0,0];
                    })
                  },
                  child: Text("Reset Board")
              ),
            ]
          ),
          SizedBox(height: 25),
          GridView.count(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return GestureDetector(
                onTap: () => _makeMove(index),
                child: DragTarget<int>(
                  builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                      ) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)
                      ),
                      child: Text(
                        getField(index),
                        style: TextStyle(fontSize: getFontSize(index), fontWeight: FontWeight.bold, color: Colors.cyan),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  onAccept: (int data) {
                    setState(() {
                      matrix[index] = data;
                    });
                  },
                ),
              );
            }),
          ),
          SizedBox(height:25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Draggable<int>(
                // Data is the value this Draggable stores.
                data: (3+(3*(player-1))),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Text(
                        (player == 1) ? "X" : "O",
                        style:TextStyle(fontSize: 80, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
                feedback: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Text((player == 1) ? "X" : "O",  style:TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
                  ),
                ),
                childWhenDragging: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.white,
                  child: Center(
                    child: Text(""),
                  ),
                ),
              ),
              SizedBox(width:15),
              Draggable<int>(
                // Data is the value this Draggable stores.
                data: (2+(3*(player-1))),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Text((player == 1) ? "X" : "O", style:TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  ),
                ),
                feedback: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child:  Center(
                    child: Text((player == 1) ? "X" : "O", style:TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                  ),
                ),
                childWhenDragging: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.white,
                  child: const Center(
                    child: Text(""),
                  ),
                ),
              ),
              SizedBox(width:25),
              Draggable<int>(
                // Data is the value this Draggable stores.
                data: (1+(3*(player-1))),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child:  Center(
                    child: Text((player == 1) ? "X" : "O", style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                feedback: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Text((player == 1) ? "X" : "O", style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                childWhenDragging: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.white,
                  child: const Center(
                    child: Text(""),
                  ),
                ),
              ),
            ]
          )
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );

  }

  String getField(int index) {
    if (matrix[index] == 0){
      return "";
    } else if (matrix[index] < 4){
      return "X";
    }
    return "O";
  }

  double getFontSize(int index){
    if (matrix[index] == 0){
      return 0;
    } else if (matrix[index]< 4){
      return 50 * matrix[index].toDouble();
    }
    return 50 * (matrix[index].toDouble()-3);
  }

  void _makeMove(int index){
    setState(() {
      matrix[index] = player;
      print(_checkGame());
    });
  }

  bool _checkGame() {
    for (int i = 0; i < 9; i += 3) {
      if (matrix[i] != 0 &&
          matrix[i] == matrix[i + 1] &&
          matrix[i + 1] == matrix[i + 2]) {
        return true;
      }
    }
    for (int i = 0; i < 3; i++) {
      if (matrix[i] != 0 &&
          matrix[i] == matrix[i + 3] &&
          matrix[i + 3] == matrix[i + 6]) {
        return true;
      }
    }
    if (matrix[0] != 0 && (matrix[0] == matrix[4] && matrix[4] == matrix[8]) ||
        (matrix[2] != 0 && matrix[2] == matrix[4] && matrix[4] == matrix[6])) {
      return true;
    }
    return false;
  }
}
