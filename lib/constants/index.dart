import 'package:flutter/material.dart';
// app info
final String appTitle = 'QuickNote';
final String appTitleAdd = 'Create Note';
final String appTitleTask = 'Task';
final String appContentHolder = 'Quickly note down your ideas';
final String appMotto = 'The meaning of life is that you live well for the people who love you,'
' and struggle for the people that you love.(My motto)';
final String appMail = 'wanderjie@gmail.com';
final String appGithub = 'https://github.com/WanderHuang';

/// db
final String dbName = 'QuickNote-release-0.0.1.db';
final String dbTableName = 'todolist';
final String dbTaskId = 'id';
final String dbTaskContent = 'content';
final String dbTaskDate = 'date';
final String dbTaskLevel = 'level';
final String dbTaskMarked = 'marked';

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
final List<Color> rainbowColors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.cyan, Colors.blue, Colors.purple];
final List<String> rainbowColorTexts = ['The Red - Level 1', 'The Orange - Level 2', 'The Yellow - Level 3', 'The Green - Level 4', 'The Cyan - Level 5', 'The Blue - Level 6', 'The Purple - Level 7'];