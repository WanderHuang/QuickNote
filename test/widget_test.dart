// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/main.dart';
import 'package:quick_note/components/circlebutton/index.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Testing QuickNote', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(QuickNote());
  });

  testWidgets('test Circle Button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircleButton(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  print('color_lens');
                },
                icon: Icon(
                  Icons.color_lens
                ),
              ),
              IconButton(
                onPressed: () {
                  print('date_range');
                },
                icon: Icon(
                  Icons.date_range
                ),
              )
            ],
          ),
        ),
      )
    ));
  });
}
