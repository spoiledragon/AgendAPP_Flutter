// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:convert';
import 'package:agendapp/widget_done/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../clases/reminder_class.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  HomeScreen(this.email);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Reminder> reminders = [];

  Future<void> fetchReminder() async {
    reminders.clear();
    var url =
        'https://thelmaxd.000webhostapp.com/Agendapp/reminders.php?userID=1';
    Response response = await get(Uri.parse(url));
    print(response.body);

    var reminderesponse = json.decode(response.body);
    for (var responsejson in reminderesponse) {
      reminders.add(Reminder.fromJson(responsejson));
    }
    print(reminders[0].id);
    setState(() {});
    int seconds = 1;
    return Future.delayed(Duration(seconds: 3));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReminder();
  }

  @override
  Widget build(BuildContext context) {
    //Esto si Funciona
    //print(reminders2);
    //aca es todo lo que si se ve
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchReminder(),
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //izquierda
              //aqui debera ir el refresh
              Expanded(
                  child: Container(
                color: Colors.amber,
                child: RefreshIndicator(
                  onRefresh: fetchReminder,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      return Container(
                          color: Colors.blue,
                          child: reminder(reminders[index].reminder,reminders[index].date)
                          );
                    },
                  ),
                ),
              )),

              //Derecha
              //OSEA new reminder!---------------------------------------
              Expanded(
                child: Column(children: [
                  addReminder(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class addReminder extends StatefulWidget {
  @override
  State<addReminder> createState() => _addReminderState();
}

class _addReminderState extends State<addReminder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController materiaController = TextEditingController();
  final TextEditingController diaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nombreField = TextFormField(
      autofocus: false,
      controller: nombreController,
      onSaved: (value) {
        nombreController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nombre",
          labelText: "Nombre",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ))),
    );

    final addBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          //var remi = Recordatorios(nombreController.text, "22-04-2022");
          // prueba.add(remi);
        },
        child: Text(
          "Create Activity",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Container(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text("Añadir Nueva Tarea"),
            nombreField,
            addBtn,
          ]),
        ),
      ),
    );
  }
}
