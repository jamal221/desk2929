import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'footer.dart';
import 'CheckMobile.dart';
import 'package:desk2929/Show_Version.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'links.dart';
import 'dart:io';
import 'package:desk2929/CheckVersion.dart';

import 'header.dart';

late String msg_connection_error;
late int ConnectionFlag;

class ConnAlarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue, //primary color for theme
        ),
        home: ConnAlarmData()
        //set the class here
        );
  }
}

class ConnAlarmData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<ConnAlarmData> {
  var s;
  @override
  void initState() {
    InternetConnectionCheck();
    ConnectionFlag = 0;
    msg_connection_error =
        "ارتباط اینترنت شما قطع می باشد لطفا مورد را بررسی نمایید";
    super.initState();
  }

  Future<void> InternetConnectionCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        //Toast.show("ارتباط برقرار است.", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        setState(() {
          ConnectionFlag = 0;
        });
      } else {
        print('not Connected');
        //Toast.show("اتصال به اینترنت مشکل دارد. ", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        setState(() {
          ConnectionFlag = 1;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  @override
  Widget build(BuildContext context) {
    s = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          //appbar
          body: SingleChildScrollView(
            //enable scrolling, when keyboard appears,
            // hight becomes small, so prevent overflow
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                color: Colors.white,
                //child: header()
                child: Image.asset(
                  'assets/images/Banner_desk.png',
                  scale: 1,
                ),
              ),
              Container(
                height: s.height - 110,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment
                        .centerRight, // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color.fromARGB(255, 39, 206, 137),
                      Color.fromARGB(255, 28, 30, 79)
                    ], // red to yellow
                    tileMode:
                        TileMode.mirror, // repeats the gradient over the canvas
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: ConnectionFlag == 1
                          ? Text(
                              msg_connection_error,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : CheckVersionApp(),
                    ),
                    Divider(color: Colors.white),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ]),
          ),
          bottomNavigationBar: new Container(
            //child: footerme(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    //width: s.width,
                    child: footerme(),
                  ),
                ]),
            height: 60.0,
            color: Colors.amberAccent,
          ),
        ));
  }
}
