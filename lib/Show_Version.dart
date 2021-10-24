import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test123.dart';
import 'footer.dart';

String ver1Db, ver2DB, ver3DB;
class ShowVersion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ticketlist1(),
    );
  }
}
var s;

class ticketlist1 extends StatefulWidget {
  @override
  _ticketlist1State createState() => _ticketlist1State();
}

class _ticketlist1State extends State<ticketlist1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVersion();
  }
  @override
  Widget build(BuildContext context) {
    s=(MediaQuery.of(context).size);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(

          children: <Widget>[
            SizedBox(height: 5,),
            Container(
                height: 60,
                color: Color.fromARGB(255, 230, 230, 230),
                child: header()
            ),
            Container(
                      height: (MediaQuery.of(context).size.height)-130,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end:
                          Alignment.centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[

                            Color.fromARGB(120, 39, 206, 137),
                            Color.fromARGB(255, 28, 30, 79)
                          ], // red to yellow
                          tileMode: TileMode.mirror, // repeats the gradient over the canvas
                        ),
                      ),
                child: Column(
                              children: <Widget>[

                                Center(
                                  child: Text("ورزن شما به شرح  زیر می باشد.",style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                ),

                                Divider(color: Colors.white,),

                                SizedBox(height: 2,),
                                getrow(),


                              ],
              ),
            ),
            SizedBox(
              height: 3,
            )

          ],

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
              ]
          ),
          height: 60.0,
          color: Colors.purple,
        ),
      ),
    );
  }

  Widget getrow() {
    if(1==1) {

      return Container(
        //color: Colors.green,
          height: s.height-200,
         // child: Scrollbar(
              //thickness: 10,
              //sisAlwaysShown: true,
              child: (
                //padding: const EdgeInsets.all(0),
                //itemCount: msgs.length,
                //itemBuilder: (BuildContext context, int index) {
                  Container(
                    margin: EdgeInsets.all(10.0),
                    width: s.width*0.75,

                   /* decoration: BoxDecoration(
                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)
                      ),
                    ),*/

                    child:Column(
                      children: [
                        Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //padding: const EdgeInsets.only(left: 80) ,
                                SizedBox(height: 2,),
                                Container(
                                  //padding: const EdgeInsets.only(right: 5),
                                  width: s.width*0.70,
                                  child:   Text('$ver1Db'+'.'+'$ver2DB'+'.'+'$ver3DB',style: TextStyle(color: Colors.black,fontSize: 18.0),textAlign: TextAlign.start,),
                                ),


                              ],
                            )
                        ),

                        //Divider(color: Colors.black,),
                        SizedBox(height: 2,),
                        Container(
                          // if(msgs.msg_admin!='')
                          //{
                            color: Color.fromARGB(255, 50, 140, 150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                SizedBox(height: 3,),

                              ],
                            )
                          //}
                        ),
                      ],
                    ),


                  )
                //},
                //separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 7,),
              )
          //)

      );
    }
    else
    {

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10,),
        ],
      );
    }
  }
  test123 t=new test123();
  void getVersion() async {
    final String uri = t.getaddress()+"ShowVersion.php";
    //final Uri uri =Uri.http(t.getaddress(), 'ShowVersion.php');
    var response = await http.get(uri);
    //print("mobile for msg is  "+mobileCooki);
    if (response.statusCode == 200) {
      //String check1=json.decode(response.body);
      //print(check1);
      final items1 = json.decode(response.body);

      print (items1[0]);
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



