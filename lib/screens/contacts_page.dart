// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

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
      body: Center(
        child: Container(
            //AQUI AÑADIMOS UNA FILA PARA PODER SEPARAR EN LISTA DE CONTACTOS Y EL CONTACTO EN SI
            child: Expanded(
          child: Row(
            children: <Widget>[
              //IZQEUIRDA DE LISTA DE CONTACTOS
              Column(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.all(20),
                    //itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      //mando  a llamar al widget
                      return Container(
                          /*
                        child: contactCard(
                            reminders[index].reminder,
                            reminders[index].date,
                            reminders[index].id,
                            reminders[index].priority),
                          
                           */
                      );
                    },
                  ),
                ],
              )
              //DERECHA DEL CONTACTO SELECCIONADO
            ],
          ),
        )),
      ),
    );
  }
}
