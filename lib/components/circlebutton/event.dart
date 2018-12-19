import 'package:quick_note/api/event.dart';

class CircleButtonEvent extends BasicEvent{}

class ExpandEvent extends CircleButtonEvent {
  @override
  String toString() {
    return 'CircleButton[ExpandEvent]';
  }
}

class ShrinkEvent extends CircleButtonEvent {
  @override
  String toString() {
    return 'CircleButton[ShrinkEvent]';
  }
}