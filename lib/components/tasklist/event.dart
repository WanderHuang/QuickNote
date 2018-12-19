import 'package:quick_note/api/event.dart';
import 'package:quick_note/models/task.dart';
/// task event
class TaskEvent extends BasicEvent {}

class SetCurrentTaskEvent extends TaskEvent {
  int id;
  SetCurrentTaskEvent(this.id);

  @override
  String toString() {
    return 'SetCurrentTaskEvent[$id]';
  }
}

class SetTaskListEvent extends TaskEvent {
  List<Task> list;
  SetTaskListEvent(this.list);

  @override
  String toString() {
    return 'SetTaskListEvent';
  }
}

class DeleteCurrentEvent extends TaskEvent {
  int id;
  DeleteCurrentEvent(this.id);

  @override
  String toString() {
    return 'DeleteCurrentEvent';
  }
}

class GetAllTaskEvent extends TaskEvent {
  @override
  String toString() {
    return 'GetAllTaskEvent';
  }
}

class AddTaskEvent extends TaskEvent {
  Task item;
  AddTaskEvent(this.item);

  @override
  String toString() {
    return 'AddTaskEvent';
  }
}

class UpdateTaskEvent extends TaskEvent {
  Task item;
  UpdateTaskEvent(this.item);

  @override
  String toString() {
    return 'UpdateTaskEvent';
  }
}

class UpdateCurrentPositionEvent extends TaskEvent {
  int currentId;
  double position;
  UpdateCurrentPositionEvent(this.currentId, this.position);
  @override
  String toString() {
    return 'UpdateCurrentPositionEvent [currentId=$currentId, postion=$position]';
  }
}