import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'links.dart';
import 'registerPage.dart';
import 'package:desk2929/CheckMobile.dart';
import 'Version_Alarm.dart';
import 'header.dart';
import 'Show_Version.dart';
import 'desk_interview.dart';
import 'VersionAlarmNewUser.dart';
//import package file manually
String msg="درحال ارسال پبام...";
test123 t=new test123();
var s;
//Uri phpurl = Uri.http(t.getaddress(), 'VersionVerfy.php');
String phpurl =t.getaddress()+"VersionVerfy.php";
//test123 t=new test123();
class CheckVersionApp extends StatelessWidget {
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
  String msg, msgBtn, mobileCooki, ver1app, ver2app, ver3app, mobilecooki;
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
    int ver1app=2;
    int ver2app=0;
    int ver3app=1;
    msgBtn="ثبت پیام جدید";
    super.initState();
    this.sendData();
  }

  //print("1");

  Future<void> sendData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobilecooki= prefs.getString('mobile99');
    //print ("mobilecooki");
    if (mobilecooki!= null)// To check cooki which seted in App
        {
          setState(() {
            success=true;
          });

    }
    var res = await http.post(phpurl, body: {
      "ver1appSend":"2",
      "ver2appSend":"0",
      "ver3appSend":"1",
    });
    //print("ver1app is:");
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //mobileCooki= prefs.getString('mobile99');
    //mobileCooki="09143805648";
    //print (mobileCooki);
    //var data =res.body;
    print(res.body);
    print(success);
    if (res.body == "789" && success== true)// To check cooki which seted in App
        {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Desk_first_page()));
        }
    else if(res.body == "789" && success== false)// version aright while mobile isn't defined
      {
        //print("new version exist on the web please  check");
        Navigator.push(context,MaterialPageRoute(builder: (context) => Desk_first_page()));
       // Navigator.push(context,MaterialPageRoute(builder: (context) => ShowVersion()));

      }
    else if(res.body == "456" && success== true)
      {
        Navigator.push(context,MaterialPageRoute(builder: (context) => VersionAlarm()));// in this part has confilct version
      }
    else{
      Navigator.push(context,MaterialPageRoute(builder: (context) => VersionAlarm1()));
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