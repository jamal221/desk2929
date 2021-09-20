import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'test123.dart';
import 'footer.dart';


class ticketlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ticketlist1(),
    );
  }
}
var s;
List<Messages> msgs = <Messages>[];

class ticketlist1 extends StatefulWidget {
  @override
  _ticketlist1State createState() => _ticketlist1State();
}

class _ticketlist1State extends State<ticketlist1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArzData();
  }
  @override
  Widget build(BuildContext context) {
    s=(MediaQuery.of(context).size);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(


          children: <Widget>[
            SizedBox(height: 30,),
            Container(
                //height: 50,
                //color: Color.fromARGB(255, 230, 230, 230),
              color: Colors.white,
                child: header()
            ),
            Container(
                      height: (MediaQuery.of(context).size.height)-170,
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
                                  child: Text("لیست تیکت ها",style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                ),
                                Center(
                                  child: Text("در صورت افزایش تیکت ها بکمک اسکرول صفحه را پیمایش نمایید.",style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.bold),),
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
          height: 50.0,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget getrow() {
    if(msgs.length!=0) {

      return Container(
        //color: Colors.green,
          height: s.height-280,
          child: Scrollbar(
              thickness: 10,
              //sisAlwaysShown: true,
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                itemCount: msgs.length,
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    margin: EdgeInsets.all(10.0),
                    width: s.width*0.75,

                    decoration: BoxDecoration(
                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)
                      ),
                    ),

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
                                  child:   Text('${msgs[index].msg}',style: TextStyle(color: Colors.black,fontSize: 18.0),textAlign: TextAlign.start,),
                                ),
                                Container(
                                  width: s.width*0.15,
                                  child:   Text('${msgs[index].date1}',style: TextStyle(color: Colors.black,fontSize: 12.0),textAlign: TextAlign.center,),
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
                                Container(
                                  width: s.width*0.15,
                                  color: Color.fromARGB(255, 255, 0, 150),
                                  child:   Text('${msgs[index].date2}',
                                    style: TextStyle(color: Colors.black,fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  width: s.width*0.75,
                                  color: Color.fromARGB(255, 255, 255, 150),
                                  child:   Text('${msgs[index].msg_admin}',style: TextStyle(color: Colors.green,fontSize: 20.0),textAlign: TextAlign.right,),
                                ),
                              ],
                            )
                          //}
                        ),
                      ],
                    ),


                  );
                },
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 7,),
              )
          )

      );
    }
    else
    {

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10,),
          Image.asset('assets/images/darkhastKHarid.png', height: 100,width: 300,),
          Container(
            child: Text("در حال حاضر هیچ پیامی وجود ندارد.",style: TextStyle(color: Colors.white,fontSize: 20.0,),textAlign: TextAlign.center,),
          )

        ],
      );
    }
  }
  test123 t=new test123();
  void getArzData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobileCooki= prefs.getString('mobile99');

    final String uri = t.getaddress()+"msglist2.php";
    //final Uri uri =Uri.http(t.getaddress(), 'msglist2.php');
    print("mobile for msg is  "+mobileCooki);
    var response = await http.post(uri, body: {
      "mobilemsg": mobileCooki,
    });


    if (response.statusCode == 200) {

      //String check1=json.decode(response.body);
      //print(check1);
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      //print(items);
      List<Messages> listOfmsgs = items.map<Messages>((json) {
        return Messages.fromJson(json);
      }).toList();
      msgs.clear();

      for(int i=0;i<listOfmsgs.length;i++)
      {
        msgs.add(listOfmsgs[i]);
      }

      setState(() {
        //arzDataSource = ArzDataSource(arzdata: arzs);

      });
      //print(listOfArticles[i].id_Article);
      //for(var zz in  listOfArticles)
      //  print(listOfArticles["id_Article"].toString());
    }
    else {
      throw Exception('خطا در مشاهده ی اطلاعات');
    }

  }
}

class Messages {
  final String msg;
  final String type;
  final String date1;
  final String date2;
  final String msg_admin;


  Messages({
    this.msg,
    this.type,
    this.date1,
    this.date2,
    this.msg_admin,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      msg: json['msg'],
      type: json['statuse'],
      date1: json['date1'],
      date2: json['date_response'],
      msg_admin: json['msg_response'],
    );
  }
}


