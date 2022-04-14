import 'package:flutter/material.dart';
import "package:firedart/firedart.dart";

const apiKey = "";
const projectId = "";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    

    //aca es todo lo que si se ve

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Image.asset(
                  "assets/logo.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Text("Bienvenido Papi",
                  style: TextStyle(
                      //color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text("Name",
                  style: TextStyle(
                      //color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              Text("Mail",
                  style: TextStyle(
                      //color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              ActionChip(label: Text("Log Out"), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
