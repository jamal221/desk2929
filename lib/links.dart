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
    var s=MediaQuery.of(context).size;
    return new Form(
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5,top:10),
            width: s.width*.95,
            height: 60,
            //child: Text("میز خدمت آموزش و پرورش بوکان"),
            decoration: BoxDecoration(
              //border: Radius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/Banner_desk.png'),
                  fit: BoxFit.fill,
                )
            ),
          ),
          SizedBox(height: 5,),
          Container(
              child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 10,top:5),
                      child: Card
                        (
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             children: <Widget>[
                               Container(
                                 padding: EdgeInsets.only(right: 20,top:5),
                                 width: (s.width*0.9)/2,
                                 height: 150,
                                 
                                 child: new RaisedButton(
                                     child: Image.asset('assets/images/mali.png'),
                                     onPressed: (){

                                     },
                                     color: Colors.white,
                                     highlightColor: Colors.white,
                                 ),
                                 decoration: BoxDecoration(
                                   //border: Radius.circular(10),
                                     image: DecorationImage(
                                       image: AssetImage('assets/images/mali.png'),
                                       fit: BoxFit.fill,
                                     )
                                 ),
                               )
                             ],
                           ),
                      )
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5,top:5),
                        child: Card
                          (
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 20,top:5),
                                width: (s.width*0.9)/2,
                                height: 150,
                                decoration: BoxDecoration(
                                  //border: Radius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/prs.png'),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  ]
              )
          ),
          SizedBox(height: 5,),
          Container(
              child: Row(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(right: 10,top:5),
                        child: Card
                          (
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 20,top:5),
                                width: (s.width*0.9)/2,
                                height: 150,
                                decoration: BoxDecoration(
                                  //border: Radius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/stud.png'),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 5,top:5),
                        child: Card
                          (
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 20,top:5),
                                width: (s.width*0.9)/2,
                                height: 150,
                                decoration: BoxDecoration(
                                  //border: Radius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/region.png'),
                                      fit: BoxFit.fill,
                                    )
                                ),
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