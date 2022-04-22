// ignore_for_file: prefer_const_constructors

import 'package:agendapp/widget_done/new_reminder.dart';
import 'package:agendapp/widget_done/recordatorio.dart';
import 'package:flutter/material.dart';

class User {
  String name;
  String forma;
  User(this.name, this.forma);
}

List<User> Usuarios = [];

class HomeScreen extends StatefulWidget {


//Fin de Pruebas
//pruebas

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
      agregar() {
    for (int i = 0; i < 5; i++) {
      var b = User("Pablo", "forma $i");
      Usuarios.add(b);
    }
  }

  recorrer() {
//print using iterator
    for (var u in Usuarios) {
      print(u.forma);
    }
  }

//Fin de Pruebas
//pruebas
//Botones de Prueba
    final boton1 = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          agregar();
          recorrer();
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

//ya

    //aca es todo lo que si se ve
    return Scaffold(
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
              Column(children: <Widget>[
                reminder(),
                SizedBox(
                  height: 50,
                ),
                reminder(),
                SizedBox(
                  height: 50,
                ),
                reminder()
              ]),
              //Derecha
              //OSEA new reminder!---------------------------------------
              Column(
                children: <Widget>[
                  
                  boton1,
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
