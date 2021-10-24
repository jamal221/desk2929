import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:desk2929/header.dart';
import "footer.dart";
class WebViewContainerfooter extends StatefulWidget {
  final url2;
  WebViewContainerfooter(this.url2);
  @override
  createState() => _WebViewContainerfooterState(this.url2);
}
class _WebViewContainerfooterState extends State<WebViewContainerfooter> {
  var _url2;
  final _key = UniqueKey();
  _WebViewContainerfooterState(this._url2);
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          //return Scaffold(
          // appBar: AppBar(),
          body: Column(
            children: [
              SizedBox(height: 15,),
              Container(
                //child: header(),
                child: Image.asset('assets/images/Banner_desk.png', scale: 1,),
              ),
              Expanded(
                  child: WebView(
                      key: _key,
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: _url2
                  )
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
                    //child: Image.asset('assets/images/home.png'),
                  ),
                  Container(
                    //   width: s.width/5,
                    // child: Image.asset('assets/images/user.png'),
                  ),
                  Container(
                    child: footerme(),
                  )
                ]
            ),
            height: 60.0,
            color: Colors.purple,
          ),
        )
    );
  }
}