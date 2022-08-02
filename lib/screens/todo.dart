import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({ Key? key }) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List <dynamic> lst =["apple","orange","mango"];
  var output;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Todo App"),),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: lst.length,
        itemBuilder: (context,index){
          return Container(
            color: Color.fromARGB(255, 89, 4, 4),
            margin: EdgeInsets.only(top: 10),
            child: ListTile(
              title: Text("${lst[index]}"),
              textColor: Colors.yellowAccent,
              trailing: Container(
                width: 50,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Edit Items"),
              content: TextField(
                autofocus: true,
                onChanged: (value){
                    output = value;
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  setState(() {
                    lst.replaceRange(index, index, {output});
                  });
                }, child:Text("Edit Items"))
              ],
            );
          });
                        });
                      },
                      child: Icon(Icons.edit,color: Colors.blue,)),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          lst.removeAt(index);
                        });
                      },
                      child: Icon(Icons.delete,color: Colors.red,)),
                  ],
                ),
              ),
            ),
          );
        }),
        floatingActionButton: FloatingActionButton(onPressed: (){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              title: Text("Add Items"),
              content: TextField(
                autofocus: true,
                onChanged: (value){
                    output = value;
                },
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  setState(() {
                    lst.add(output);
                  });
                }, child:Text("Add Items"))
              ],
            );
          });
        } ,child: Text("Add")),
        
    );
  }
}