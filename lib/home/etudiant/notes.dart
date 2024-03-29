import 'dart:convert';

import 'package:audit/home/etudiant/notes.dart';
import 'package:audit/home/etudiant/absance.dart';
import 'package:audit/home/etudiant/classes.dart';
import 'package:audit/main.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class notes extends StatefulWidget {
  final Map<String, dynamic> classe;
  notes({Key? key, required this.classe}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<notes> {
  List<Map<String, dynamic>> listetudiant = [];
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  static String classe1 = '';
  static String matiere = '';
  List<dynamic> grades = [];
  List<dynamic> responseList = [];
  List<Widget> itemsData = [];

  void getPostsData() {
    // List<TextEditingController> _controllers = [];
    //_controllers.length = FOOD_DATA.length;
    responseList = listetudiant;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["Grades"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    Text(
                      post["matiere"]["ECTs"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  height: 45,
                  width: 70,
                ),
              ],
            ),
          )));
    });

    itemsData = listItems;
  }

  Future getemploi() async {
    listetudiant = [];
    print(widget.classe["idmatiere"]);
    final Map<String, String> _headers = {
      "Content-Type": "application/json",
    };
    var url = Uri.parse(
        "http://192.168.1.7:4000/note/getnote/6240610c4f695148a8a6a4d7/" +
            "627047e25bab7a42c0aa7297");
    http.get((url), headers: {"content-type": "application/json"}).then(
        (http.Response response) {
      var decoded = json.decode(response.body);
      print(decoded);
      print(response.statusCode);
      print("hello" + response.body.toString());
      // = json.decode(response.body);
      ////ligne la plus importante!!!!!!!!
      print((Utf8Codec().decode(response.bodyBytes)).toString());
      List<dynamic> l = json.decode(Utf8Codec().decode(response.bodyBytes));

      //  List<dynamic> l = map['joblist'];
      for (int i = 0; i < l.length; i++) {
        // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
        Map<String, dynamic> free = new Map<String, dynamic>();
        free["id"] = l[i]["id"];
        free["Grades"] = l[i]["Grades"];
        free["matiere"] = l[i]["matiere"];
        listetudiant.add(free);
        print("/////////////////////////////////////////////////////");
        print(listetudiant.length);
        print(free.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //classe1 = widget.classe;
    // final Size size = MediaQuery.of(context).size;
    // final double categoryHeight = size.height * 0.30;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
       //   title: Image.asset('assets/images/logogg.png', fit: BoxFit.contain),
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: PopupMenuButton<int>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 0,
                      child: Text('Classes'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('Absance'),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text('Notes'),
                    )
                  ]),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          // height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "Notes",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    // width: size.width,
                    // alignment: Alignment.topCenter,
                    // height: closeTopContainer ? 0 : categoryHeight,
                    child: categoriesScroller),
              ),
              Expanded(
                child: FutureBuilder(
                    future: getemploi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        getPostsData();
                        return ListView.builder(
                            controller: controller,
                            itemCount: itemsData.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              double scale = 1.0;
                              if (topContainer > 0.5) {
                                scale = index + 0.5 - topContainer;
                                if (scale < 0) {
                                  scale = 0;
                                } else if (scale > 1) {
                                  scale = 1;
                                }
                              }
                              return Opacity(
                                opacity: scale,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..scale(scale, scale),
                                  alignment: Alignment.bottomCenter,
                                  child: Align(
                                      heightFactor: 0.7,
                                      alignment: Alignment.topCenter,
                                      child: itemsData[index]),
                                ),
                              );
                            });
                      } else {
                        return Container(
                            alignment: Alignment.topCenter,
                            margin: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(
                              value: 0.8,
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                            ));
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //       builder: (context) =>
        //           classes(classe: new Map<String, dynamic>())),
        // );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => absance()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => notes(classe: new Map<String, dynamic>())),
        );
        break;
    }
  }
}

class CategoriesScroller extends StatefulWidget {
  // ignore: use_key_in_widget_constructors

  @override
  _CategoriesScrollerState createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {
  List<Map<String, dynamic>> classelist = [];
  @override
  void initState() {
    var classe = "62405f921f9afe1ec40c5ff7";

    classelist = [];
    var url =
        Uri.parse("http://192.168.1.7:4000/matiere/getbyclasse/" + classe);
    http.get((url), headers: {"content-type": "application/json"}).then(
        (http.Response response) {
      //print("hello"+response.body.toString());
      // = json.decode(response.body);
      ////ligne la plus importante!!!!!!!!
      print((Utf8Codec().decode(response.bodyBytes)).toString());
      List<dynamic> l = json.decode(Utf8Codec().decode(response.bodyBytes));

      //  List<dynamic> l = map['joblist'];
      for (int i = 0; i < l.length; i++) {
        // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
        Map<String, dynamic> free = Map<String, dynamic>();
        free["classe"] = l[i]["classe"];
        free["matiere"] = l[i]["NameM"];
        free["idmatiere"] = l[i]["id"];
        classelist.add(free);
        print(free.toString());
        //myjobs.add(m);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use

    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;

    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 100,
              width: 350,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: classelist.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                child: Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 20),
                                    height: categoryHeight,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            classelist[index]['matiere']
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )),
                                onTap: () {
                                  _MyHomePageState.classe1 =
                                      classelist[index]['classe'];
                                  _MyHomePageState.matiere =
                                      classelist[index]['idmatiere'].toString();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => new notes(
                                          classe: classelist[index])));
                                });
                          }))
                ],
              ),
            ),
          ),
        ));
  }
}
