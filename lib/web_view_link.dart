import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:desk2929/header.dart';
class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
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
              child: header(),
            ),
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url
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
                  child: Image.asset('assets/images/home.png'),
                ),
                Container(
                  //   width: s.width/5,
                  child: Image.asset('assets/images/user.png'),
                ),
              ]
          ),
          height: 60.0,
          color: Colors.red,
        ),
      )
    );
  }
}