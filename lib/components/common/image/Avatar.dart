import 'package:flutter/material.dart';
import 'package:quick_note/components/common/text/LinkText.dart';
import 'package:quick_note/utils/lauchUrl.dart';
import 'package:quick_note/constants/index.dart' show appMotto;

class Avatar extends StatefulWidget {

  // image src
  final String src;

  // mail location
  final String mail;
  
  // github location
  final String github;

  // press callback
  final VoidCallback onPressed;

  Avatar({ this.src, this.mail, this.github, this.onPressed });

  @override
  State<StatefulWidget> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              child: Image(
                width: 60,
                height: 60,
                image: AssetImage(widget.src),
                fit: BoxFit.fill,
              ),
              onTap: () {
                if (widget.onPressed != null) {
                  widget.onPressed();
                } else {
                  launchURL(widget.github);
                }
              },
            ),
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 8,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LinkText(
                      text: widget.mail,
                      url: widget.mail,
                      useUrl: false
                    ),
                    Icon(
                      Icons.mail,
                      size: 14,
                      color: Colors.white,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LinkText(
                      text: widget.github,
                      url: widget.github,
                      useUrl: true,
                    ),
                    Icon(
                      Icons.book,
                      size: 14,
                      color: Colors.white
                    )
                  ],
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                appMotto,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'HandleeRegular'
                )
              )
            )
          ],
        )
      ],
    );
  }
  
}