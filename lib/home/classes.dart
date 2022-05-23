import 'dart:convert';

import 'package:esprit_kpi/home/absance/absance.dart';

import 'package:esprit_kpi/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class classes extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<classes> {
  List<Map<String, dynamic>> emploilist = [];
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  static String classe = '';
  List<Widget> itemsData = [];
  @override
  void initState() {
    super.initState();
    // print(classe);
    // if (classe == '') {
    //   if (emploilist.isEmpty) {
    //     emploilist = [];
    //   }
    // } else {
    //   emploilist = [];
    //   var url = Uri.parse(
    //       "http://192.168.1.8:4000/emploi/getprofclasse/62406adba98b5349f488d039/62405f921f9afe1ec40c5ff7");
    //   http.get((url), headers: {"content-type": "application/json"}).then(
    //       (http.Response response) {
    //     //print("hello"+response.body.toString());
    //     // = json.decode(response.body);
    //     ////ligne la plus importante!!!!!!!!
    //     print((Utf8Codec().decode(response.bodyBytes)).toString());
    //     List<dynamic> l = json.decode(Utf8Codec().decode(response.bodyBytes));

    //     //  List<dynamic> l = map['joblist'];
    //     for (int i = 0; i < l.length; i++) {
    //       // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
    //       Map<String, dynamic> free = new Map<String, dynamic>();
    //       free["nommatiere"] = l[i]["NomMatiere"]["NameM"];
    //       free["Classe"] = l[i]["classe"]["name"];
    //       free["Datec"] = l[i]["date"];

    //       emploilist.add(free);
    //       print(free.toString());
    //     }
    //   });
    // }
  }

  Future getemploi() async {
    var url = Uri.parse(
        "http://192.168.1.5:4000/emploi/getprofclasse/62406adba98b5349f488d039/62405f921f9afe1ec40c5ff7");
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
        Map<String, dynamic> free = new Map<String, dynamic>();
        free["nommatiere"] = l[i]["NomMatiere"]["NameM"];
        free["Classe"] = l[i]["classe"]["name"];
        free["Datec"] = l[i]["date"];

        emploilist.add(free);
        print("/////////////////////////////////////////////////////");
        print(emploilist.length);
        print(free.toString());
      }
    });
  }

  void getPostsData() {
    print("classe selectionnee: " + classe);
    List<dynamic> responseList = emploilist;
    print('list size: ' + responseList.length.toString());
    List<Widget> listItems = [];
    emploilist.forEach((post) {
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
                      post["nommatiere"],
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post["Classe"],
                      style: const TextStyle(fontSize: 17, color: Colors.blue),
                    ),
                    Text(
                      post["Datec"],
                      style: const TextStyle(fontSize: 17, color: Colors.blue),
                    )
                  ],
                ),
              ],
            ),
          )));
      // if (itemsData != listItems) {
      //   setState(() {
      itemsData = listItems;
      // });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (classe != '') {
      emploilist = [];
      //   var url = Uri.parse(
      //       "http://192.168.1.5:4000/emploi/getprofclasse/62406adba98b5349f488d039/62405f921f9afe1ec40c5ff7");
      //   http.get((url), headers: {"content-type": "application/json"}).then(
      //       (http.Response response) {
      //     //print("hello"+response.body.toString());
      //     // = json.decode(response.body);
      //     ////ligne la plus importante!!!!!!!!
      //     print((Utf8Codec().decode(response.bodyBytes)).toString());
      //     List<dynamic> l = json.decode(Utf8Codec().decode(response.bodyBytes));

      //     //  List<dynamic> l = map['joblist'];
      //     for (int i = 0; i < l.length; i++) {
      //       // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
      //       Map<String, dynamic> free = new Map<String, dynamic>();
      //       free["nommatiere"] = l[i]["NomMatiere"]["NameM"];
      //       free["Classe"] = l[i]["classe"]["name"];
      //       free["Datec"] = l[i]["date"];

      //       emploilist.add(free);
      //       print("/////////////////////////////////////////////////////");
      //       print(emploilist.length);
      //       print(free.toString());
      //     }
      //     getPostsData(emploilist);
      //   });
    }
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          title: Image.asset('assets/images/logogg.png', fit: BoxFit.contain),
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
                      child: Text('Absence'),
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
          height: size.height,
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
                    "Classes",
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
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer ? 0 : categoryHeight,
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
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.purple),
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
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => classes()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => absance()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => notes(
                    classe: '',
                  )),
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
    classelist = [];
    var url = Uri.parse(
        "http://192.168.1.5:4000/emploi/getprof/62406adba98b5349f488d039");
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
        Map<String, dynamic> free = l[i]["classe"];
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
                                            classelist[index]['niveau']
                                                    .toString() +
                                                "" +
                                                classelist[index]['branche']
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            classelist[index]['nbEtudiant']
                                                    .toString() +
                                                " Etudiants",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    )),
                                onTap: () {
                                  _MyHomePageState.classe =
                                      classelist[index]['id'];
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => classes()));
                                });
                          }))
                ],
              ),
            ),
          ),
        ));
  }
}
