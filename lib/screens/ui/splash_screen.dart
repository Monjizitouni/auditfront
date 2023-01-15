// ignore_for_file: unnecessary_new

import 'dart:async';
import 'dart:convert';

import 'package:audit/screens/models/student.dart';
import 'package:audit/screens/services/classe_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  late Student student=Student(id: "", cin: "", firstName: "", lastName: "", email: "", photo: "profile.png", birthDate: "", classeName: "", classeId: "");
  late bool login=false;
  Future <void> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    final studentStr=prefs.getString("student");
    final islogin= prefs.getBool("isLogedIn");
    setState(() {
      login=islogin!;
      if (login==true){
        student=Student.fromJson(json.decode(studentStr!));
      }
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    startTime();
  }


  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if(login==true){
      Navigator.of(context).pushReplacementNamed("/StudentHome");
      
    }
    else{
      Navigator.of(context).pushReplacementNamed("/Welcom");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 200,left: 30,right: 30,top: 80),
            child: Image.asset(
              'assets/images/logoEsprit.png',
              //color: Colors.black,
            )
          )
        ],
      ),
    );
  }
}