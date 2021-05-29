import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class blog extends StatefulWidget {
  @override
  _pricearzsState createState() => _pricearzsState();
}

class _pricearzsState extends State<blog> {
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('مشاهده ی لینک'),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: 'http://www.rozbit1.com/articles'))
          ],
          //
          //http://rozbit1.com/articles
        ));
  }
}
