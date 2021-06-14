import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'header.dart';
//import 'shenasname.dart';



String mob;
String url = "http://rozbit1.com/karim";
TextEditingController sendedcode = TextEditingController();
class sms extends StatelessWidget {
  sms(String x){ mob=x;}
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
  }
  @override
  Widget build(BuildContext context) {
    var s=MediaQuery.of(context).size;
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
                    child: header(),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: s.height,
                      width: s.width,
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
                          children: [
                            Container(
                              width:s.width*0.9,
                              height: s.height*0.7,
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
                                  Text("جهت تایید شماره موبایل:",),
                                  SizedBox(height: 10,),

                                  Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[

                                            Container(
                                              width: s.width*0.8,
                                              padding: EdgeInsets.only(right: 5,top:5),
                                              child: new TextFormField(
                                                controller: sendedcode,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                ],
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: 'کد ارسالی',
                                                    hintText: 'کد ارسالی'),
                                              ),
                                            ),

                                          ]
                                      )
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60.0),
                                    child: Center(
                                      child: Container(
                                          width: 200,
                                          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                                          child: Image.asset('assets/logo.png')),
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black87, borderRadius: BorderRadius.circular(20)),
                                    child: GestureDetector(
                                      onTap: () async {

                                        //print(codesms+"--"+sendedcode.text.toString());
                                        if(codesms==sendedcode.text.toString())
                                        {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          //Return String
                                          await prefs.setString('mob99', mob);
                                          //Navigator.push(context, MaterialPageRoute(builder: (_) => shenasname(mob)));
                                        }
                                        // Navigator.push(context, MaterialPageRoute(builder: (_) => MainMenu1()));
                                      },
                                      child: Center(
                                        child: Text(
                                          'ورود',
                                          style: TextStyle(color: Colors.white, fontSize: 25),
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

        )
    );
  }
  String codesms;
  Future<void> sendmsg() async {
    print("mob"+mob);
    var res = await http.get(url+"?mob="+mob); //sending post request with header data

    if (res.statusCode == 200) {
      print("code:"+res.body); //print raw response on console
      var code = json.decode(res.body); //decoding json to array
      print(code);
      codesms = code.toString();

    }

  }
}

