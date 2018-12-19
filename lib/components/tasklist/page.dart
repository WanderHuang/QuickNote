import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/models/task.dart';
import 'package:quick_note/components/tasklist/bloc.dart';
import 'package:quick_note/components/tasklist/state.dart';
import 'package:quick_note/constants/index.dart' show rainbowColors;
import 'package:quick_note/pages/task/index.dart';

class TaskList extends StatefulWidget {
  final double itemHeight = 50;
  final double itemButtonsWith = 80;
  final List<Color> colorLevels = rainbowColors;
  
  @override
  State<StatefulWidget> createState() => _TaskListState();

}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    TaskBloc _bloc = BlocProvider.of<TaskBloc>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double dragUpdateDistance;
    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, TaskState state) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return ListView.builder(
              itemCount: state.list.length,
              scrollDirection: orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
              itemBuilder: (BuildContext context int index) {
                Task current = state.list[index];
                return GestureDetector(
                  onHorizontalDragStart: (DragStartDetails details) {
                    dragUpdateDistance = current.id == state.current ? state.currentPosition : 0;
                  },
                  onHorizontalDragEnd: (DragEndDetails details) {
                    if (dragUpdateDistance < -30) {
                      _bloc.updateCurrentPosition(current.id, -80);
                    } else {
                      _bloc.updateCurrentPosition(current.id, 0);
                    }
                    dragUpdateDistance = 0;
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    if (details.delta.direction > 0) { // <-- // [dragUpdateDistance] will always be negtive
                      dragUpdateDistance -= details.delta.distance;
                    } else { // -->
                      dragUpdateDistance += details.delta.distance;
                    }
                    _bloc.updateCurrentPosition(current.id, dragUpdateDistance);
                  },
                  onDoubleTap: () async{
                    await Navigator.push(
                      context,
                      MaterialPageRoute<bool>(builder: (context) {
                        return BlocProvider(
                          bloc: TaskBloc.instance, // new page, but logic is managed by todoListBloc
                          child: TaskEditPage(current),
                        );
                      }),
                    );
                  },
                  child: Container(
                    height: widget.itemHeight,
                    width: screenWidth,
                    child: Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Positioned(
                          left: current.id == state.current ? state.currentPosition : 0,
                          child: Container(
                            height: widget.itemHeight,
                            width: screenWidth + widget.itemButtonsWith,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black26,
                                  width: 1
                                )
                              )
                            ),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          width: 4.0,
                                          color: widget.colorLevels[current.level],
                                          style: BorderStyle.solid
                                        )
                                      )
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: screenWidth * 0.7,
                                              child: Text(
                                                current.content,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: widget.itemHeight * 0.4
                                                )
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: widget.itemHeight * 0.4,
                                              color: current.marked == 1 ? widget.colorLevels[current.level] : Colors.transparent,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              current.date
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: widget.itemButtonsWith,
                                  height: widget.itemHeight,
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 0),
                                    children: <Widget>[
                                      Positioned(
                                        left: 0,
                                        width: widget.itemButtonsWith * 0.5,
                                        height: widget.itemHeight,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            current.marked = current.marked == 1 ? 0 : 1;
                                            print(current.marked);
                                            _bloc.updateTask(current);
                                          },
                                          shape: CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: widget.colorLevels[current.level],
                                          padding: EdgeInsets.all(0),
                                          child: Icon(
                                            current.marked == 1 ? Icons.star : Icons.star_border,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: state.currentPosition.abs() / 2, // 0 -> 0 // -80 40
                                        width: widget.itemButtonsWith * 0.5,
                                        height: widget.itemHeight,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                             _bloc.deleteCurrentTask(current.id);
                                          },
                                          shape: CircleBorder(),
                                          elevation: 2.0,
                                          fillColor: Colors.red,
                                          padding: const EdgeInsets.all(0),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}