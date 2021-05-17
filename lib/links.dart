import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'test123.dart';


class linkpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "لیست لینک ها",
      home: linkdesk(),
    );
  }
}

class linkdesk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return linkdeskState();
  }
}
String msg="";
test123 t=new test123();
class linkdeskState extends State <linkdesk> {
  @override
  Widget build(BuildContext context) {
    var s=MediaQuery.of(context).size;
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: s.height,
                      width: s.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end:
                          Alignment.centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[

                            Color.fromARGB(255, 39, 206, 137),
                            Color.fromARGB(255, 28, 30, 79)
                          ], // red to yellow
                          tileMode: TileMode.mirror, // repeats the gradient over the canvas
                        ),
                      ),
                      //padding: const EdgeInsets.all(20.0),
                      child: formSetup(context)
                  ),


                ],
              ),
            )
        )
    );
  }

  Widget formSetup(BuildContext context){
    return new Form(
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20,top:10),
            width: 200,
            height: 80,
            child: Text("میز خدمت آموزش و پرورش بوکان"),
            decoration: BoxDecoration(
              //border: Radius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/Dokme.png'),
                  fit: BoxFit.fill,
                )
            ),
          ),
          SizedBox(height: 5,),
          Container(
              child: Row(
                  children: <Widget>[
                    Container(

                      padding: EdgeInsets.only(right: 20,top:5),
                      child: Card
                        (
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Container(
                                 width: 300,
                                 child: Text("links1"),
                               )
                             ],
                           ),
                      )
                    ),
                    Container(
                        child: Card
                          (
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Text("links2"),
                              )
                            ],
                          ),
                        )
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}