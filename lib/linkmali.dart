import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_view_link.dart';
test123 t=new test123();

class malilinks extends StatelessWidget {
  final _links=['www.google.com'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 140),
              child: Text('لینک های مالی',
                ),
            )
        ),
        body: MaliLinkView(),
      ),
    );
  }
}

class linkdata {
  int linkID;
  String linkName;
  int linkType;
  String linkUrl;

  linkdata({
    this.linkID,
    this.linkName,
    this.linkType,
    this.linkUrl
  });

  factory linkdata.fromJson(Map<String, dynamic> json) {
    return linkdata(
        linkID: json['id'],
        linkName: json['name'],
        linkType: json['type'],
        linkUrl: json['Address']

    );
  }
}
/*launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(Uri.encodeFull(url), forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}*/
Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    return const Text('');
  }
}
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

class MaliLinkView extends StatefulWidget {

  MaliLinkViewState createState() => MaliLinkViewState();

}

class MaliLinkViewState extends State {
  bool isLoaded;
  Future<void> _launched;
  final String apiURL = t.getaddress() +'LinksMali.php';
  final _key = UniqueKey();
  Future<List<linkdata>> fetchlinks() async {

    var response = await http.get(apiURL);

    if (response.statusCode == 200) {

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<linkdata> linkList = items.map<linkdata>((json) {
        return linkdata.fromJson(json);
      }).toList();

      return linkList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }
  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer('https://www.desk2929.ir/mali')));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoaded=false;
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

      body: FutureBuilder<List<linkdata>>(
        future: fetchlinks(),
      builder: (context, snapshot) {


        if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator()
        );
        return ListView(
          children: snapshot.data
              .map((data) => Column(children: <Widget>[
            GestureDetector(
              onTap: ()
              {
                //_handleURLButtonPress(context, data.linkUrl);
                //navigateToNextActivity(context, data.linkID);
                print(data.linkUrl);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WebViewContainer('https://www.desk2929.ir/mali'))
                  );
                },

              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Text(data.linkName,
                            style: TextStyle(fontSize: 21),
                            textAlign: TextAlign.left))

                  ]),),

            Divider(color: Colors.black),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],))
              .toList(),
        );
      },
    )
    )
    );
  }
}



