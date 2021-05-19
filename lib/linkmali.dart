import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'package:url_launcher/url_launcher.dart';
test123 t=new test123();

class malilinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class MaliLinkView extends StatefulWidget {

  MaliLinkViewState createState() => MaliLinkViewState();

}

class MaliLinkViewState extends State {

  final String apiURL = t.getaddress() +'LinksMali.php';

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
                //navigateToNextActivity(context, data.linkID);
                html.window.open(data.linkUrl, data.linkName);
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
          ],))
              .toList(),
        );
      },
    )
    )
    );
  }
}



