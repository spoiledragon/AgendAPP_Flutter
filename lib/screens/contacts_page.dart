// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:agendapp/clases/user_class.dart';
import 'package:agendapp/widget_done/miniContacto.dart';
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
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Center(child: Text("Contactos")),
        actions: [
          IconButton(
              onPressed: null,
              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.person_add,
                color: Colors.white,
              ))
        ],
      ),
      body: Contact_List(),
    );
  }
}

class Contact_List extends StatefulWidget {
  @override
  State<Contact_List> createState() => _Contact_ListState();
}

class _Contact_ListState extends State<Contact_List> {
  bool loading = false;

  List<User> users = [];
  @override
  void initState() {
    loading = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Titulo $index"),
            subtitle: Text("Hola"),
          );
        },
        itemCount: 100);
  }
}
