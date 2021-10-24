import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'footer.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'links.dart';

import 'header.dart';
//import package file manually
String msg="درحال ارسال پبام...";
class MsgUser extends StatelessWidget {
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
  String msg, msgBtn, mobilecooki;
  test123 t=new test123();
  String phpurl, phpurl2;
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
    BackButtonInterceptor.add(myInterceptor);
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //print("BACK BUTTON!"); // Do some stuff.
    Navigator.push(context,MaterialPageRoute(builder: (context) => linkpage()));
    return true;
  }
  CheckIdentfy() async{
  phpurl2 = t.getaddress()+"CheckUserImage.php";
    //phpurl2 = Uri.http(t.getaddress(), 'CheckUserImage.php');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  mobilecooki= prefs.getString('mobile99');
  {
    var res = await http.post(phpurl2, body: {
      if(msgctl.text!=null)
        {
          "mobilesended":mobilecooki,
          "msgsended": msgctl.text,
        }
      else
        {
        Toast.show("پیام ارسال شد", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM)
        }

    });//sending post request with header data
    print(msgctl.text);
    if (res.statusCode == 200) {
      // print("body:" + res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      print(data);
      int x=int.parse(data.toString());
      if(x==123) {
        Toast.show("پیام ارسال شد", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

        setState(() {
          sending=true;
          error= false;
          msgctl.text="";
        });
      }
      else
        print("not ok Cooki");
    }

  }
}
  Future<void> sendData() async {
    phpurl = t.getaddress()+"MessagReg.php";
   // phpurl =Uri.http(t.getaddress(), 'MessagReg.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobilecooki= prefs.getString('mobile99');
    //print (emailCooki);
    if (!msgctl.text.isEmpty)// To check cooki which seted in App
        {

      var res = await http.post(phpurl, body: {
        "mobilesended":mobilecooki,
        "msgsended": msgctl.text,
      });//sending post request with header data
      print(msgctl.text);
      if (res.statusCode == 200) {
        // print("body:" + res.body); //print raw response on console
        var data = json.decode(res.body); //decoding json to array
        print(data);
        int x=int.parse(data.toString());
        if(x==123) {
          Toast.show("پیام ارسال شد", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

          setState(() {
            sending=true;
            error= false;
            msgctl.text="";
          });
        }
        else
          print("not ok Cooki");
      }

    }
    else
      {
        Toast.show("پیام نباید خالی باشد.", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

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
                    SizedBox(height: 30,),
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
                            child: Text("ارسال تیکت",style: TextStyle(color: Colors.white,fontSize: 22.0,fontWeight: FontWeight.bold),),
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
                                      Container(
                                          width: 300,
                                          height: 200,
                                          child: TextField(
                                            maxLines: 20,
                                            controller: msgctl,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'متن پیام',
                                              hintText: 'لطفا پیام خود را تایپ نمایید',
                                            ),
                                            autofocus: true,
                                          )
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        child: Text(error ? "" : "پیام با موفقیت ارسال شد."),
                                        //if there is error then sho msg, other wise show text message
                                      ),

                                      Container(
                                          margin: EdgeInsets.only(top: 20),
                                          width: s.width*0.8,
                                          child: SizedBox(
                                              width: double.infinity,
                                              child: RaisedButton(
                                                onPressed: () { //if button is pressed, setstate sending = true, so that we can show "sending..."
                                                  setState(() {
                                                    sending = true;
                                                  });
                                                  sendData();
                                                },
                                                child: Text(
                                                  sending ? msgBtn : "ارسال پیام",style: TextStyle(color: Colors.black,fontSize: 16),
                                                ),//if sending == true then show "Sending" else show "SEND DATA";
                                                color: Colors.greenAccent,
                                                colorBrightness: Brightness.dark,
                                                //background of button is darker color, so set brightness to dark
                                              )
                                          )
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
            color: Colors.purple,
          ),

        )
    );
  }
}