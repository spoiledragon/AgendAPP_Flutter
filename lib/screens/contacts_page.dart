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

//PARTE DE LA CLASE QUE SE VE DENTRO DEL CANVAS PRINCIPAL,
class _contact_pageState extends State<contact_page> {
//CAMPOS Y BOTON PARA ENVIAR

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

//AQUI DECLARAMOS EL WIDGET QUE DESPLIEGA LA LISTA, SOLO ES PARTE DEL CONSTRUCTOR
class Contact_List extends StatefulWidget {
  final String id;
  String id_todelete = "";
  Contact_List(this.id);
  @override
  State<Contact_List> createState() => _Contact_ListState();
}

//INICIO DE LA LISTA QUE DECLARA LA LISTA EN BLANCO ASI NO SE DESARMA SIEMPRE LA LISTA
class _Contact_ListState extends State<Contact_List> {
  final _formKey = GlobalKey<FormState>();
  final _nameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _telEditingController = TextEditingController();
  bool loading = true;
  List<Contact> contacts = [];
  @override
  void initState() {
    loading = true;
    _loadUser();
    super.initState();
  }

  Future<void> _loadUser() async {
    try {
      var url =
          "https://thelmaxd.000webhostapp.com/Agendapp/contactos.php?userID=" +
              widget.id;
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

  void _delete_user(
    id,
  ) async {
    var url =
        "https://thelmaxd.000webhostapp.com/Agendapp/contact_todelete.php?ID=" +
            contacts[id].id;
    Response response = await get(Uri.parse(url));
    List<Contact> _contacts = [];
    //aqui sacamos los datos y los metemos a un array
    var userResponse = json.decode(response.body);
    print(userResponse);
    _loadUser();
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
                  _delete_user(id);
                  Navigator.pop(context);
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

    //PARA ENVIAR EL DATO NUEVO
    void addContact(id) async {
      try {
        //https://thelmaxd.000webhostapp.com/Agendapp/add_contact.php?id=1&name=pedrito&email=borraro@gmail.com&tel=1234

        var url =
            "https://thelmaxd.000webhostapp.com/Agendapp/add_contact.php?id=" +
                id +
                "&name=" +
                _nameEditingController.text +
                "&email=" +
                _emailEditingController.text +
                "&tel=" +
                _telEditingController.text;
        Response response = await get(Uri.parse(url));
        List<Contact> _contacts = [];
        //aqui sacamos los datos y los metemos a un array
        var userResponse = json.decode(response.body);
        print(userResponse);
        setState(() {});
      } catch (e) {}
    }

//LA PARTE VISUAL DE LOS BOTONES DE NOMBRE Y ETC
//User field
    final nameField = TextFormField(
      autofocus: false,
      controller: _nameEditingController,
      keyboardType: TextInputType.name,
      //validator: (){},
      onSaved: (value) {
        _nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
//Email FIELD
    final emailField = TextFormField(
      autofocus: false,
      controller: _emailEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: (){},
      onSaved: (value) {
        _emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

//Telephone Field
    final teleField = TextFormField(
      autofocus: false,
      controller: _telEditingController,
      keyboardType: TextInputType.number,
      maxLength: 10,
      //validator: (){},
      onSaved: (value) {
        _telEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.phone),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Telephone",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //boton
    final addButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          addContact(widget.id);
          _nameEditingController.clear();
          _emailEditingController.clear();
          _telEditingController.clear();
          _loadUser();
        },
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

//PARA DESPLEGAR MENSAJITOS BONITOS , es un toast pues
    void _showToast(BuildContext context, mensaje) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text(mensaje),
        ),
      );
    }

//MODAL DESPLEGABLE CUANDO SE PRESIONA EL ENVIAR
    void _showModalAdd(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(400, 0, 400, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  nameField,
                  SizedBox(
                    height: 20,
                  ),
                  emailField,
                  SizedBox(
                    height: 20,
                  ),
                  teleField,
                  SizedBox(
                    height: 20,
                  ),
                  addButton,
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModalAdd(context),
        child: Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _loadUser,
        child: ListView.builder(
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
            itemCount: contacts.length),
      ),
    );
  }
}
