import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/models/task.dart';
import 'package:quick_note/components/tasklist/bloc.dart';
import 'package:quick_note/components/tasklist/state.dart';
import 'package:quick_note/constants/index.dart' show sizeMiddle, sizeShort, sizeMiddleShort;
import 'package:quick_note/pages/task/index.dart';

class TaskList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    TaskBloc _bloc = BlocProvider.of<TaskBloc>(context);
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, TaskState state) {
        return ListView.builder(
          itemCount: state.list.length,
          itemBuilder: (BuildContext context, int index) {
            Task task = state.list[index];
            return _itemBuilder(context, _bloc, task, task.id == state.current);
          }
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, TaskBloc _bloc, Task task, bool isCurrent) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Dismissible(
      key: ObjectKey(task),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          _bloc.deleteCurrentTask(task.id);
        }
      },
      background: Container(
        color: Colors.redAccent[100],
        child: ListTile(
          trailing: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: GestureDetector(
        onDoubleTap: () async{
          await Navigator.push(
            context,
            MaterialPageRoute<bool>(builder: (context) {
              return BlocProvider(
                bloc: TaskBloc.instance, // new page, but logic is managed by todoListBloc
                child: TaskPage(task),
              );
            }),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.cyan[400],
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.4,
                      child: Text(
                        '[ ${task.title} ]',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizeMiddle
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.6,
                      child: Text(
                        '${task.detail}',
                        style: TextStyle(
                          fontSize: sizeMiddleShort
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],            
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${task.date ?? '- -'}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: sizeShort
                      ),
                    )
                  ],
                )
              ],
            )
          ),
        ),
      )
    );
  }
}