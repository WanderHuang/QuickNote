import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:quick_note/components/circlebutton/event.dart';
import 'package:quick_note/components/circlebutton/state.dart';

class CircleButtonBloc extends Bloc<CircleButtonEvent, CircleButtonState> {

  AnimationController controller;
  Animation<double> animation;

  static final CircleButtonBloc _bloc = CircleButtonBloc._internal();

  static CircleButtonBloc get instance => _bloc;

  CircleButtonBloc._internal();
  

  @override
  CircleButtonState get initialState => _initStatus();

  @override
  Stream<CircleButtonState> mapEventToState(CircleButtonState currentState, CircleButtonEvent event) {
    return _eventHandler(currentState, event);
  }

  @override
  void dispose() {
    super.dispose();
  }


  void goExpand() {
    this.dispatch(new ExpandEvent());
  }
  
  void goShrink() {
    this.dispatch(new ShrinkEvent());
  }

  Stream<CircleButtonState> _eventHandler(CircleButtonState currentState, CircleButtonEvent event) async* {
    int status = 0;
    if (event is ExpandEvent) {
      status = 1;
    }

    if (event is ShrinkEvent) {
      status = 0;
    }
    yield CircleButtonState(status, currentState.positions);
  }


  CircleButtonState _initStatus() {
    return CircleButtonState(0);
  }
}