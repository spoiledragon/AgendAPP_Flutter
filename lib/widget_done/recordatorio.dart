// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class reminder extends StatefulWidget {
  @override
  String info;
  String hora;
  reminder(this.info,this.hora);
  State<reminder> createState() => _reminderState();
}

class _reminderState extends State<reminder> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(children: <Widget>[
        //lado izquierdo
        Container(
          decoration: BoxDecoration(color: Colors.amber),
          width: 5,
        ),
        //Centro
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(widget.info),Text(widget.hora) ]),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ]),
    );
  }
}
