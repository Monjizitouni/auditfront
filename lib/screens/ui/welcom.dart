import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

import 'widgets/custon_button.dart';

class Welcom extends StatefulWidget {
  const Welcom({Key? key}) : super(key: key);

  @override
  State<Welcom> createState() => _WelcomState();
}

class _WelcomState extends State<Welcom> {

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
                      padding: const EdgeInsets.only(bottom: 400,left: 30,right: 30,top: 80),
                      child: Image.asset(
                        'assets/images/logoEsprit.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                        //color: Colors.black,
                        scale: 0.5,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            'Welcom to Esprit-KPI, please login!',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          CustonButton(
                            texto: 'Teacher',
                            cor: Colors.white,
                            background: const Color(0xFFcf171f),
                            onpressed: (){
                                Navigator.pushReplacementNamed(context, "/TeacherLogin");
                              }
                          ),

                          //Espaçador
                          const SizedBox(
                            height: 15,
                          ),
                          
                          CustonButton(
                              texto: 'Student',
                              cor: Colors.white,
                              background: const Color(0xFFcf171f),
                              onpressed: (){
                                Navigator.pushReplacementNamed(context, "/StudentLogin");
                              }
                              
                          ),
                          // Espaçador
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Trouble logging in? \n Contact school administration.',
                            style: TextStyle(
                              color: Colors.black, 
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
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