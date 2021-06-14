import 'package:flutter/material.dart';
import 'package:desk2929/main.dart';
import 'package:desk2929/linkmali.dart';
import 'package:desk2929/links.dart';
import 'MessageUser.dart';
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => linkpage()));
            },
            child: Container(
              // width: s.width/5,
              child: Image.asset('assets/images/home.png'),
            ),
          ),
             //width: s.width/5,
            //child: Image.asset('assets/images/home.png'),
          //),
          Container(
            //width: s.width/5,
            child: Image.asset('assets/images/user.png'),
          ),
          Container(
             //width: s.width/5,
            child: Image.asset('assets/images/logo.png'),
          ),
          Container(
            //width: s.width/5,
            child: Image.asset('assets/images/alarm.png'),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
            },
            child: Container(
              // width: s.width/5,
              child: Image.asset('assets/images/chat.png'),
            ),
          ),
        ],
      ),
    );
  }
}
