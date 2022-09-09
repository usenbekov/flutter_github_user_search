import 'package:flutter/material.dart';

class MsgWidget extends StatelessWidget {
  final String msg;
  final Color? color;
  const MsgWidget({Key? key, required this.msg, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(msg, style: TextStyle(color: color)),
    );
  }
}
