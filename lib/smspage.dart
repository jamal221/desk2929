import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'header.dart';
import 'test123.dart';
import 'links.dart';
import 'footer_first.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'registerPage.dart';
//import 'shenasname.dart';



String mob, name_user;
int recived_code;

test123 t=new test123();
String url = t.getaddress()+"CheckHash.php";
TextEditingController sendedcode = TextEditingController();
class sms extends StatelessWidget {
  sms(String x, String name) {
    mob=x;
    name_user=name;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sms1(),
    );
  }
}
class sms1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SmSPageState();
  }
}
class SmSPageState extends State <sms1> {
  // receive data from the FirstScreen as a parameter
  //SmSPageState(String x){ mob=x;}

  @override
  //_MyAppsmsState createState() => _MyAppsmsState();
  void initState() {
    // TODO: implement initState
    sendmsg();
    //codesms="321";
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //print("BACK BUTTON!"); // Do some stuff.
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => regUserkk()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery
        .of(context)
        .size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

          //backgroundColor: Colors.white,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container(
                    color: Color.fromARGB(255, 230, 230, 230),
                    //child: header(),
                    child: Image.asset(
                      'assets/images/Banner_desk.png', scale: 1,),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: s.height,
                      width: s.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end:
                          Alignment.centerRight,
                          // 10% of the width, so there are ten blinds.
                          colors: <Color>[

                            Color.fromARGB(255, 39, 206, 137),
                            Color.fromARGB(255, 28, 30, 79)
                          ],
                          // red to yellow
                          tileMode: TileMode
                              .mirror, // repeats the gradient over the canvas
                        ),
                      ),
                      child: Column(
                          children: [
                            Container(
                              width: s.width * 0.9,
                              height: s.height * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 230, 230, 230),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),

                              ),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 30,),
                                  Container(
                                    child: Text(
                                      "کد پیامک شده را در کادر زیر درج نمایید:  ",),
                                  ),
                                  Container(
                                    child: Text(
                                      "کیبورد در حالت انگلیسی باشد:  ",),
                                  ),
                                  /*Container(
                                    child:Text(recived_code.toRadixString(16), style: const
                                      TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 50,
                                      color: Colors.purple
                                    ),),
                                  ),*/

                                  SizedBox(height: 10,),

                                  Container(
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[

                                            Container(
                                              width: s.width * 0.8,
                                              padding: EdgeInsets.only(
                                                  right: 5, top: 5),
                                              child: new TextFormField(
                                                controller: sendedcode,
                                                keyboardType: TextInputType
                                                    .text,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'کد پیامک شده 6 رقمی:',
                                                    hintText: 'کد بالا'),
                                              ),
                                            ),

                                          ]
                                      )
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60.0),
                                    child: Center(
                                      /*child: Container(
                                          width: 200,
                                          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                                          child: Image.asset('assets/images/logo.png')
                                      ),*/
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    child: GestureDetector(
                                      onTap: () async {
                                        //print(codesms+"--"+sendedcode.text.toString());
                                        if (codesms ==
                                            sendedcode.text.toString()) {
                                          String phpurl = t.getaddress() +
                                              "UserReg.php";
                                          //Uri phpurl =Uri.http(t.getaddress(), 'UserReg.php');
                                          var res = await http.post(
                                              phpurl, body: {
                                            "name": name_user,
                                            "mobile": mob,
                                          });
                                          if (res.statusCode == 200) {
                                            //print(data);
                                            var data = json.decode(res.body);
                                            //int x=int.parse(data.toString());
                                            //print(data.runtimeType);
                                            print(data);
                                            if (data == 123) {
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              //Return String
                                              await prefs.setString('mobile99', mob);
                                              await prefs.setString('name_user_app', name_user);
                                              Toast.show(
                                                  "درج اطلاعات با موفقیت انجام شد، تا چند ثانیه ی دیگر به صفحه ی اصلی هدایت می شید.",
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          linkpage()));
                                              //await Future.delayed(const Duration(seconds: 10), (){});

                                              /*setState(() {
                                                // Create a cooki variable with the name of mobile99
                                                Navigator.push(context, MaterialPageRoute(builder: (_) => linkpage()));
                                                msg="mobarak";
                                                // Navigator.push(context, MaterialPageRoute(builder: (_) => shenasnameh()));
                                              });*/
                                            }
                                            else if (data == 789) {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      content: Text(
                                                          "شماره ثبت شده تکراری می باشد، برای تایید به شماره 09143805648 نام و نام خانوادگی خود را پیامک نمایید تا تایید و بعد از دریافت پیامک دوباره ثبت و وارد سیستم شوید."),
                                                      title: Text(
                                                          'هشدار: قبلا این شماره در سیستم ثبت شده است.'),
                                                      actions: [
                                                        FlatButton(
                                                          //onPressed: () =>Navigator.of(context).pop(false), // passing false
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                  context,
                                                                  rootNavigator: true)
                                                                  .pop(context),
                                                          child: Text(
                                                              'متوجه شدم.'),
                                                        ),

                                                      ],
                                                    );
                                                  }
                                              ).then(
                                                      (exit) {
                                                    if (exit == null) return;

                                                    if (exit) {
                                                      //exit(0);// user pass yes button
                                                      //Navigator.pop(context,'OK');
                                                      //SystemNavigator.pop();
                                                    }
                                                    else {
                                                      // user pressed No button
                                                      //Navigator.of(context).pop(false);
                                                      Navigator.of(context,
                                                          rootNavigator: true)
                                                          .pop(context);
                                                    }
                                                  }
                                              );
                                            }
                                            else {
                                              Toast.show(
                                                  "در فرایند درج خطای رخ داده است، یکبار دیگر سعی یا با مدیر سیستم تماس بگیرید.",
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                            }
                                          }
                                        }
                                        else {
                                          Toast.show(
                                              "عدم تطابق، یکبار دیگر سعی نمایید.",
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                        }
                                        // Navigator.push(context, MaterialPageRoute(builder: (_) => MainMenu1()));
                                      },
                                      child: Center(
                                        child: Text(
                                          'ورود',
                                          style: TextStyle(color: Colors.white,
                                              fontSize: 25),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                      )
                  ),


                ],
              ),
            ),
          ),
          bottomNavigationBar: new Container(
            //child: footerme(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    // width: s.width/5,
                    child: footerme2(),

                  ),
                  Container(
                    // width: s.width/5,
                    //child: Image.asset('assets/images/home.png'),
                  ),
                  Container(
                    //   width: s.width/5,
                    //child: Image.asset('assets/images/user.png'),
                  ),
                ]
            ),
            height: 60.0,
            color: Colors.purple,
          ),
        )
    );
  }

  String codesms;

  /* String phpurl2 = "http://127.0.0.1:8000/sms/JamalSMS";
  Future<void> sendmsg() async {
    print("mob"+mob);

    //var res = await http.get(url+"?mob="+mob); //sending post request with header data
    var res = await http.post(phpurl2, body: {
      "mobile":mob,
    });
    print("code:"+res.body); //print raw response on console
    var code = json.decode(res.body); //decoding json to array
    print(code);
    codesms = code.toString();
  }*/
  Future<void> sendmsg() async {
    print("mob" + mob);
    var res = await http.get("http://desk2929.ir/smssss" + "?mobile_user=" +mob); //sending post request with header data

    if (res.statusCode == 200) {
      print("code:" + res.body); //print raw response on console
      var code = json.decode(res.body); //decoding json to array
      print(code);
      codesms = code.toString();
    }
  }
}
