import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'footer.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'links.dart';
import 'dart:io';
import 'header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:call_with_whatsapp/call_with_whatsapp.dart';
String msg = "درحال ارسال پبام...";

class UserInf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue, //primary color for theme
        ),
        home: UserInfData()
        //set the class here
        );
  }
}

class UserInfData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<UserInfData> {
  TextEditingController msgctl = TextEditingController();

  //text controller for TextField

  late bool error, sending, success;
  late String msg, msg1, msgBtn, DInter;
  late String mobilecooki;
  late test123 t = new test123();
  late String phpurl;
  var s;
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or  "ip a" on Linux to get IP Address

  @override
  void initState() {
    error = true;
    sending = false;
    success = false;
    msg = "";
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    CheckUser();
    InternetConnectionCheck();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //print("BACK BUTTON!"); // Do some stuff.
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => linkpage()));
    return true;
  }

  Future<void> CheckUser() async {
    //phpurl = t.getaddress()+"MessagReg.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobilecooki = prefs.getString('mobile99') ?? '';
    DInter = prefs.getString('name_user_app') ?? '';
    //print (emailCooki);
    if (mobilecooki != null) // To check cooki which seted in App
    {
      if (DInter != null) {
        msg1 = "کاربر گرامی :   " + DInter;
      } else {
        msg1 =
            "کاربر گرامی امید وارم این اپلیکشن برای شما مفید باشد، در صورتی که نظر یا ایده ای دارید از طریق پیام رسان داخل اپلیکشن ارسال نمایید.";
      }

      msg = "شما از طریق موبایل" + mobilecooki + "واردسیستم شده اید";

      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        sending = true;
        error = false;
      });
    } else {
      msg = "شما هنوز در سیستم ثبت نام نکرده اید";

      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        sending = true;
        error = true;
      });
    }
  }

  Future<void> InternetConnectionCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //print('connected');
        Fluttertoast.showToast(
            msg: "ارتباط برقرار است.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);

      } else {
        print('not Connected');
        Fluttertoast.showToast(
            msg: "اتصال به اینترنت مشکل دارد.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  _launchURL(String phone) async {
    String url;
    url = 'https://wa.me/' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    InternetConnectionCheck();
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
                height: 30,
              ),
              Container(
                  //height: 100,
                  //color: Color.fromARGB(255, 230, 230, 230),
                  color: Colors.white,
                  child: header()),
              Container(
                height: s.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage("assets/images/ic_launcher.png"),
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
                child: Column(
                  children: <Widget>[
                    /*Center(
                            child: Text("اطلاعات کاربر",style: TextStyle(color: Colors.black87,fontSize: 22.0,fontWeight: FontWeight.bold),),
                          ),*/

                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(height: 1),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              color: Colors.transparent,
                              width: s.width * 0.7,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Container(
                                    color: Colors.transparent,
                                    //margin: EdgeInsets.(top: 20),
                                    width: s.width * 0.8,
                                    child: Text(
                                      msg1,
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.transparent,
                                    //margin: EdgeInsets.only(top: 20),
                                    width: s.width * 0.8,
                                    child: Text(
                                      msg,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              )),
                          Container(
                              child: Row(
                            children: [
                              GestureDetector(
                                  // onTap: (){
                                  //   Navigator.push(context, MaterialPageRoute(builder: (_) => linkpage()));
                                  // },
                                  onTap: () => launch("tel://09143805648"),
                                  child: Column(children: [
                                    Container(
                                      width: s.width / 2,
                                      child: Image.asset(
                                        'assets/images/Calling-PNG-HD.png',
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      'تماس از طریق سیم کارت',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                          fontFamily: "Vazir"),
                                    ))
                                  ])),
                              GestureDetector(
                                  // onTap: (){
                                  //   Navigator.push(context, MaterialPageRoute(builder: (_) => linkpage()));
                                  // },
                                  onTap: () =>
                                      launch('https://wa.me/+989143805648'),
                                  child: Column(children: [
                                    Container(
                                      width: s.width / 2,
                                      child: Image.asset(
                                        'assets/images/Call_Internet.png',
                                        width: 110,
                                        height: 110,
                                      ),
                                    ),
                                    Container(
                                        child: Text(
                                      'تماس اینترنتی',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontFamily: "Vazir"),
                                    ))
                                  ])),
                            ],
                          ))
                        ],
                      ),
                    ),
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
                    // width: s.width/5,
                    child: footerme(),
                  ),
                  Container(
                      // width: s.width/5,
                      //child: Image.asset('assets/images/home.png'),
                      ),
                  Container(
                      //   width: s.width/5,
                      //child: Image.asset('assets/images/user.png'),
                      ),
                ]),
            height: 60.0,
            color: Colors.amberAccent,
          ),
        ));
  }
}
