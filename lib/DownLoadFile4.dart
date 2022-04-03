import 'dart:convert';
import 'dart:io';
import 'package:desk2929/Version_Alarm.dart';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'test123.dart';
import 'footer.dart';
import 'package:url_launcher/url_launcher.dart';

test123 t=new test123();
var s;
class DownLoadFile4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'دانلود میز خدمت',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'نصب ورژن جدید'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
  //_MyHomePageState createState() => _MyHomePageState();
}

class WriteSQLdataState extends State<MyHomePage> {
  final String _fileUrl = t.getaddress()+"/files/newest_version.apk";
  //final String _fileUrl = "desk2929.ir/versions/newest_version.apk";
  final String _fileName = "desk2929_2.apk";
  bool shouldEnable;
  final Dio _dio = Dio();

  String _progress = "_";

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    shouldEnable=true;
    super.initState();

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    //final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings();

    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _onSelectNotification);
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        priority: Priority.high,
        importance: Importance.max
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails();
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'موفق' : 'شکست',
        isSuccess ? 'فایل با موفقیت دانلود شد!' : 'تعدادی مشکل در فرایند دانلود روی داده است.',
        platform,
        payload: json
    );
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await DownloadsPathProvider.downloadsDirectory;
    }

    // in this example we are using only Android and iOS so I can assume
    // that you are not trying it for other platforms and the if statement
    // for iOS is unnecessary

    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        shouldEnable=false;
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(
          _fileUrl,
          savePath,
          onReceiveProgress: _onReceiveProgress
      );
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result);
    }
  }
  Future<void> _download() async {
    await canLaunch(_fileUrl) ? await launch(_fileUrl) : throw 'Could not launch $_fileUrl';
  }
  /*Future<void> _download() async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      await _startDownload(savePath);
    } else {
      // handle the scenario when user declines the permissions
    }
  }*/

  @override
  Widget build(BuildContext context) {
    s=MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
   child: Scaffold(
     body: SingleChildScrollView( //enable scrolling, when keyboard appears,
       // hight becomes small, so prevent overflow
       child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children:[
             SizedBox(height: 10,),
             Container(
               height: 100,
               color: Color.fromARGB(255, 230, 230, 230),
               //child: header()
               child: Image.asset('assets/images/Banner_desk.png', scale: 1,),
             ),
         Container(
             height: s.height-110,
             decoration: const BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.center,
                 end:
                 Alignment.centerRight, // 10% of the width, so there are ten blinds.

                 colors: <Color>[

                   Color.fromARGB(255, 39, 206, 137),
                   Color.fromARGB(255, 28, 30, 79)
                 ], // red to yellow
                 //tileMode: TileMode.mirror, // repeats the gradient over the canvas
               ),
             ),
           child: Column(
             children:<Widget> [
               Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [

                     Center(
                       child: Text("دانلود ورژن جدید",style: TextStyle(color: Colors.white,fontSize: 22.0,fontWeight: FontWeight.bold),),
                     ),
                     Container(
                       child: IconButton(
                         padding: EdgeInsets.only(right: 250),
                         icon: Icon(
                             Icons.arrow_back_ios_new_rounded,
                           ),
                             iconSize: 50,
                             color: Colors.green,
                             splashColor: Colors.purple,
                             onPressed: () {
                               Navigator.push(context,MaterialPageRoute(builder: (context) => VersionAlarm()));
                             },
                       ),
                     ),

                   ],
                 ),
               ),

               Divider(color: Colors.white,),
               SizedBox(height: 20),
               Container(
                 child: Column(

                   children: <Widget>[
                     Container(
                         color: Colors.white,
                         width: s.width*0.7,
                         padding: EdgeInsets.all(20),
                         child: Column(children: <Widget>[
                           SizedBox(height: 10),


                           Container(
                             margin: EdgeInsets.only(top: 20),
                             width: s.width*0.8,
                             child: Text("لطفا بعد از اتمام دانلود به پوشه فایل رفته و پوشه دانلود را پیدا کنید، داخل این پوشه ورژن جدید موجود می باشد."),
                           ),

                           /*Container(
                             width: s.width*0.7,
                             padding: EdgeInsets.only(right: 100,top:5),
                             child:new RaisedButton(
                               child: new Text("دانلود ورزن جدید"),
                               onPressed: (){
                                 Navigator.push(context,MaterialPageRoute(builder: (context) => DownLoadFile4()));
                               },
                               color: Colors.white,
                               highlightColor: Colors.white,
                             ),
                           ),*/
                           Container(
                             width: s.width*0.7,
                             padding: EdgeInsets.only(right: 100,top:5),
                             child:new RaisedButton(
                               child: new Text("دانلود ورژن جدید"),
                              // onPressed: _download,
                               onPressed: shouldEnable ? _download : null,
                               color: Colors.green,
                               highlightColor: Colors.white,
                             ),

                           ),
                           SizedBox(height: 10,),
                           Container(
                             child:Text(
                               '$_progress',
                               //style: Theme.of(context).textTheme.display1,
                                 style: TextStyle(color: Colors.green,fontSize: 40.0)
                             ),

                           )


                         ],
                         )
                     )


                   ],
                 ),
               ),
             ],
           ),
         ),

           ]
       )
     ),
     bottomNavigationBar: new Container(
       //child: footerme(),
       child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             Container(
               //width: s.width,
               child: footerme(),
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
       color: Colors.red,
     ),



    )
    );
  }
}
