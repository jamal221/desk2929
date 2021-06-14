import 'package:desk2929/web_view_link.dart';
import 'package:flutter/material.dart';
import 'package:desk2929/main.dart';
import 'package:desk2929/linkmali.dart';
import 'package:desk2929/links.dart';
class footerme extends StatelessWidget {
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
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },
            child: Container(
              // width: s.width/5,
              child: Text(
                'کد تخفیف پادویش: p-abc123456'
              ),
            ),
          ),
          //width: s.width/5,
          //child: Image.asset('assets/images/home.png'),
          //),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => WebViewContainer('https://www.padvish.com')));
            },
            child: Container(
              // width: s.width/5,
              child: Text(
                  'ارتباط با ما'
                      '09149822577'
              ),
            ),
          ),
        ],
      ),
    );
  }
}
