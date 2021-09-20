import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'header.dart';
import 'footer.dart';

test123 t=new test123();
class UploadImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
      title: "آپلود کارت ملی یا کارت شناسایی",
      home: UploadImageDemo(),
    );

  }
}
class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "ارسال تصویر شناسایی";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  //

  String uploadEndPoint = t.getaddress()+"UploadImage.php";
  //Uri uploadEndPoint = Uri.http(t.getaddress(), 'UploadImage.php');
  //static final String uploadEndPoint =      'http://localhost/flutter_test/upload_image.php';
  Future<File> file;
  //File file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'مشکل در ارسال تصویر';

  chooseImage() {
    setState(() {
      //file=ImagePicker.platform.pickImage(source: ImageSource.gallery);
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('در حال ارسال تصویر...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }
String mobileCooki;
  upload (String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileCooki= prefs.getString('mobile99');
    print(mobileCooki);
    print(fileName);
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
      "mob":mobileCooki,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'مشکل در انتخاب تصویر',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'تصویری هنوز انتخاب نشده است.',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child:  Scaffold(
          appBar: AppBar(
            //title: Text("ارسال کارت ملی یا کارت شناسایی"),
            //title: Image.asset('assets/images/Banner_desk.png', scale: 1,),
            toolbarHeight: 100,
            title:header(),
            backgroundColor: Colors.white,
          ),
          body: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                OutlineButton(
                  onPressed: chooseImage,
                  child: Text('انتخاب تصویر'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                showImage(),
                SizedBox(
                  height: 20.0,
                ),
                OutlineButton(
                  onPressed: startUpload,
                  child: Text('ارسال تصویر'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
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
                    child: footerme(),
                  ),

                ]
            ),
            height: 60.0,
            color: Colors.red,
          ),
        )
    )
    ;
  }
}