import 'package:flutter/material.dart';
import 'package:quick_note/components/common/image/Avatar.dart';
import 'package:quick_note/constants/index.dart' show appMail, appGithub;

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        key: Key('Author Infomation'),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan[600]
            ),
            child: Avatar(
              src: 'assets/author.png',
              mail: appMail,
              github: appGithub
            ),
          )
        ],
      ),
    );
  }
}