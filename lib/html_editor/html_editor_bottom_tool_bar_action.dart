import 'package:flutter/material.dart';

class HtmlEditorBottomToolBarIconButton extends StatelessWidget {
  const HtmlEditorBottomToolBarIconButton({
    Key key,
    this.icon,
    this.label,
    this.color,
    this.onClick,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Color color;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color ?? Colors.black38,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              label,
              style: TextStyle(
                  color: color ?? Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}