import 'package:quick_note/models/task.dart';
/// like a store.prop of Vue.js or a state of React.js
/// all for state management
class TaskState {
  int current = -1;
  List<Task> list = [];
  TaskState(this.current, this.list);

  @override
    String toString() {
      return 'TaskState[Current=$current, List=$list]';
    }
}