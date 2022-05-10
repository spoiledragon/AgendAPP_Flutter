import 'package:flutter/material.dart';

class contact_page extends StatefulWidget {
  final String id;
  contact_page(this.id);
  @override
  State<contact_page> createState() => _contact_pageState();
}

class _contact_pageState extends State<contact_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hola numero"+widget.id),
      ),
    );
  }
}
