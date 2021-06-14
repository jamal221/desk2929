import 'package:desk2929/linkmali.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_view_link.dart';
import 'test123.dart';
import 'header.dart';
import 'package:desk2929/footer.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
class linkpage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "لیست لینک ها",
      debugShowCheckedModeBanner: false,
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
                    child: header(),
                  ),
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
                  Container(
                    //child: footerme(),
                  )
                ],
              ),

            ),
          bottomNavigationBar: new Container(
            //child: footerme(),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  // width: s.width/5,
                  child: Image.asset('assets/images/home.png'),
                ),
                Container(
                  //   width: s.width/5,
                  child: Image.asset('assets/images/user.png'),
                ),
                ]
              ),
          height: 60.0,
          color: Colors.red,
        ),
        )
    );
  }

  Widget formSetup(BuildContext context){
    var s=MediaQuery.of(context).size;
    final String maliUrl='https://www.desk2929.ir/mali';
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
                                       Navigator.push(context,
                                           MaterialPageRoute(builder: (context) => WebViewContainer('https://www.desk2929.ir/mali'))
                                       );
                                     },
                                     color: Colors.white,
                                     highlightColor: Colors.white,
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
                                child: new RaisedButton(
                                  child: Image.asset('assets/images/prs.png'),
                                  onPressed: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => WebViewContainer('https://www.desk2929.ir/persi'))
                                    );
                                  },
                                  color: Colors.white,
                                  highlightColor: Colors.white,
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
                                child: new RaisedButton(
                                  child: Image.asset('assets/images/stud.png'),
                                  onPressed: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => WebViewContainer('https://www.desk2929.ir/stud'))
                                    );
                                  },
                                  color: Colors.white,
                                  highlightColor: Colors.white,
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
                                child: new RaisedButton(
                                  child: Image.asset('assets/images/region.png'),
                                  onPressed: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => WebViewContainer('https://www.desk2929.ir/region'))
                                    );
                                  },
                                  color: Colors.white,
                                  highlightColor: Colors.white,
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