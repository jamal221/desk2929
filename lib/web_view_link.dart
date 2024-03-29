import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:desk2929/header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "footer.dart";
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'links.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  WebViewContainer(this.url);
  @override
  createState() => _WebViewContainerState(this.url);
}
class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  String DInter;
  bool setCooki;
  final _key = UniqueKey();
  _WebViewContainerState(this._url);
  @override
  void initState() {
    setCooki=false;
    BackButtonInterceptor.add(myInterceptor);
    CheckInter();
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //print("BACK BUTTON!"); // Do some stuff.
    Navigator.push(context,MaterialPageRoute(builder: (context) => linkpage()));
    return true;
  }
  Future<void> CheckInter() async {
    //phpurl = t.getaddress()+"MessagReg.php";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DInter= prefs.getString('DInterUser');
    //print (emailCooki);
    if (DInter!= null)// To check cooki which seted in App
        {
      print(DInter);
      setState(() {
        setCooki=true;
      });
    }
      }
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
              child: setCooki? header(): Image.asset('assets/images/Banner_desk.png', scale: 1,),
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
          color: Colors.purple,
        ),
      )
    );
  }
}
