import 'dart:convert';
import 'dart:developer';

import 'package:audit/home/etudiant/classes.dart';
import 'package:audit/screens/services/student_api.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final ImageProvider _imageProvider;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Client Sign-In',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                                controller: email,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains("@")) {
                                    return ("Entrer un E-mail valid!");
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: "E-mail", //babel text
                                  hintText: "Enter your email", //hint text
                                  prefixIcon: Icon(Icons.email_outlined,
                                      color: Colors.black), //prefix iocn
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black), //hint text style
                                  labelStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black), //label style
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                                controller: password,
                                style: const TextStyle(color: Colors.black),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return ("Entrer un Password!");
                                  }
                                },
                                decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.black),
                                  labelText: "Password",
                                  hintText: "Enter you password",
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  labelStyle: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                )),
                            const SizedBox(
                              height: 35,
                            ),
                            CustonButton(
                                texto: 'Sign In',
                                cor: Colors.white,
                                background: Color.fromARGB(255, 144, 70, 148),
                                onpressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    final response = await StudentApi()
                                        .studentLogin(
                                            email.text, password.text);
                                    if (response == "login success") {
                                      Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  classes(classe: 'Visite',)));
                                    } else {
                                      AlertDialog alert = const AlertDialog(
                                        title: Text("Login Failed!"),
                                        content:
                                            Text("Email or password is incorrect"),
                                      );

                                      // show the dialog
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return alert;
                                        },
                                      );

                                      log(response);
                                    }
                                  }
                                }),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "/Welcom");
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'You are not a Client ?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
