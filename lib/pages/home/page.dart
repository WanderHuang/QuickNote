import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/constants/index.dart' show appTitle;
import 'package:quick_note/components/tasklist/index.dart';
import 'package:quick_note/pages/task/index.dart';
import 'package:quick_note/pages/drawer/index.dart';
import 'dart:math';
class HomePage extends StatelessWidget {
  final Random rand = new Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      // backgroundColor: themeSunsetYellow,
      body: Center(
        child: BlocProvider(
          bloc:  TaskBloc.instance,
          child: TaskList(),
        ) 
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan[100],
        foregroundColor: Colors.lightBlue[300],
        child: Icon(
          Icons.add,
          size: 40,
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<bool>(builder: (context) {
              return BlocProvider(
                bloc: TaskBloc.instance, // new page, but logic is managed by todoListBloc
                child: TaskEditPage(null),
              );
            }),
          );
        },
      ),
      endDrawer: DrawerPage(),
    );
  }
}