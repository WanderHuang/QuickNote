import 'package:flutter/material.dart';
// app info
final String appTitle = 'QuickNote';
final String appTitleAdd = 'Create Note';
final String appTitleTask = 'Task';
final String appTitleHolder = 'create a title';
final String appDetailHolder = 'More details here';

/// db
final String dbTableName = 'todolist';
final String dbTaskId = 'id';
final String dbTaskDate = 'date';
final String dbTaskTitle = 'title';
final String dbTaskDetail = 'detail';

/// system messages
final String warnTitleNotNull = 'Note down your title at least';

/// parameter
final double sizeLarge = 24.0;
final double sizeMiddleLarge = 20.0;
final double sizeMiddle = 18.0;
final double sizeMiddleShort = 16.0;
final double sizeShort = 12.0;

/// text style
final TextStyle appHolderTextStyle = TextStyle(fontWeight: FontWeight.w200, color: Colors.grey[400]);

/// colors
// final Color themeSunsetBlue = Color(0x4cb4e7);
// final Color themeSunsetRed = Color(0xffc09f);
// final Color themeSunsetYellow = Color(0xffee93);
// final Color themeSunsetLightGray = Color(0xe2dbbe);
// final Color themeSunsetDarkGray = Color(0xa3a380);