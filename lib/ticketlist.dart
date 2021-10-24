import 'dart:convert';
//import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'test123.dart';
import 'footer.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'links.dart';

test123 t=new test123();
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
  TextEditingController msgctl = TextEditingController();
  String phpurl2, mobilecooki;
  bool error, sending, success;
  @override
  void initState() {
    // TODO: implement initState
    error = true;
    sending = false;
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    getArzData();
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
  @override
  Future<void> sendData() async {
    phpurl2 = t.getaddress()+"MessagReg.php";
    // phpurl =Uri.http(t.getaddress(), 'MessagReg.php');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobilecooki= prefs.getString('mobile99');
    //print (emailCooki);
    if (!msgctl.text.isEmpty)// To check cooki which seted in App
        {

      var res = await http.post(phpurl2, body: {
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
    s=(MediaQuery.of(context).size);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        //image: DecorationImage(
                            //image: ExactAssetImage("assets/images/ic_launcher.png"),
                            //fit: BoxFit.fill
                        //),
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
                                  child: Text("لیست تیکت ها",style: TextStyle(color: Colors.black87,fontSize: 15.0,fontWeight: FontWeight.bold),),
                                ),
                                Center(
                                  child: Text("در صورت افزایش تیکت ها بکمک اسکرول صفحه را پیمایش نمایید.",style: TextStyle(color: Colors.black87,fontSize: 15.0,fontWeight: FontWeight.bold),),
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
         color: Colors.transparent,
          //child: footerme(),
          //child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //children: <Widget>[
                //Container(
                 // padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: <Widget>[
                         Container(
                           child:InkWell(
                       onTap: () {
                         sendData();
                         ticketlist();
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(
                                 builder: (BuildContext context) => super.widget)
                         );

                       },
                             child: Image.asset('assets/images/chat.png',
                               width: 50,
                               height: 50,
                             ),
                   )

                         ),
                         Container(

                             decoration: BoxDecoration(
                                 color:  Colors.indigo,
                                 borderRadius: BorderRadius.vertical(
                                     top: Radius.circular(10),
                                     bottom: Radius.circular(10)
                                 )
                             ),
                             width: s.width*0.65,
                             height: 58.0,
                             margin: EdgeInsets.only( left: 30),
                             //color: Color.fromARGB(255, 255, 0, 150),
                           child: new Scrollbar(
                             child: TextField(
                               maxLines: 20,
                               controller: msgctl,
                             decoration: InputDecoration(
                               hintText: "نوشتن...",
                               hintStyle: TextStyle(color: Colors.grey.shade600),
                               filled: true,
                               fillColor: Colors.grey.shade100,
                               contentPadding: EdgeInsets.all(8),
                               enabledBorder: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(20),
                                   borderSide: BorderSide(
                                       color: Colors.purple
                                   )
                               ),
                             ),
                             onSubmitted: (String value){
                               print("jamal");
                             },
                           ),
                        )
                         ),

                       ]
                   )

                  // width: s.width/5,
                  //child: footerme(),
               // ),
              //]
          //),

          //color: Colors.purple,
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
                //padding: const EdgeInsets.all(0),
                itemCount: msgs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10,bottom: 10),
                //physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return  Container(
                    margin: EdgeInsets.all(5),
                    width: s.width*0.85,

                    /*decoration: BoxDecoration(
                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.amber,
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
                                SizedBox(height: 1,),
                                Container(
                                  margin: EdgeInsets.only(right: 15, left: 2),
                                  decoration: BoxDecoration(
                                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.amber,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                      bottom: Radius.circular(10)
                                    )
                                  ),
                                  //padding: const EdgeInsets.only(right: 5),
                                  width: s.width*0.60,
                                  child:   Text('${msgs[index].msg}',style: TextStyle(color: Colors.black,fontSize: 18.0),textAlign: TextAlign.start,),
                                ),
                                Container(
                                  margin: EdgeInsets.only( left: 80),
                                  decoration: BoxDecoration(
                                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.amber,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                          bottom: Radius.circular(10)
                                      )
                                  ),
                                  width: s.width*0.15,
                                  child:   Text('${msgs[index].date1}',style: TextStyle(color: Colors.black,fontSize: 12.0),textAlign: TextAlign.center,),
                                ),

                              ],
                            )
                        ),

                        //Divider(color: Colors.black,),
                        SizedBox(height:3, ),
                        Container(
                          // if(msgs.msg_admin!='')
                          //{
                            //color: Color.fromARGB(255, 50, 140, 150),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                SizedBox(height: 1,),
                                Container(
                                  margin: EdgeInsets.only(right:50, left: 2),
                                  decoration: BoxDecoration(
                                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.green,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                          bottom: Radius.circular(10)
                                      )
                                  ),
                                  width: s.width*0.15,
                                  //color: Color.fromARGB(255, 255, 0, 150),
                                  child:   Text('${msgs[index].date2}',
                                    style: TextStyle(color: Colors.black,fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: (msgs[index].type=='1') ? Colors.greenAccent:Colors.green,
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                          bottom: Radius.circular(10)
                                      )
                                  ),
                                  width: s.width*0.60,
                                  //color: Color.fromARGB(255, 255, 255, 150),
                                  child:   Text('${msgs[index].msg_admin}',style: TextStyle(color: Colors.black87,fontSize: 20.0),textAlign: TextAlign.right,),
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


