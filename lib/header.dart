import 'package:flutter/material.dart';
import 'package:desk2929/main.dart';
import 'package:desk2929/linkmali.dart';
import 'package:desk2929/links.dart';
import 'package:flutter/services.dart';
import 'MessageUser.dart';
import 'ticketlist.dart';
import 'User_inf.dart';
import 'package:desk2929/SendPic2.dart';
import 'CheckVersion.dart';
class header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var s=MediaQuery.of(context).size;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Container(
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => CheckVersionApp()));
            },
            child: Container(
              width: s.width/10,
              child: Image.asset('assets/images/Download.png'),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => linkpage()));
            },
            child: Container(
               width: s.width/10,
              child: Image.asset('assets/images/home.png'),
            ),
          ),
             //width: s.width/5,
            //child: Image.asset('assets/images/home.png'),
          //),
          GestureDetector(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
              Navigator.push(context, MaterialPageRoute(builder: (_) => UserInf()));

            },
            child: Container(
               width: s.width/10,
              child: Image.asset('assets/images/user.png'),
            ),
          ),

          GestureDetector(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
              Navigator.push(context, MaterialPageRoute(builder: (_) => UploadImage()));

            },
            child: Container(
               width: s.width/10,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          GestureDetector(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
              Navigator.push(context, MaterialPageRoute(builder: (_) => ticketlist()));

            },
            child: Container(
              width: s.width/10,
              child: Image.asset('assets/images/alarm.png'),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
              //Navigator.push(context, MaterialPageRoute(builder: (_) => ticketlist()));

            },
            child: Container(
               width: s.width/10,
              child: Image.asset('assets/images/chat.png'),
            ),
          ),
          GestureDetector(
            onTap: (){
              //Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
              //Navigator.push(context, MaterialPageRoute(builder: (_) => ticketlist()));
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('آیا می خواهید از برنامه خارج شوید؟'),
                      actions: [
                        FlatButton(
                          //onPressed: () =>Navigator.of(context).pop(false), // passing false
                          onPressed: () =>Navigator.of(context, rootNavigator: true).pop(context),
                          child: Text('خیر'),
                        ),
                        FlatButton(
                          onPressed: () => SystemNavigator.pop(),// passing true
                          child: Text('بله'),
                        ),
                      ],
                    );
                  }
                  ).then((exit)
              {
                if (exit == null) return;

                if (exit) {
                  //exit(0);// user pass yes button
                  //Navigator.pop(context,'OK');
                  //SystemNavigator.pop();
                }
                else {
                  // user pressed No button
                  //Navigator.of(context).pop(false);
                  Navigator.of(context, rootNavigator: true).pop(context);
                }
              }
              );
            },
            child: Container(
               width: s.width/10,
              child: Image.asset('assets/images/exit1.png'),
            ),
          ),
        ],
      ),
    );
  }
}

