import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'links.dart';
import 'registerPage.dart';

import 'header.dart';
//import package file manually
String msg="درحال ارسال پبام...";
class CheckMobileUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch:Colors.blue, //primary color for theme
        ),
        home: WriteSQLdata()
      //set the class here
    );
  }
}

class WriteSQLdata extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<WriteSQLdata> {

  TextEditingController msgctl = TextEditingController();

  //text controller for TextField

  bool error, sending, success;
  String msg, msgBtn, mobileCooki;
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
    msgBtn="ثبت پیام جدید";
    super.initState();
    this.sendData();
  }
  //print("1");
  Future<void> sendData() async {
    //phpurl=t.getaddress(), 'UserVerfy.php');
    phpurl = t.getaddress()+"UserVerfy.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileCooki= prefs.getString('mobile99');
    //mobileCooki="09143805648";
    print (mobileCooki);
    if (mobileCooki!= null)// To check cooki which seted in App
        {
      Navigator.push(context,MaterialPageRoute(builder: (context) => linkpage()));
     /* var res = await http.post(phpurl, body: {
        "mobileSent":mobileCooki,
      });*///sending post request with header data
      /*if (res.statusCode == 200) {
        // print("body:" + res.body); //print raw response on console
        var data = json.decode(res.body); //decoding json to array
        print(data);
        int x=int.parse(data.toString());
        if(x==123) {
          setState(() {
            msg="mobarak";
            // Navigator.push(context, MaterialPageRoute(builder: (_) => shenasnameh()));
            Navigator.push(context,MaterialPageRoute(builder: (context) => linkpage()));
          });
          //Toast.show("پیام ارسال شد", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        else
          {
            print("not ok Cooki");
            setState(() {
              msg="mobarak";
              // Navigator.push(context, MaterialPageRoute(builder: (_) => shenasnameh()));
              Navigator.push(context,MaterialPageRoute(builder: (context) => regUserkk()));
            });
          }

      }*/
    }
    else
      {
        print("not mobile");
        setState(() {
          msg="mobarak";
          // Navigator.push(context, MaterialPageRoute(builder: (_) => shenasnameh()));
          Navigator.push(context,MaterialPageRoute(builder: (context) => regUserkk()));
        });      }
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
                    //SizedBox(height: 10,),
                    Container(
                        height: 0,
                        width: 0,

                        ),

                  ]
              ),
            )
        )
    );
  }
}