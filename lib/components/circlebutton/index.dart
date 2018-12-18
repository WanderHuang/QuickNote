import 'package:flutter/material.dart';
import 'dart:math';
class CircleButton extends StatefulWidget {
    final List<Widget> children;
    final List<List<double>> animationPositions = [[]];
    final double boxRadius = 75;
    final double iconRadius = 20;
    

    CircleButton({
      Key key,
      @required this.children,
    }) :  assert(children.length > 0 && children.length <= 5),
          super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> with TickerProviderStateMixin {
  List<List<double>> _positions = [];
  AnimationController controller;
  Animation<double> animation;
  bool isOpen = false;
  double startPosition;
  

  @override
  void initState() {
    super.initState();
    _initStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.iconRadius, top: widget.iconRadius),
      width: widget.boxRadius * 2,
      height: widget.boxRadius * 2,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: _getPositionedIconButtons([startPosition, startPosition], _positions),
      ),
    );
  }

  void _initStatus() {
    startPosition = widget.boxRadius - widget.iconRadius;

    double line = startPosition * sqrt1_2;
    _positions.add([startPosition - line, startPosition - line]);
    _positions.add([startPosition, 0]);
    _positions.add([0, startPosition]);
    _positions.add([startPosition + line, startPosition - line]);
    _positions.add([startPosition - line, startPosition + line]);
    
    controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.ease
    );

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isOpen = true;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          isOpen = false;
        });
      }
    });

    // controller.forward();
  }

  List<Widget> _getPositionedIconButtons(List<double> startPositions, List<List<double>> endPositions) {
    List<Widget> out = [];
    
    for (int i = 0; i < widget.children.length; i++) {
      out.add(
        AnimatedButton(widget.children[i], animation, startPositions, endPositions[i])
      );
    }
    out.add(
      Positioned(
        left: widget.boxRadius - widget.iconRadius,
        top: widget.boxRadius - widget.iconRadius,
        child: Container(
          width: widget.iconRadius * 2,
          height: widget.iconRadius * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(widget.iconRadius * 2)),
            color: Colors.cyanAccent[100]
          ),
          child: IconButton(
            icon: Icon(isOpen ? Icons.close : Icons.open_with),
            color: Colors.greenAccent,
            onPressed: () {
              if (isOpen) {
                controller.reverse();
              } else {
                controller.forward();
              }
            },
          ),
        ),
      )
    );
    return out;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// get an animated widget
class AnimatedButton extends AnimatedWidget {
  final Widget child;
  final Animation<double> animation;
  final List<double> endPosition;
  final List<double> startPosition;

  AnimatedButton(
    this.child,
    this.animation,
    this.startPosition,
    this.endPosition
    ) : super(key: ObjectKey(child), listenable: animation) {
  }



  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Tween<double>(begin: startPosition[0], end: endPosition[0]).evaluate(animation),
      top: Tween<double>(begin: startPosition[1], end: endPosition[1]).evaluate(animation),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          color: Colors.cyanAccent[100],
        ),
        child: child,
      ),
    );
  }
}

// void main(List<String> args) {
//   runApp(
//     CircleButton(
//       children: <Widget>[
//         IconButton(
//           onPressed: () {
//             print('color_lens');
//           },
//           icon: Icon(
//             Icons.color_lens,
//             size: 20,
//           ),
//         ),
//         IconButton(
//           onPressed: () {
//             print('date_range');
//           },
//           icon: Icon(
//             Icons.date_range,
//             size: 20,
//           ),
//         )
//       ],
//     )
//   );
// }