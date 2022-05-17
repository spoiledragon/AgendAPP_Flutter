// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print, unused_local_variable, avoid_unnecessary_containers, camel_case_types

import 'dart:convert';
import 'package:agendapp/screens/contacts_page.dart';
import 'package:agendapp/widget_done/recordatorio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../clases/reminder_class.dart';

class HomeScreen extends StatefulWidget {
  final String id;
  HomeScreen(this.id);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Reminder> reminders = [];

  Future<void> fetchReminder() async {
    reminders.clear();
    var url =
        'https://thelmaxd.000webhostapp.com/Agendapp/reminders.php?userID=' +
            widget.id;
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
    // ignore: todo
    // TODO: implement initState
    super.initState();
    fetchReminder();
  }

  @override
  Widget build(BuildContext context) {
    //Esto si Funciona
    //aca es todo lo que si se ve
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 21, 28),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchReminder(),
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("AGENDAPP"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => contact_page(widget.id)));
              },
              icon: Icon(Icons.person))
        ],
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
                child: RefreshIndicator(
                  onRefresh: fetchReminder,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      //mando  a llamar al widget
                      return Column(
                        children: [
                          reminder(
                              reminders[index].reminder,
                              reminders[index].date,
                              reminders[index].id,
                              reminders[index].priority),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
                  ),
                ),
              )),
              //center
              Expanded(
                  child: Column(
                children: [
                  SfCalendar(
                    view: CalendarView.month,
                    monthViewSettings: MonthViewSettings(showAgenda: true),
                    backgroundColor: Colors.white,
                    dataSource: MeetingDataSource(_getDataSource()),
                  )
                ],
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
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController materiaController = TextEditingController();
  final TextEditingController diaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //CAMPO DE RECORDATORIO
    final recordatorioField = TextFormField(
      autofocus: false,
      controller: nombreController,
      onSaved: (value) {
        nombreController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.recommend),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Recordatorio",
          labelText: "Recordatorio",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ))),
    );

    //CAMPO DE DESCRIPCION
    final descriptionField = TextFormField(
      autofocus: false,
      controller: descriptionController,
      onSaved: (value) {
        descriptionController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 60, 20, 60),
          labelText: "Recordatorio",
          alignLabelWithHint: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 5,
              ))),
    );
    //BOTON DE AGREGAR
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
          addMeeting();
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
    // ignore: todo
    //LO QUE CONTIENE TODO LO QUE SE VE
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10)),
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text("Añadir Nueva Tarea", style: TextStyle(color: Colors.white)),
            SizedBox(
              height: 20,
            ),
            recordatorioField,
            SizedBox(
              height: 20,
            ),
            Text(
              "Description",
              style: TextStyle(color: Colors.white),
            ),
            descriptionField,
            SizedBox(
              height: 20,
            ),
            addBtn,
          ]),
        ),
      ),
    );
  }

  void addMeeting() {
    final now = DateTime.now();
    final Meeting a = Meeting("Comida", now,
        DateTime(now.year, now.month, now.day + 4), Colors.yellow, true);
  }
}

//CLASE PARA LOS CALENDARIOS
//EJEMPLO EN EL QUE SE AGREGAN DOS RECORDATORIOS
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day + 1, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  //x somos chavos
  //AQUI CREAMOS UN ELEMENTO DE FECHA 4 DIAS POSTERIORES AL DE HOY EJEMPLO SI HOY ES LUNES, LA SACARA EL JUEVES- VIERNES
  final DateTime startTime2 =
      DateTime(today.year, today.month, today.day + 4, 9, 0, 0);
  //DE LA CLASE QUE ACABAMOS DE CREAR LE VAMOS A AÑADIR EL TIEMPO CUANDO ACABA , OSEA TOMAMOS EL TIEMPO INICIAL Y LE SUMAREMOS 10 HORAS
  final DateTime endTime2 = startTime2.add(const Duration(hours: 10));
//YA SE HA CREADO UNA CLASE "meeting" ASI QUE SOLO LE AÑADIREMOS A LA LISTA DE "meetings"
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  //AQUI CREAMOS OTRA CLASE DEL TIPO "meeting" LLAMADA "a"  en la que guardo los valores que deberian de pedirsele al usuario
  final Meeting a = Meeting("Proyectacion pero que no se guarda uwu",
      startTime2, endTime2, Color(0xFF0F8644), true);
  //Y POSTERIORMENTE LE AGREGAMOS A LA LISTA DE "meetings"
  meetings.add(a);
  print("AQUI");
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
