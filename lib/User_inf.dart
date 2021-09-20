import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'footer.dart';

import 'header.dart';
//import package file manually
String msg="درحال ارسال پبام...";
class UserInf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch:Colors.blue, //primary color for theme
        ),
        home: UserInfData()
      //set the class here
    );
  }
}

class UserInfData extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<UserInfData> {

  TextEditingController msgctl = TextEditingController();

  //text controller for TextField

  bool error, sending, success;
  String msg, msgBtn, mobilecooki;
  test123 t=new test123();
  String phpurl;
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
    CheckUser();
  }
  Future<void> CheckUser() async {
    //phpurl = t.getaddress()+"MessagReg.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobilecooki= prefs.getString('mobile99');
    //print (emailCooki);
    if (mobilecooki!= null)// To check cooki which seted in App
        {
          msg="شما از طریق موبایل"+mobilecooki+ "واردسیستم شده اید";

          Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          setState(() {
            sending=true;
            error= false;
          });
        }
    else
      {
        msg="شما هنوز در سیستم ثبت نام نکرده اید";

        Toast.show(msg, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        setState(() {
          sending=true;
          error= true;
        });
      }


  }

  @override
  Widget build(BuildContext context) {
    s=MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,

        child: Scaffold(
          //appbar
            body: SingleChildScrollView( //enable scrolling, when keyboard appears,
              // hight becomes small, so prevent overflow
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    SizedBox(height: 30
                      ,),
                    Container(
                        //height: 100,
                        //color: Color.fromARGB(255, 230, 230, 230),
                      color: Colors.white,
                        child: header()
                    ),
                    Container(
                      height: s.height-110,
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
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text("اطلاعات کاربر",style: TextStyle(color: Colors.white,fontSize: 22.0,fontWeight: FontWeight.bold),),
                          ),

                          Divider(color: Colors.white,),
                          SizedBox(height: 20),
                          Container(
                            child: Column(

                              children: <Widget>[

                                Container(
                                    color: Colors.white,
                                    width: s.width*0.7,
                                    padding: EdgeInsets.all(20),
                                    child: Column(children: <Widget>[
                                      SizedBox(height: 10),


                                      Container(
                                          margin: EdgeInsets.only(top: 20),
                                          width: s.width*0.8,
                                          child: Text(msg),
                                      )

                                    ],
                                    )
                                )
                              ],
                            ),
                          ),




                        ],
                      ),
                    ),

                  ]
              ),
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
                ]
            ),
            height: 60.0,
            color: Colors.red,
          ),
        )
    );
  }
}