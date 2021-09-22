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
import 'DownLoadFile4.dart';
import 'package:url_launcher/url_launcher.dart';


import 'header.dart';
test123 t=new test123();
//final String _fileUrl =t.getaddress()+"/files/newest_version.apk";
final String _fileUrl ="http://desk2929.ir/versions/newest_version.apk";
//import package file manually
String msg="درحال ارسال پبام...";
String ver1Db, ver2DB, ver3DB;
class VersionAlarm extends StatelessWidget {
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
  //test123 t=new test123();


  bool error, sending, success;
  String msg, msgBtn, mobilecooki;

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
    msg = "ورژن شما قدیمی است و ورژن جدید در پایگاه موجود است، لطفا از طریق لینک زیر آن را دانلود کرده یا عدم موافقت را انتخاب نمایید.";
    super.initState();
    getVersion();
    //CheckUser();
  }
  Future<void> _download() async {
    await canLaunch(_fileUrl) ? await launch(_fileUrl) : throw 'Could not launch $_fileUrl';
  }
  /*Future<void> CheckUser() async {
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


  }*/

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

                    SizedBox(height: 10,),
                    Container(
                        height: 100,
                        color: Colors.white,
                        child: header()
                      //child: Image.asset('assets/images/Banner_desk.png', scale: 1,),
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
                            child: Text("بررسی ورژن",style: TextStyle(color: Colors.white,fontSize: 22.0,fontWeight: FontWeight.bold),),
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
                                                   ),

                                      Container(
                                        width: s.width*0.7,
                                        padding: EdgeInsets.only(right: 100,top:5),
                                        child:new RaisedButton(
                                          child: new Text("دانلود ورژن جدید"),
                                          onPressed: (){
                                            //Navigator.push(context,MaterialPageRoute(builder: (context) => DownLoadFile4()));
                                            _download();
                                           },
                                          color: Colors.deepOrange,
                                          highlightColor: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        width: s.width*0.7,
                                        padding: EdgeInsets.only(right: 100,top:5),
                                        child:new RaisedButton(
                                          child: new Text("ادامه با ورژن قبلی",
                                          ),
                                          color: Colors.deepOrange,
                                          onPressed: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => CheckMobileUser()));
                                          },
                                          highlightColor: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        //padding: const EdgeInsets.only(right: 5),
                                        width: s.width*0.70,
                                        child:   Text('ورژن جدید:  '+'$ver1Db'+'.'+'$ver2DB'+'.'+'$ver3DB',style: TextStyle(color: Colors.black,fontSize: 18.0),textAlign: TextAlign.start,),
                                      ),

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
                     //width: s.width,
                    child: footerme(),
                  ),

                ]
            ),
            height: 60.0,
            color: Colors.red,
          ),
        )
    );
  }
  void getVersion() async {
    final String uri = t.getaddress()+"ShowVersion.php";
    //final Uri uri =Uri.http(t.getaddress(), 'ShowVersion.php');
    var response = await http.get(uri);
    //print("mobile for msg is  "+mobileCooki);
    if (response.statusCode == 200) {
      //String check1=json.decode(response.body);
      //print(check1);
      final items1 = json.decode(response.body);
      print ("items1");
      print (items1[2]);
      setState(() {
        ver1Db=items1[0].toString();
        ver2DB=items1[1].toString();
        ver3DB=items1[2].toString();
      });
      setState(() {
      });
    }
    else {
      throw Exception('خطا در مشاهده ی اطلاعات');
    }

  }
}
