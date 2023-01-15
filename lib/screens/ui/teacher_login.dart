import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    email.text = ""; //innitail value of text field
    password.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ImageProvider _imageProvider;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                            'Teacher Sign-In',
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

                          TextField( 
                            controller: email,
                            decoration: const InputDecoration( 
                                labelText: "E-mail", //babel text
                                hintText: "Enter your email", //hint text
                                prefixIcon: Icon(Icons.email_outlined, color: Colors.black), //prefix iocn
                                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black), //hint text style
                                labelStyle: TextStyle(fontSize: 13, color: Colors.black), //label style
                            )
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          TextField( 
                            controller: password,
                            style: const TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: const InputDecoration( 
                                prefixIcon: Icon(Icons.lock, color: Colors.black),
                                labelText: "Password",
                                hintText: "Enter you password",
                                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black),
                                labelStyle: TextStyle(fontSize: 13, color: Colors.black),
                            )
                          ),
                          const SizedBox(
                            height: 35,
                          ),

                          const CustonButton(
                            texto: 'Sign In',
                            cor: Colors.white,
                            background: Color(0xFFcf171f),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          
                           InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/Welcom");
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                  'You are not a Teacher ?',
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
    );
  }
}