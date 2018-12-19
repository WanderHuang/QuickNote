
import 'package:bloc/bloc.dart';
import 'package:quick_note/components/tasklist/event.dart';
import 'package:quick_note/components/tasklist/state.dart';
import 'package:quick_note/models/task.dart';
import 'package:quick_note/components/tasklist/db.dart';
/// bloc is Business Logic Component. Like a service of mvc or modelview of mvvm.
class TaskBloc extends Bloc<TaskEvent, TaskState> {

  // Singleton for multiple widget
  static final TaskBloc _bloc = TaskBloc._internal();

  static TaskBloc get instance => _bloc;

  TaskBloc._internal() {
    refreshTaskList();
  }
  
  @override
  TaskState get initialState => TaskState(-1, []);

  /// state manager, like a watch for store.prop of Vue.js, handled state will emit to build your widget
  @override
  Stream<TaskState> mapEventToState(TaskState state, TaskEvent event) {
    return _stateHandler(state, event);
  }

  @override
  void dispose() {
    super.dispose(); // widget dispose
  }

  void refreshTaskList() {
    this.dispatch(new GetAllTaskEvent()); // dispatch like a emit of Vue.js
  }

  void setCurrentTask(int id) {
    this.dispatch(new SetCurrentTaskEvent(id));
  }

  void setTaskList(List<Task> list) {
    this.dispatch(new SetTaskListEvent(list));
  }

  void deleteCurrentTask(int id) {
    this.dispatch(new DeleteCurrentEvent(id));
  }

  void addTask(Task item) {
    this.dispatch(new AddTaskEvent(item));
  }

  void updateTask(Task item) {
    this.dispatch(new UpdateTaskEvent(item));
  }

  void updateCurrentPosition(int currentId, double currentPosition) {
    this.dispatch(new UpdateCurrentPositionEvent(currentId, currentPosition));
  }

  // handle by different event type
  Stream<TaskState> _stateHandler(TaskState state, TaskEvent event) async* {
    TaskState newState = state;
    if (event is GetAllTaskEvent) {
      List<Task> list = await TaskDbManager.getAll();
      newState = TaskState(-1, list);
    }

    if (event is SetCurrentTaskEvent) {
      newState = TaskState(event.id, state.list);
    }

    if (event is SetTaskListEvent) {
      newState = TaskState(state.current, event.list);
    }

    if (event is DeleteCurrentEvent) {
      bool success = await TaskDbManager.delete(event.id);
      if (success) {
        List<Task> list = state.list;
        list.removeWhere((item) => item.id == event.id);
        newState = TaskState(-1, list);
      }
      print('DELETE id[${event.id}] is $success');
    }

    if (event is AddTaskEvent) {
      bool success = await TaskDbManager.insert(event.item);
      if (success) {
        newState = TaskState(-1, await TaskDbManager.getAll());
        // refreshList();
      }
      print('ADD is $success');
    }

    if (event is UpdateTaskEvent) {
      bool success = await TaskDbManager.update(event.item);
      if (success) {
        newState = TaskState(-1, await TaskDbManager.getAll());
      }
      print('UPDATE is $success');
    }

    if (event is UpdateCurrentPositionEvent) {
      newState = TaskState(event.currentId, state.list);
      newState.currentPosition = event.position;
    }

    yield newState;
  }
}