import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
<<<<<<< HEAD
import 'package:desk2929/header.dart';
import "footer.dart";
class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
=======

class _WebViewContainerState extends State < WebViewContainer > {
>>>>>>> 26f2cc7f3d207559a25d52ba62613ec8d24aeefb
  var _url;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
          color: Colors.red,
        ),
      )
=======
    return Scaffold(
        appBar: AppBar(),
        body: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: < Widget > [
                Expanded(
                    child: WebView(
                      key: _key,
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: _url,
                      onPageFinished: _handleLoad,
                    )
                ),
              ],
            ),
            Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        )
>>>>>>> 26f2cc7f3d207559a25d52ba62613ec8d24aeefb
    );
  }
}

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}

