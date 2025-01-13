import 'package:desk2929/ticketlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'test123.dart';
import 'header.dart';
import 'package:desk2929/footer.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class branchpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "شعبات اداره بوکان",
      debugShowCheckedModeBanner: false,
      home: branchdek(),
    );
  }
}

class branchdek extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return branchdekState();
  }
}

String msg = "";
test123 t = new test123();

class branchdekState extends State<branchdek> {
  List<make_branch> _Branches = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    getBranchData();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //return true;
    //print("BACK BUTTON!"); // Do some stuff.
    //Navigator.push(context,MaterialPageRoute(builder: (context) => linkpage()));
    //return true;
    //Navigator.push(context, MaterialPageRoute(builder: (_) => MsgUser()));
    //Navigator.push(context, MaterialPageRoute(builder: (_) => ticketlist()));
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('آیا می خواهید از برنامه خارج شوید؟'),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(context),
                child: Text('خیر'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context, rootNavigator: false).pop(context),
                child: Text('بله'),
              ),
            ],
          );
        }).then((exit) {
      if (exit == null) return;

      if (exit) {
        exit(0); // user pass yes button
        //Navigator.pop(context,'OK');
        //SystemNavigator.pop();
      } else {
        // user pressed No button
        //Navigator.of(context).pop(false);
        Navigator.of(context, rootNavigator: true).pop(context);
      }
    });
    // Return true to indicate that the back button event was handled
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  child: header(),
                  color: Colors.white,
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    height: s.height - 100,
                    width: s.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              ExactAssetImage("assets/images/ic_launcher.png"),
                          fit: BoxFit.contain),
                      /*gradient: LinearGradient(
                          begin: Alignment.center,
                          end:
                          Alignment.centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            Color.fromARGB(255, 39, 206, 137),
                            Color.fromARGB(255, 28, 30, 79)
                          ], // red to yellow
                          tileMode: TileMode.mirror, // repeats the gradient over the canvas
                        ),*/
                    ),
                    //padding: const EdgeInsets.all(20.0),
                    child: formSetup(context)),
                Container(
                    //child: footerme(),
                    )
              ],
            ),
          ),
          bottomNavigationBar: new Container(
            //child: footerme(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: s.width,
                    child: footerme(),
                  ),
                ]),
            height: 60.0,
            color: Colors.amberAccent,
          ),
        ));
  }

  Widget formSetup(BuildContext context) {
    var s = MediaQuery.of(context).size;
    final String maliUrl = 'https://www.desk2929.ir/mali';
    return new Form(
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 5, top: 10),
            width: s.width * .95,
            height: 60,
            //child: Text("میز خدمت آموزش و پرورش بوکان"),
            decoration: BoxDecoration(
                //border: Radius.circular(10),
                image: DecorationImage(
              image: AssetImage('assets/images/Banner_desk.png'),
              fit: BoxFit.fill,
            )),
          ),
          Container(
            height: s.height - 200,
            width: s.width * .95,
            child: GridView.count(
              crossAxisCount: 5,
              crossAxisSpacing: 6,
              mainAxisSpacing: 10,
              children: List.generate(_Branches.length, (int position) {
                return GenerateBranch(s, _Branches[position]);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Container GenerateBranch(s, make_branch generate_branche) {
    return Container(
      height: 20,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          primary: Colors.amberAccent, // Background color
          onPrimary: Colors.black, // Text color
        ),
        child: Text(
          generate_branche.name_branch,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.0,
            fontFamily: "Vazir",
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ticketlist(
                generate_branche.branch_code,
                generate_branche.name_branch,
              ),
            ),
          );
        },
      ),
    );
  }

  void getBranchData() async {
    var phpurl = Uri.parse(t.getaddress() + 'app_branch_show.php');
    var response = await http.post(phpurl);
    //print("Response");
    //print(response.body);

    if (response.body != 2) {
      var Branchjson = json.decode(response.body);
      setState(() {
        for (var i in Branchjson) {
          var BranchItems = make_branch(
              name_branch: i['name_menu_app'], branch_code: i['office_branch']);
          _Branches.add(BranchItems);
        }
      });
      print(_Branches.length);

      //final items = json.decode(response.body).cast<Map<String, dynamic>>();
      //if(items){
      // print("response.body is: "+response.body);
    }
  }
}

class make_branch {
  late final String name_branch;
  final String branch_code;

  make_branch({required this.name_branch, required this.branch_code});

  factory make_branch.fromJson(Map<String, dynamic> json) {
    return make_branch(
      name_branch: json['name_menu_app'],
      branch_code: json['office_branch'],
    );
  }
}
