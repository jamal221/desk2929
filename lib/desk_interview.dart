import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
import 'footer_first.dart';
import 'CheckMobile.dart';
import 'package:desk2929/Show_Version.dart';
import 'CheckVersion.dart';
import 'registerPage.dart';
import 'links.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'header.dart';

//import package file manually
String msg = "درحال ارسال پبام...";
late String ver1Db, ver2DB, ver3DB;

class Desk_first_page extends StatelessWidget {
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
  late String msg, msgBtn, msg1;
  late String? DInter;
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
    msg =
        "این اپلیکشن کاملا مستقل و ارتباطی با اداره ندارد، هدف از ان ارائه خدمات به صورت غیر حضوری و دلخواه است، برای درخواست رمز باید عکس کارت ملی یا شناسنامه خود را ارسال نمایید. همچنین برای استفاده بهینه از این اپلیکشن باید موبایل خود را بدقت درج نمایید.";
    msg1 = "موفق باشید.";
    super.initState();
    getVersion();
    CheckInter();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      InternetConnectionCheck(context);
    });
  }

  Future<void> CheckInter() async {
    //phpurl = t.getaddress()+"MessagReg.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DInter = prefs.getString('DInterUser');
    //print (emailCooki);
    if (DInter != null) // To check cooki which seted in App
    {
      print(DInter);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => regUserkk()));

      setState(() {
        sending = true;
        error = false;
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      await prefs.setString('DInterUser', "jamal Azizbeigi");

      setState(() {
        sending = true;
        error = true;
      });
    }
  }

  Future<void> InternetConnectionCheck(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Connected
        Fluttertoast.showToast(
          msg: "تصویر با موفقیت ارسال شد.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Not Connected');
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
      print('Not connected');
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
                color: Color.fromARGB(255, 230, 230, 230),
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
                      child: Text(
                        "صفحه ی ورود اولیه",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                              color: Colors.white,
                              width: s.width * 0.7,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: s.width * 0.8,
                                    child: Text(msg + "" + msg1),
                                  ),
                                  Container(
                                    width: s.width * 0.7,
                                    padding:
                                        EdgeInsets.only(right: 100, top: 5),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .deepOrange, // Background color
                                        onPrimary: Colors.white, // Text color
                                      ),
                                      child: Text(
                                          "موارد بالا را خوانده و ورود به برنامه"),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  regUserkk()),
                                        );
                                      },
                                    ),
                                  ),
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
                    //width: s.width,
                    child: footerme2(),
                    //child:Image.asset('assets/images/Banner_desk.png', scale: 1,),
                  ),
                ]),
            height: 60.0,
            color: Colors.amberAccent,
          ),
        ));
  }

  void getVersion() async {
    final String apiEndpoint = t.getaddress() + "ShowVersion.php";
    final Uri uri = Uri.parse(apiEndpoint);
    //final String uri = t.getaddress()+"ShowVersion.php";
    //final Uri uri =Uri.http(t.getaddress(), 'ShowVersion.php');
    var response = await http.get(uri);
    //print("mobile for msg is  "+mobileCooki);
    if (response.statusCode == 200) {
      //String check1=json.decode(response.body);
      //print(check1);
      final items1 = json.decode(response.body);
      print("items1");
      print(items1[0]);
      setState(() {
        ver1Db = items1[0].toString();
        ver2DB = items1[1].toString();
        ver3DB = items1[2].toString();
      });
      setState(() {});
    } else {
      throw Exception('خطا در مشاهده ی اطلاعات');
    }
  }
}
