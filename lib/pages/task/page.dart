import 'package:flutter/material.dart';
import 'package:quick_note/constants/index.dart' show appTitleTask, warnTitleNotNull, appTitleHolder, appDetailHolder, appHolderTextStyle;
import 'package:quick_note/components/tasklist/index.dart' show TaskBloc;
import 'package:quick_note/models/task.dart';
import 'package:quick_note/components/dialog/warn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// the page you create or update your task
class TaskPage extends StatefulWidget {
  // this task decide if you want update your task or create a new one
  final Task task;
  TaskPage(this.task);

  @override
  TodoState createState() => new TodoState();
}

class TodoState extends State<TaskPage> {
  final _controllTitle = TextEditingController();
  final _controllDetail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TaskBloc _todoListBloc = BlocProvider.of<TaskBloc>(context);
    if (widget.task != null) {
      _controllDetail.text = widget.task.detail;
      _controllTitle.text = widget.task.title;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitleTask),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              String title = _controllTitle.text;
              String detail = _controllDetail.text;
              if (title != null && title.length > 0) {
                if (widget.task != null) {
                  _todoListBloc.updateTask(new Task(title, detail, widget.task.id));
                } else {
                  _todoListBloc.addTask(new Task(title, detail));
                }
                Navigator.pop(context, true);
              } else {
                AppWarn.basic(context, warnTitleNotNull);
              }
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
            child: TextField(
              controller: _controllTitle,
              decoration: InputDecoration(
                hintText: appTitleHolder,
                hintStyle: appHolderTextStyle,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.cyan[400],
                    width: 2.0
                  )
                )
              ),
            ),
          ),
          TextField(
            controller: _controllDetail,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: appDetailHolder,
              hintStyle: appHolderTextStyle,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.cyan[400],
                  width: 1.0
                )
              )
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    _controllTitle.dispose();
    _controllDetail.dispose();
    super.dispose();
  }
}