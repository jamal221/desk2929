import 'package:desk2929/web_view_link.dart';
import 'package:flutter/material.dart';
import 'package:desk2929/main.dart';
import 'package:desk2929/linkmali.dart';
import 'package:desk2929/links.dart';
import 'Show_Version.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'test123.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:io';

late String ver1Db, ver2DB, ver3DB;
var ConnectionFlag;
test123 t=new test123();
class footerme extends StatelessWidget {
  @override
  var ConnectionFlag=0;




  Widget build(BuildContext context) {
    var s=MediaQuery.of(context).size;
    //print(s);
    //var s=30;
    return Container(
      //width: s,
      //color: Colors.green,
     // child: Image.asset('assets/images/footer.png',
      //width: 600
      //),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //Container(
          // GestureDetector(
          //
          //   onTap: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
          //   },
          //   // child: Column(
          //   //   children: [
          //   //     Container(
          //   //       //width: 100,
          //   //       margin: EdgeInsets.only(left: 10),
          //   //       child:  Text(
          //   //         'کد تخفیف آنتی ویروس پادویش:',
          //   //       ),
          //   //     ),
          //   //     Container(
          //   //       margin: EdgeInsets.only(right: 2, left: 2),
          //   //       //width: 100,
          //   //       child: SelectableText(
          //   //         ' p-abc123456',
          //   //          style: TextStyle(color: Colors.red,fontSize: 15.0),
          //   //         textAlign: TextAlign.center,
          //   //       ),
          //   //     ),
          //   //
          //   //   ],
          //   // ),
          //
          // ),
          //width: s.width/5,
          //child: Image.asset('assets/images/home.png'),
          //),
          SizedBox(width: 10,),
          GestureDetector(
           /* onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },*/
            child: Column(
              children: [
                Container(
                  width: s.width/2,

                  child: Text(
                    'ارتباط با ما:',

                  ),
                ),

                Container(
                  width: s.width/2,
                  child: SelectableText(
                    '09143805648',
                    style: TextStyle(color: Colors.red,fontSize: 15.0),
                    // textAlign: TextAlign.center,
                  ),
                ),

              ],
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            /*onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },*/
            child: Column(
              children: [
                Container(
                  //width: 100,
                  child: Text('ورژن :',
                  ),
                ),

                Container(
                  //width: 100,
                  child: Text('3'+'.'+'0'+'.'+'2',
                    style: TextStyle(color: Colors.red,fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  //child: ShowVersion(),
                ),

              ],
            ),
          ),



        ],
      ),
    );
  }
}

