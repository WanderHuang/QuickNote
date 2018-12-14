import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:quick_note/pages/home/index.dart';
import 'package:quick_note/pages/task/index.dart';
import 'package:quick_note/constants/index.dart' show themeSunsetBlue;

class SimpleBlocDelegate extends BlocDelegate { // keep logs
  @override
  void onTransition(Transition transition) {
    print(transition.toString()); //show all transitions
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(QuickNote());
}

class QuickNote extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuickNoteState();
}

class QuickNoteState extends State<QuickNote> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // material design application
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.cyan[600],
        primaryColorDark: Colors.cyan[800]
      ),
      routes: <String, WidgetBuilder>{
        '/todo': (_) => TaskPage(null)
      }
    );
  }
}

