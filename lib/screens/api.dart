import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pracauthtodoapi/models/user_model.dart';
import 'package:pracauthtodoapi/screens/todo.dart';

class Api extends StatefulWidget {
  const Api({ Key? key }) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getuser()async{
  var users=[];
  var response =await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
  var jsonData = jsonDecode(response.body);
  for (var i in jsonData) {
    UserModel user = UserModel.fromJson(i);
    users.add(user);
  }
  return users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Api Data"),),
      backgroundColor: Colors.black,
      body: FutureBuilder(
      future: getuser(),
      builder: (context,AsyncSnapshot snapshot){
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator(color: Colors.pinkAccent,strokeWidth: 15,));
        }
        else{
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: ListTile(
                  tileColor: Color.fromARGB(255, 58, 3, 68),
                  textColor: Colors.yellowAccent,
                  title: Text(snapshot.data[index].username),
                  subtitle: Text(snapshot.data[index].company.name),
                  trailing: Text(snapshot.data[index].email),
                ),
              );
            });
        }
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Todo()),
  );
      },child: Text("Todo"),),
    );
  }
}