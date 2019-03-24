import 'package:flutter/material.dart';
import 'package:quick_note/constants/index.dart' show appTitleTask, warnTitleNotNull, appContentHolder, appHolderTextStyle, rainbowColors, rainbowColorTexts;
import 'package:quick_note/components/tasklist/index.dart' show TaskBloc;
import 'package:quick_note/models/task.dart';
import 'package:quick_note/components/common/dialog/warn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/components/circlebutton/index.dart';

/// the page you create or update your task
class TaskEditPage extends StatefulWidget {
  // this task decide if you want update your task or create a new one
  final Task task;
  final List<Color> colorLevels = rainbowColors;
  final List<String> colorTexts = rainbowColorTexts;

  TaskEditPage(this.task);

  @override
  TaskEditState createState() => new TaskEditState();
}

class TaskEditState extends State<TaskEditPage> {
  final _controllContent = TextEditingController();
  int _currentLevel;

  @override
    void initState() {
      _currentLevel = widget.task == null ? 0 : widget.task.level;
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    TaskBloc _todoListBloc = BlocProvider.of<TaskBloc>(context);
    if (widget.task != null) {
      _controllContent.text = widget.task.content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitleTask),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            color: widget.colorLevels[widget.task == null ? _currentLevel : widget.task.level],
            onPressed: () {
              String content = _controllContent.text;
              if (content != null && content.length > 0) {
                
                if (widget.task != null) {
                  widget.task.content = content;
                  _todoListBloc.updateTask(Task.fromTask(widget.task));
                } else {
                  _todoListBloc.addTask(Task(content, _currentLevel, 0));
                }
                Navigator.pop(context, true);
              } else {
                AppWarn.basic(context, warnTitleNotNull);
              }
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          CircleButtonBloc.instance.goShrink();
        },
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '${DateTime.now().toUtc()}',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Text( // maybe replace with an Icon
                    'Sunny'
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: _controllContent,
                autofocus: widget.task == null,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration.collapsed(
                  hintText: appContentHolder,
                  hintStyle: appHolderTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocProvider(
        bloc: CircleButtonBloc.instance,
        child: CircleButton(
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                    children: _getColorfulPanel(),
                  )
                ).then((value) {
                  if (widget.task != null) { // if is update page, then update level
                    widget.task.level = value;
                  }
                  setState(() {
                    _currentLevel = value;
                  });
                });
              },
              icon: Icon(
                Icons.color_lens,
                color: Colors.orange,
              ),
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                print('date_range');
              },
              icon: Icon(
                Icons.date_range,
                color: Colors.pink,
              ),
            )
          ],
        ),
      )
    );
  }

  // get the colorful widgets
  List<Widget> _getColorfulPanel() {
    List<Widget> list = [];
    for(int i = 0; i < widget.colorLevels.length; i++) {
      list.add(
        SimpleDialogOption(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(i);
          },
          child: Container(
            padding: EdgeInsets.all(0),
            width: 100,
            height: 30,
            color: widget.colorLevels[i],
            child: Align(
              child: Text(
                widget.colorTexts[i]
              ),
            ),
          ),
        )
      );
    }
    return list;
  }

  @override
  void dispose() {
    _controllContent.dispose();
    super.dispose();
  }
}