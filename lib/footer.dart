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

String ver1Db, ver2DB, ver3DB;
test123 t=new test123();
class footerme extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    /*return MaterialApp(
      home: Scaffold(
          body: Image.asset('assets/images/footer.png',
          height: 10,
          width: 10,)
      )

    );*/

    var s=MediaQuery.of(context).size.width;
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
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },
            child: Column(
              children: [
                Container(
                  //width: 100,
                  child: Text(
                    'کد تخفیف آنتی ویروس پادویش:',
                  ),
                ),
                Container(
                  //width: 100,
                  child: Text(
                    ' p-abc123456',
                  ),
                ),

              ],
            ),

          ),
          //width: s.width/5,
          //child: Image.asset('assets/images/home.png'),
          //),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },
            child: Column(
              children: [
                Container(
                  //width: 100,
                  child: Text(
                    'ارتباط با ما:',
                  ),
                ),

                Container(
                  //width: 100,
                  child: Text(
                    '09143805648',
                  ),
                ),

              ],
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },
            child: Column(
              children: [
                Container(
                  //width: 100,
                  child: Text('ورژن برنامه ی شما:',
                  ),
                ),

                Container(
                  //width: 100,
                  child: Text('0'+'.'+'0'+'.'+'1',),
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

