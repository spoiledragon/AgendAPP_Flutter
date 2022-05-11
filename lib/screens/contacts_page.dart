// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:agendapp/clases/contact_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

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
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.refresh),
      ),
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
      body: Contact_List(widget.id),
    );
  }
}

class Contact_List extends StatefulWidget {
  final String id;
  String id_todelete = "";
  Contact_List(this.id);
  @override
  State<Contact_List> createState() => _Contact_ListState();
}

class _Contact_ListState extends State<Contact_List> {
  bool loading = true;
  List<Contact> contacts = [];
  @override
  void initState() {
    loading = true;
    _loadUser(widget.id);
    super.initState();
  }

  void _loadUser(id) async {
    try {
      var url =
          "https://thelmaxd.000webhostapp.com/Agendapp/contactos.php?userID=" +
              id;
      Response response = await get(Uri.parse(url));
      List<Contact> _contacts = [];
      var userResponse = json.decode(response.body);
      print(userResponse);
      for (var Contacto in userResponse) {
        _contacts.add(Contact.fromJson(Contacto));
      }
      setState(() {
        contacts = _contacts;
        loading = false;
      });
    } catch (e) {}

    //aqui sacamos los datos y los metemos a un array
  }

  void _delete_user(id) async {
    var url =
        "https://thelmaxd.000webhostapp.com/Agendapp/contact_todelete.php?ID=" +
            contacts[id].id;
    Response response = await get(Uri.parse(url));
    List<Contact> _contacts = [];
    //aqui sacamos los datos y los metemos a un array
    var userResponse = json.decode(response.body);
    print(userResponse);
    _loadUser(widget.id);
  }

  void _showModalBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit name'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _delete_user(id);
                },
              ),
            ],
          );
        });
  }

  //LO QUE SI SE VE
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {_showModalBottomSheet(context, index)},
            child: ListTile(
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].email),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(contacts[index].photoUrl)),
              trailing: Text(contacts[index].tel),
            ),
          );
        },
        itemCount: contacts.length);
  }
}
