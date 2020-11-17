import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_swipe_card/main.dart';

class FindNewView extends StatefulWidget {
  @override
  _FindNewViewState createState() => _FindNewViewState();
}

class _FindNewViewState extends State<FindNewView>
    with TickerProviderStateMixin {
  List<Positioned> cardItems = [];
  AnimationController _buttonController;

  int flag = 0; //right = 0, left = 1
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  double dragValue = 1;
  bool draggingLeft = false;

  @override
  void initState() {
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -30.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          _buttonController.reverse();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: Valueer.size.width - 20,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 15.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'bumble',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.amber,
              ),
            ),
          ),
          Container(
            width: size.width * 0.4,
            child: LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.black12,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (value) {
                if (value.primaryDelta >= 0) {
                  if (draggingLeft) {
                    dragValue = 0;
                  }
                  flag = 1;
                  dragValue += value.primaryDelta;
                  draggingLeft = false;
                  setState(() {});
                } else if (value.primaryDelta <= 0) {
                  if (!draggingLeft) {
                    dragValue = 0;
                  }
                  flag = 0;
                  dragValue++;
                  draggingLeft = true;
                  setState(() {});
                }
              },
              onHorizontalDragEnd: (value) {
                setState(() {
                  dragValue = 0.0;
                });
              },
              onHorizontalDragCancel: () {
                setState(() {
                  dragValue = 0.0;
                });
              },
              child: Stack(
                children: [
                  cardItem(
                    Colors.red,
                    flag,
                    right.value,
                    bottom.value,
                    rotate.value,
                    width.value,
                    rotate.value < -10 ? 0.1 : 0.0,
                    swipeRightAnimation,
                    swipeLeftAnimation,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned cardItem(
    Color color,
    int flag,
    double right,
    double bottom,
    double rotation,
    double width,
    double skew,
    Function swipeRight,
    Function swipeLeft,
  ) {
    print('$flag');
    Positioned position = Positioned(
      bottom: bottom,
      right: flag == 0
          ? (dragValue != 0.0 ? dragValue : (right != 0.0 ? right : null))
          : null,
      left: flag == 1
          ? (dragValue != 0.0 ? dragValue : (right != 0.0 ? right : null))
          : null,
      child: new Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: new Matrix4.skewX(dragValue != 0
            ? dragValue < -10
                ? 0.1
                : 0.0
            : skew),
        //..rotateX(-math.pi / rotation),
        child: new RotationTransition(
          turns: new AlwaysStoppedAnimation(flag == 0
              ? (dragValue != 0 ? -(dragValue / 6) / 360 : rotation / 360)
              : (dragValue != 0 ? (dragValue / 6) / 360 : -rotation / 360)),
          child: Card(
            margin: EdgeInsets.all(16.0),
            elevation: 12.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: color,
            child: Container(
              height: Valueer.size.height * 0.7,
              width: Valueer.size.width - 40,
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        padding: EdgeInsets.all(12.0),
                        color: Colors.white,
                        onPressed: swipeLeft,
                        child: Text('Not In'),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(12.0),
                        color: Colors.white,
                        onPressed: swipeRight,
                        child: Text('In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return position;
  }

  void swipeRightAnimation() async {
    setState(
      () {
        flag = 1;
      },
    );
    try {
      await _buttonController.forward();
    } on TickerCanceled {
      print('error');
    }
  }

  void swipeLeftAnimation() async {
    setState(
      () {
        flag = 0;
      },
    );
    try {
      await _buttonController.forward();
    } on TickerCanceled {
      print('error');
    }
  }
}
