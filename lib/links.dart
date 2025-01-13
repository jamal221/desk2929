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
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

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

String msg = "";
test123 t = new test123();

class linkdeskState extends State<linkdesk> {
  void initState() {
    // TODO: implement initState
    super.initState();
    //BackButtonInterceptor.add(myInterceptor);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InternetConnectionCheck(context);
    });
  }

  Future<void> InternetConnectionCheck(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Connected
        Fluttertoast.showToast(
          msg: "ارتباط برقرار است.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('not Connected');
        Fluttertoast.showToast(
          msg: "اتصال به اینترنت مشکل دارد.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } on SocketException catch (_) {
      print('not connected');
      Fluttertoast.showToast(
        msg: "اتصال به اینترنت مشکل دارد.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    InternetConnectionCheck(context);
    var s = MediaQuery.of(context).size;
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  child: header(),
                  color: Colors.white,
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    height: s.height - 100,
                    width: s.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              ExactAssetImage("assets/images/ic_launcher.png"),
                          fit: BoxFit.contain),
                      /*gradient: LinearGradient(
                          begin: Alignment.center,
                          end:
                          Alignment.centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color.fromARGB(255, 39, 206, 137),
                            Color.fromARGB(255, 28, 30, 79)
                          ], // red to yellow
                          tileMode: TileMode.mirror, // repeats the gradient over the canvas
                        ),*/
                    ),
                    //padding: const EdgeInsets.all(20.0),
                    child: formSetup(context)),
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
                    width: s.width,
                    child: footerme(),
                  ),
                ]),
            height: 60.0,
            color: Colors.amberAccent,
          ),
        ));
  }

  Widget formSetup(BuildContext context) {
    var s = MediaQuery.of(context).size;
    final String maliUrl = 'https://www.desk2929.ir/mali';
    return new Form(
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5, top: 10),
            width: s.width * .95,
            height: 60,
            //child: Text("میز خدمت آموزش و پرورش بوکان"),
            decoration: BoxDecoration(
                //border: Radius.circular(10),
                image: DecorationImage(
              image: AssetImage('assets/images/Banner_desk.png'),
              fit: BoxFit.fill,
            )),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              child: Row(children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10, top: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  color: Colors.white24,
                  elevation: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 5),
                        width: (s.width * 0.9) / 2,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink, // Background color
                            onPrimary:
                                Colors.white, // Text color when highlighted
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          child: Image.asset('assets/images/mali.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewContainer(
                                    'https://www.desk2929.ir/mali'),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.only(right: 5, top: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  color: Colors.white24,
                  elevation: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 5),
                        width: (s.width * 0.9) / 2,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink, // Background color
                            onPrimary:
                                Colors.white, // Text color when highlighted
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          child: Image.asset('assets/images/prs.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewContainer(
                                    'https://www.desk2929.ir/persi'),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
          ])),
          SizedBox(
            height: 5,
          ),
          Container(
              child: Row(children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10, top: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  color: Colors.white24,
                  elevation: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 5),
                        width: (s.width * 0.9) / 2,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink, // Background color
                            onPrimary:
                                Colors.white, // Text color when highlighted
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          child: Image.asset('assets/images/stud.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewContainer(
                                    'https://www.desk2929.ir/stud'),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
            Container(
                padding: EdgeInsets.only(right: 5, top: 5),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  color: Colors.white24,
                  elevation: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 5),
                        width: (s.width * 0.9) / 2,
                        height: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink, // Background color
                            onPrimary:
                                Colors.white, // Text color when highlighted
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                          child: Image.asset('assets/images/region.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewContainer(
                                    'https://www.desk2929.ir/region'),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )),
          ])),
        ],
      ),
    );
  }
}
