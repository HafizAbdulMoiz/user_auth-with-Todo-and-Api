import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pracauthtodoapi/screens/login.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  register()async{
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
    final UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    await db.collection("users").doc(user.user?.uid).set({
      "username" : username,
      "email" : email
    });
    print("User Registered");   
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
  );
    } catch (e) {
      print("Error");
    }
   
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.account_circle_rounded),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                ),
              ),
            ),
            ElevatedButton(onPressed: register, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}