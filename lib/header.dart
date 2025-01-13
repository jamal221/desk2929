import 'package:desk2929/SendPickMain.dart';
import 'package:flutter/material.dart';
import 'package:desk2929/main.dart';
import 'package:desk2929/linkmali.dart';
import 'package:desk2929/links.dart';
import 'package:flutter/services.dart';
import 'MessageUser.dart';
import 'ticketlist.dart';
import 'User_inf.dart';
import 'CheckVersion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'branches.dart';
import 'Sendpick4.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'test123.dart';
import 'dart:io';
import 'dart:convert';

test123 t = new test123();
var str11 = t.getaddress();
var s;
var Image_Path;
var Image_id;

class header extends StatelessWidget {
  @override
  void initState() {
    Image_Path = '../images/flutter/user.png';
    SetProfile();
  }

  Widget build(BuildContext context) {
    SetProfile();
    var s = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(11),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Container(
            /*GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => CheckVersionApp()));
              },
              child: Container(
                width: s.width/10,
                child: Image.asset('assets/images/Download.png'),
              ),
            ),*/
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => linkpage()));
                },
                child: Column(children: [
                  Container(
                    child: CircleAvatar(
                      radius: 35,
                      foregroundColor: Colors.transparent,
                      backgroundImage:
                          ExactAssetImage('assets/images/home.png'),
                    ),
                  ),
                  Container(
                      child: Text(
                    'خانه',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontFamily: "Vazir"),
                  ))
                ])),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => UserInf()));
              },
              child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 35,
                      foregroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(str11 + '$Image_Path'),
                      // child:(Image_Path!=''?Image.network(str11+'$Image_Path', width: 50, height: 50,):Image.asset('assets/images/user.png')) ,
                    ),
                  ),
                  Container(
                      child: Text(
                    'ارتباط با ما',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontFamily: "Vazir"),
                  ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UploadImageMain()));
              },
              child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 35,
                      foregroundColor: Colors.transparent,
                      backgroundImage:
                          ExactAssetImage('assets/images/logo.png'),
                      // child:(Image_Path!=''?Image.network(str11+'$Image_Path', width: 50, height: 50,):Image.asset('assets/images/user.png')) ,
                    ),
                  ),
                  Container(
                      child: Text(
                    'مدیریت تصاویر',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontFamily: "Vazir"),
                  ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => branchpage()));
              },
              child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 35,
                      foregroundColor: Colors.transparent,
                      backgroundImage:
                          ExactAssetImage('assets/images/chat.png'),
                      // child:(Image_Path!=''?Image.network(str11+'$Image_Path', width: 50, height: 50,):Image.asset('assets/images/user.png')) ,
                    ),
                  ),
                  Container(
                      child: Text(
                    'ارسال پیام',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontFamily: "Vazir"),
                  ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
                //Navigator.push(context, MaterialPageRoute(builder: (_) => ticketlist()));
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('آیا می خواهید از برنامه خارج شوید؟'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop(context),
                            child: Text('خیر'),
                          ),
                          TextButton(
                            onPressed: () =>
                                SystemNavigator.pop(), // passing true
                            child: Text('بله'),
                          ),
                        ],
                      );
                    }).then((exit) {
                  if (exit == null) return;

                  if (exit) {
                    //exit(0);// user pass yes button
                    //Navigator.pop(context,'OK');
                    //SystemNavigator.pop();
                  } else {
                    // user pressed No button
                    //Navigator.of(context).pop(false);
                    Navigator.of(context, rootNavigator: true).pop(context);
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 35,
                      foregroundColor: Colors.transparent,
                      backgroundImage:
                          ExactAssetImage('assets/images/exit1.png'),
                      // child:(Image_Path!=''?Image.network(str11+'$Image_Path', width: 50, height: 50,):Image.asset('assets/images/user.png')) ,
                    ),
                  ),
                  Container(
                      child: Text(
                    'خروج از برنامه',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.0,
                        fontFamily: "Vazir"),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var profile_fetched;
Future<dynamic> SetProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mobileCooki = prefs.getString('mobile99') ?? '';
  var str_image_num = 'FindProfile.php';
  final Uri ImageProfile = Uri.parse('$str11$str_image_num');
  var request = http.MultipartRequest('POST', ImageProfile);
  request.fields['mob'] = mobileCooki;
  var response = await http.post(ImageProfile, body: {
    "mob": mobileCooki,
  });
  if (response.statusCode == 200) {
    final items = json.decode(response.body);
    print(" Addres Image is: " +
        items['pic_add'] +
        "  Id image is:  " +
        items['id']);
    Image_Path = items['pic_add'];
    Image_id = items['id'];
  }
}
