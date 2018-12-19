import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/components/circlebutton/bloc.dart';
import 'package:quick_note/components/circlebutton/state.dart';

class CircleButton extends StatefulWidget {
    final List<Widget> children;
    CircleButton({
      Key key,
      @required this.children,
    }) :  assert(children.length > 0 && children.length <= 5),
          super(key: key);

  @override
  _CircleButtonState createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  CircleButtonBloc _bloc;

  @override
  void initState() {
    super.initState();
    _initStatus();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<CircleButtonBloc>(context);
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, CircleButtonState state) {
        double boxDiameter = state.boxRadius * 2;
        if (state.status == 0) { // close
          controller.reverse();
        }
        return Container(
          padding: EdgeInsets.only(left: state.iconRadius, top: state.iconRadius),
          width: boxDiameter,
          height: boxDiameter,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: _getPositionedIconButtons(state),
          ),
        );
      } 
    );
  }

  void _initStatus() {
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
        _bloc.goExpand();
      } else if (status == AnimationStatus.dismissed) {
        _bloc.goShrink();
      }
    });
  }

  List<Widget> _getPositionedIconButtons(CircleButtonState state) {
    List<double> startPositions = [state.startPosition, state.startPosition];
    List<List<double>> endPositions = state.positions;
    

    List<Widget> out = [];
    
    for (int i = 0; i < widget.children.length; i++) {
      out.add(
        AnimatedButton(widget.children[i], animation, startPositions, endPositions[i], state.centerSize)
      );
    }
    out.add(_getCentralButton(state));
    return out;
  }

  Widget _getCentralButton(CircleButtonState state) {
    double iconDiameter = state.iconRadius * 2;
    double boxDifference = state.boxRadius - state.iconRadius;

    return Positioned(
      left: boxDifference,
      top: boxDifference,
      child: Container(
        width: iconDiameter,
        height: iconDiameter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(iconDiameter)),
          color: Colors.cyanAccent[100]
        ),
        child: IconButton(
          icon: Icon(state.status == 1 ? Icons.close : Icons.open_with),
          color: Colors.greenAccent,
          onPressed: () {
            if (state.status == 0) {
              controller.forward();
            } else {
              controller.reverse();
            }
          },
        ),
      ),
    );
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
  // final CircleButtonState state;
  final List<double> startPosition;
  final List<double> endPosition;
  final double size;

  AnimatedButton(
    this.child,
    this.animation,
    this.startPosition,
    this.endPosition,
    this.size
    ) : super(key: ObjectKey(child), listenable: animation) {
  }



  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Tween<double>(begin: startPosition[0], end: endPosition[0]).evaluate(animation),
      top: Tween<double>(begin: startPosition[1], end: endPosition[1]).evaluate(animation),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(size)),
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