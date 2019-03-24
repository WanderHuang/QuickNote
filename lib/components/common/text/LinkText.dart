import 'package:quick_note/utils/lauchUrl.dart';
import 'package:flutter/material.dart';
class LinkText extends StatefulWidget {
  final String text;
  final String url;
  final bool useUrl;
  final Color fontColor;

  LinkText({ this.text, this.url, this.useUrl, this.fontColor});

  @override
  State<StatefulWidget> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        widget.text,
        style: TextStyle(
          color: widget.fontColor != null ? widget.fontColor : Colors.white,
          decoration: TextDecoration.underline,
          fontSize: 12
        ),
      ),
      onTap: () {
        if (widget.useUrl) {
          launchURL(widget.url);
        }
      },
    );
  }
  
}