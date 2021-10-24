import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'smspage.dart';
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'header.dart';
import 'footer_first.dart';
import 'package:toast/toast.dart';
import 'links.dart';

String msg="درحال ارسال و ثبت نام...";
test123 t=new test123();
var s;
String phpurl = t.getaddress()+"UserReg.php";
class regUserkk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                  color: Colors.black87),

              hintStyle: TextStyle(
                  color: Colors.deepPurple),
            )
        ),
        home: RegInf() //set the class here
    );
  }
}
class RegInf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegInfState();
  }
}

class RegInfState extends State <RegInf> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _namectl= TextEditingController();
  TextEditingController _mobilectl= TextEditingController();
  bool error, sending, success;
  String msg, mobileCooki;

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
    CheckMobileReg();
  }
  Future<void> CheckMobileReg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileCooki= prefs.getString('mobile99');

    if (mobileCooki!= null)// To check cooki which seted in App
        {
      Navigator.push(context,MaterialPageRoute(builder: (context) => linkpage()));

    }

  }

  Future<void> sendData() async {

    if (1==1 ) {
      //print("body:"+res.body); //print raw response on console
      //var data = json.decode(res.body); //decoding json to array
      if(123==123) {
      //int code=hashCode;
      //print("hash cod is:");
      //print(code);
        setState(() {
          msg="mobarak";
          // Navigator.push(context, MaterialPageRoute(builder: (_) => shenasnameh()));
         // Navigator.push(context,MaterialPageRoute(builder: (context) => sms(_mobilectl.text, _namectl.text, code)));
          Navigator.push(context,MaterialPageRoute(builder: (context) => sms(_mobilectl.text, _namectl.text)));

        });
      }
      else{
        Toast.show("در فرایند درج خطای رخ داده است، یکبار دیگر سعی یا با مدیر سیستم تماس بگیرید.", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        print("not ok");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    //String code = randomAlpha(5);
    s=MediaQuery.of(context).size;
    // TODO: implement build
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Container(
                    height: 100,
                    color: Color.fromARGB(255, 230, 230, 230),
                    //child: header(),
                    child: Image.asset('assets/images/Banner_desk.png', scale: 1,),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10),
                      height: s.height*1.3,
                      width: s.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end:
                          Alignment.centerRight, // 10% of the width, so there are ten blinds.
                          colors: <Color>[

                            Color.fromARGB(255, 39, 206, 137),
                            Color.fromARGB(255, 28, 30, 79)
                          ], // red to yellow
                          tileMode: TileMode.mirror, // repeats the gradient over the canvas
                        ),
                      ),
                      child: Column(
                          children: [
                            Container(
                                width:s.width*.9,
                                height: s.height*1.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color.fromARGB(255, 230, 230, 230),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),

                                ),
                                child: formSetup(context)
                            ),
                          ]
                      )
                  ),
                ],
              ),
            ),
                    bottomNavigationBar: new Container(
                //child: footerme(),
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          // width: s.width/5,
                          child: footerme2(),
                        ),
                        Container(
                          // width: s.width/5,
                          //child: Image.asset('assets/images/home.png'),
                        ),
                        Container(
                          //   width: s.width/5,
                          //child: Image.asset('assets/images/user.png'),
                        ),
                      ]
                  ),
                        height: 60.0,
                        color: Colors.purple,
            ),
        )
    );
  }


  Widget formSetup(BuildContext context){
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20,top:10),
            width: 200,
            height: 40,
            child: Text("ثبت اطلاعات اولیه"),
            decoration: BoxDecoration(
              //border: Radius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/images/Dokme.png'),
                  fit: BoxFit.fill,
                )
            ),
          ),
          SizedBox(height: 2,),
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      width: s.width*0.8,
                      padding: EdgeInsets.only(right: 5,top:5),
                      child: new TextFormField(
                        controller: _namectl,
                        decoration:InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "نام و نام خانوادگی",
                            labelText: "نام و نام خانوادگی"
                        ),

                        keyboardType: TextInputType.emailAddress,
                        validator: (val){
                          if (val.length <=6)
                            return "نام و نام خانوادگی باید بیشتر از 6 کارکتر باشد";
                          else if (!val.contains(" "))
                            return "کارکتر فاصله باید بین نام و نام خانوادگی وجود داشته باشد..";
                          else
                            return null;
                        },
                      ),
                    ),
                  ]
              )
          ),
          SizedBox(height: 2,),
          Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      width: s.width*0.8,
                      padding: EdgeInsets.only(right: 5,top:5),
                      child: new TextFormField(
                        controller: _mobilectl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "مانند 09143805648:",
                            labelText: "موبایل:"
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (val){
                          if (val.length <=10)
                            return "خطا: تعداد کارکتر کمتر از 11";
                          else if (!val.contains("0"))
                            return "ساختار موبایل شما اشتباه می باشد.";
                          else
                            return null;
                        },
                      ),
                    ),
                  ]
              )
          ),
          SizedBox(height: 2,),
          Container(
            width: s.width*0.7,
            padding: EdgeInsets.only(right: 100,top:5),
            child:new RaisedButton(
              child: new Text("ثبت نام"),
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  sendData();
                  //_scaffoldKey.currentState.showSnackBar(new SnackBar(
                  //content: new Text("Your email: $_email and Password: $_password"),
                  //));
                }
              },
              color: Colors.white,
              highlightColor: Colors.white,
            ),
          ),
          /*Container(
            width: s.width*0.7,
            padding: EdgeInsets.only(right: 100,top:5),
            child:new RaisedButton(
              child: new Text("قبلا ثبت نام کرده ام"),
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  sendData();
                  //_scaffoldKey.currentState.showSnackBar(new SnackBar(
                  //content: new Text("Your email: $_email and Password: $_password"),
                  //));
                }
              },
              color: Colors.white,
              highlightColor: Colors.white,
            ),
          ),*/
        ],
      ),
    );
  }
}