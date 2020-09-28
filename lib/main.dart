import 'package:flutter/material.dart';
import 'dart:async';
import 'sizes_helper.dart';
import 'package:flushbar/flushbar.dart';

void main() {
  runApp(MyApp());
}


/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//positions will start at bottom of screen-height
//4 columns
//boxes will be 50xwidth/4 for 'words'/images
//boxes will be other for 'phrases'
//#columns = width / 90
//#rows = 4
//idea: for large screens limit the # of columns and increase size of boxes



class _HomeState extends State<Home> {
  var size;
  final double _heightFactor = .7;
  //box 0 starts in pos 0
  final Map _boxCurrentPositionsCol0 = Map<int, int>();
///todo: calculate positions based on screen size
   Map _positions = Map<int, double>();//todo: autofill these vals depending on screen size/ number of boxes

  int _column0Boxes = 0;
  int _numberOfBoxes = 20;
  int _currentBox = 0;
  bool _initialized = false;
  bool _first = true;
  var colorZero = Colors.green;
  var _boxTops = [20.0, 20.0, 20.0, 20.0, 20.0, 20.0];
  var _boxLefts = [];
  //var _boxColors = [Colors.green, Colors.green, Colors.green, Colors.green, Colors.green];
  List<Color> _boxColors = <Color>[];

  int _numberOfRows = 4;
  int _numberOfColumns = 5;
  double _boxWidth= 100;
  double _boxHeight = 50;
  double _stackHeight;


  @override
  void initState() {
    // double stackWidth = size.width -
    // double _width = size;
    super.initState();
    if (!_initialized) {
      print("initing....");
      _initialized = true;
      WidgetsBinding.instance
          .addPostFrameCallback((_) => initiliazeVariables());
    }
  }

  Map getPositions(BuildContext context){print("get positions");

    int wInt = MediaQuery.of(context).size.width ~/4;
    _boxWidth = wInt.toDouble();
    double pos0 = _stackHeight - _boxHeight;
    Map _pos = Map<int, double>();
    _pos[0] = pos0;
    _pos[1] = _pos[0] - _boxHeight;
    _pos[2] = _pos[1] - _boxHeight;
    _pos[3] = _pos[2] - _boxHeight;
    _pos[4] = _pos[3] - _boxHeight;

    return _pos;
  }

  void initiliazeVariables() {
    print("initiliazeVariables");


    startTimeout(1);
  }
  startTimeout(int seconds) {print("startTimeout");//wait a few secs then drop first box
  var duration = Duration(seconds: seconds);
  return new Timer(duration, dropBox);
  }

  void dropBox() {
    setState(() {
      print("setState currentBox= $_currentBox");

      if (_currentBox == 0 ||_currentBox == 4 ||_currentBox == 8 ||_currentBox == 12 ) {
        var highestPosition = 0;   // for 1st box should be 0
        _boxCurrentPositionsCol0.forEach((key, value) {
          print("$key = $value");
          if (highestPosition <= value){
            highestPosition = value+1;
          }
        });

        _boxCurrentPositionsCol0[_currentBox] = highestPosition;
      }



      colorZero = Colors.red;
      _boxColors[_currentBox] = Colors.blue;
      int num = _currentBox ~/4;
      var offset = (_boxHeight * num) + _boxHeight;
      print("offset-$offset num - $num");
      if ( _boxTops[_currentBox] == 20.0){
        //if its col 0 then add to col0boxes.
      if (_currentBox == 0 ||_currentBox == 4 ||_currentBox == 8 ||_currentBox == 12 ) {
         offset = (_boxHeight * _column0Boxes) + _boxHeight;
        _column0Boxes++;
      }


      _boxTops[_currentBox] = _stackHeight - offset;
      print("boxTops  ==  $_boxTops");
        //_top = 393;
        // _bottom = 20;
      }
    });

    _currentBox = _currentBox+1;
    if (_currentBox < 6){
      var duration = Duration(seconds: 2);
      new Timer(duration, dropBox);
    }


  }

