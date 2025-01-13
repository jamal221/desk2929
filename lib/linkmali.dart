import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'web_view_link.dart';

test123 t = new test123();

class malilinks extends StatelessWidget {
  final _links = ['www.google.com'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 140),
            child: Text('لینک های مالی'),
          ),
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
    required this.linkID,
    required this.linkName,
    required this.linkType,
    required this.linkUrl,
  });

  factory linkdata.fromJson(Map<String, dynamic> json) {
    return linkdata(
      linkID: json['id'],
      linkName: json['name'],
      linkType: json['type'],
      linkUrl: json['Address'],
    );
  }
}

Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    return const Text('');
  }
}

bool isLoading = true;

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

class MaliLinkViewState extends State<MaliLinkView> {
  late Future<void> _launched;
  final Uri apiURL = Uri.http(t.getaddress(), 'LinksMali.php');
  final _key = UniqueKey();

  Future<List<linkdata>> fetchlinks() async {
    var response = await http.get(apiURL);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<linkdata> linkList = items.map<linkdata>((json) {
        return linkdata.fromJson(json);
      }).toList();

      return linkList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewContainer(url),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: FutureBuilder<List<linkdata>>(
          future: fetchlinks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available'));
            }

            return ListView(
              children: snapshot.data!.map<Widget>((data) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WebViewContainer('https://' + data.linkUrl),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                            child: Text(
                              data.linkName,
                              style: TextStyle(fontSize: 21),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.black),
                    FutureBuilder<void>(
                      future: _launched,
                      builder: _launchStatus,
                    ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