  @override
  Widget build(BuildContext context) {

    if (_boxColors.length < _numberOfBoxes) {
      for (int i = 0; i < _numberOfBoxes; i++) {
        _boxColors.add(Colors.white54);
      }
    }

    double _boxWidth = getBoxWidth(context);
    if (_stackHeight == null){
      _stackHeight = MediaQuery.of(context).size.height * _heightFactor;
    }
    if (_boxLefts == null || _boxLefts.isEmpty){
      _boxLefts = [0.0, _boxWidth*1,  _boxWidth*2,  _boxWidth*3];
    }
    if (_positions == null || _positions.isEmpty) {
      _positions = getPositions(context);
    }
    print("in build _positions =_- $_positions");
    print("in build _boxLefts =_- $_boxLefts");



    print("wid = $_boxWidth");
    print("_stackHeight = $_stackHeight");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          color: Colors.white38,
          height: _stackHeight,
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: const Duration(seconds: 2),
                curve: Curves.linear,
                left: _boxLefts[0],
                top: _boxTops[0],
                height: _boxHeight,
                width: displayWidth(context) * 0.25,
                child: GestureDetector(
                  onTap: (){
                    this._unsetBox(context, 0);
                  },
                  child: Container(
                    color: _boxColors[0],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 4),
                curve: Curves.linear,
                left:  _boxLefts[1],
                top: _boxTops[1],
                width: displayWidth(context) * 0.25,
                height: _boxHeight,
                child: GestureDetector(
                  onTap: (){
                  this._unsetBox(context, 1);
                  },
                  child: Container(
                    color: _boxColors[1],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 4),
                curve: Curves.linear,
                left:  _boxLefts[2],
                top: _boxTops[2],
                width: displayWidth(context) * 0.25,
                height: _boxHeight,
                child: Container(
                  color: _boxColors[2],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 4),
                curve: Curves.linear,
                left:  _boxLefts[3],
                top: _boxTops[3],
                width: displayWidth(context) * 0.25,
                height: _boxHeight,
                child: Container(
                  color: _boxColors[3],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 2),
                curve: Curves.linear,
                left:  _boxLefts[0],
                top: _boxTops[4],
                width: displayWidth(context) * 0.25,
                height: _boxHeight,
                child: GestureDetector(
                  onTap: (){
                    this._unsetBox(context, 4);
                  },
                  child: Container(
                    color: _boxColors[4],
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 4),
                curve: Curves.linear,
                left:  _boxLefts[1],
                top: _boxTops[5],
                width: displayWidth(context) * 0.25,
                height: _boxHeight,
                child: Container(
                  color: _boxColors[5],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 0,),
        Row(
          children: [
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('Chicken'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('Apple'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('CLICK ME!'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('CLICK ME!'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('Chicken'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('Apple'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('CLICK ME!'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('CLICK ME!'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('Chicken'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('Apple'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('CLICK ME!'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Container(
              width: _boxWidth,
              child: RaisedButton(
                child: const Text('CLICK ME!'),
                onPressed: () {
                  setState(() {
                    // _left   = _first ?  10 : 10;
                    _boxTops[_currentBox]    = _first ?  10 : 393;   //todo: calculate this
                    _boxTops[_currentBox] = _first ? 20: 393;

                    // _right  = _first ?  10 : 20;
                    // _bottom = _first ?  250 : 00;

                    _first = !_first;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ],
    );
  }
/*

* _boxOrdersColumn0.forEach((key, value) {  //substract 1 from each boxOrder that is higher than currentBox
        //ie...if currentBox is 1, then box0 will still be 0, box 2 will decremented
        var listOfPositionsToDecrement;
        if (value > _currentBox){
          highestPosition = value;
        }
      });

*/
  void _unsetBox(BuildContext context, int boxNum) {
    print(".....................unsetBox");
  // Flushbar(
  //   title:  "Dead On",
  //   message:  "You're as smart as a chimp!",
  //   duration:  Duration(milliseconds: 700),
  // )..show(context);
  setState(() {
    _boxTops[boxNum] = 20.0;
    _boxColors[boxNum] = Colors.black26;

    print("boxnum == $boxNum");
    print("current=$_boxCurrentPositionsCol0");
    int positionOfRemovedElement = _boxCurrentPositionsCol0[boxNum];
    _boxCurrentPositionsCol0.remove(boxNum);    //remove current box and decrement all higher positions

    print("current=$_boxCurrentPositionsCol0");

    var highestPosition = 0;
    var listToDecrement = [];
    _boxCurrentPositionsCol0.forEach((key, value) {
      print("for each $key = $value");
      if (value > positionOfRemovedElement){
        listToDecrement.add(key);
      }
    });
    print("list=$listToDecrement");


    listToDecrement.forEach((element) {//boxOrders is box# : position
      print("current $_boxCurrentPositionsCol0");
      _boxCurrentPositionsCol0[element] = _boxCurrentPositionsCol0[element] -1;
      if (_boxCurrentPositionsCol0[element] < 0){
        _boxCurrentPositionsCol0[element] = 0;
      }
    });

    print("current b4 setting $_boxCurrentPositionsCol0");
    print("_boxTops b4 setting $_boxTops");
    _boxCurrentPositionsCol0.forEach((key, value) { 
      _boxTops[key] = _positions[value];
    });

    print("_boxTops b4 setting $_boxTops");


    print("current=$_boxCurrentPositionsCol0");

    if (boxNum == 0 ||boxNum == 4 ||boxNum == 8 ||boxNum == 12 ) {
      var highestPosition = 1;   // for 1st box should be 0
      _boxCurrentPositionsCol0.forEach((key, value) {
        print("$key = $value");
        if (value > highestPosition){
          highestPosition = value+1;
        }
      });
      print("highestPosition=$highestPosition");        // get highest position

      print("_boxCurrentPositionsCol0   $_boxCurrentPositionsCol0");
      _boxCurrentPositionsCol0[boxNum] = highestPosition;//1:0, 0:1position
      print("_boxCurrentPositionsCol0   $_boxCurrentPositionsCol0");
    }

    //are there other boxes in this column?  then drop them down 1 level.
    //how to know if other boxes?  check their boxTop val. if its 20 its on the top. if its 353 it needs to goto 393
    //if its moving then

  });  //end setState
  //
  print('1');
  Future.delayed(const Duration(seconds: 2), () {
    print('Hello, _restartDropDown');
    _restartDropDown(boxNum);
  });
  print('2');

  }

  void _restartDropDown(int boxNum){    //

    //change position of
    //set color to transparant
    setState(() {print("_restartDropDown the boxnum = $boxNum");

    if (_boxCurrentPositionsCol0.length == 1){  //todo: this is a hack
      _boxCurrentPositionsCol0[boxNum] = 0;
    }

    print("positions = $_positions");
    _boxTops[boxNum] = _positions[_boxCurrentPositionsCol0[boxNum]]; //set position of this BoxNum
    print("boxNum---$boxNum");
    print("_boxCurrentPositionsCol0---$_boxCurrentPositionsCol0");
    print(_positions[_boxCurrentPositionsCol0[boxNum]]);

    _boxColors[boxNum] = Colors.blue;
    if (boxNum == 0) {
      _boxColors[boxNum] = Colors.green;
    }
    });
  }
}
