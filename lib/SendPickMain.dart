import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'test123.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'header.dart';
import 'footer.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'links.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

test123 t = new test123();
var str11 = t.getaddress();
var str22 = "UploadImageAll.php";
var str_image_num = "Image_Assessment.php";
var image2;
//var count_image1;
late int ShowSendPicBtn;
late String fileName;
var Screen_mesure;
var counter_images = 0;

final Uri uploadEndPoint = Uri.parse('$str11$str22');
final Uri ImageAssess = Uri.parse('$str11$str_image_num');
final ImagePicker _picker = ImagePicker();

class UploadImageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black87),
            hintStyle: TextStyle(color: Colors.deepPurple),
          )),
      title: "آپلود تصاویر",
      home: UploadImageDemo(),
    );
  }
}

var s;
List<Images> Imgs = <Images>[];

enum ImageSourceType { gallery, camera }

class UploadImageDemo extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, var type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  }

  var count_image1;
  count_image(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobileCooki = prefs.getString('mobile99') ?? '';
    var request = http.MultipartRequest('POST', ImageAssess);
    request.fields['mob'] = mobileCooki;
    var response = await http.post(ImageAssess, body: {
      "mob": mobileCooki,
    });
    print(response.body);
    if (response.statusCode == 200) {
      //print(response.body);
      //print("Image Calculated here");
      count_image1 = response.body;
      (context as Element).markNeedsBuild();
    } else {
      //print(response.body);
      //print("Image isn't in Database");
      count_image1 = response.body;
      (context as Element).markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    //count_image(context);
    var s = (MediaQuery.of(context).size);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: header(),
          backgroundColor: Colors.white,
        ),
        body: Center(
          heightFactor: s.height - 300,
          //padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                width: s.width * .6,
                margin: EdgeInsets.only(right: 15, left: 10, top: 5),
                decoration: BoxDecoration(
                    color: (count_image1 == '-1')
                        ? Colors.greenAccent
                        : Colors.red,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10), bottom: Radius.circular(10))),
                child: Text(
                  "توجه: هر همکار حداکثر 10 تصویر را می تواند در پروفایل خود داشته باشد. در صورت ارسال بیشتر موارد قبلی را حذف نمایید. با تشکر.",
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text(
                  "انتخاب تصویر از گالری",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.gallery);
                },
              ),
              MaterialButton(
                color: Colors.deepOrange,
                child: Text(
                  "انتخاب تصویر از دوربین",
                  style: TextStyle(
                      color: Colors.amber, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _handleURLButtonPress(context, ImageSourceType.camera);
                },
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
                  //width: 50,

                  child: footerme(),
                ),
              ]),
          height: 60.0,
          color: Colors.amberAccent,
        ),
      ),
    );
    //getrow();
  }

  UploadImageDemo() : super();
  final String title = "ارسال تصویر شناسایی";
}

class ImageFromGalleryEx extends StatefulWidget {
  final String type;
  ImageFromGalleryEx(this.type);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  late File _image_new;
  final picker_new = ImagePicker();

  var imagePicker;
  var type;

  ImageFromGalleryExState(this.type);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    ShowSendPicBtn = 0;
    getImageData();
    //getrow(context);
    //count_image1=0;
  }

  late String mobileCooki;
  Future upload(String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileCooki = prefs.getString('mobile99')!;
    var request = http.MultipartRequest('POST', uploadEndPoint);
    request.fields['name'] = fileName;
    request.fields['mob'] = mobileCooki;
    var pic = await http.MultipartFile.fromPath("image", _image_new.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "تصویر با موفقیت ارسال شد.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      setState(() {});
      print("Image ersal shod");
    } else {
      Fluttertoast.showToast(
          msg: "در ارسال تصویر مشکلی روی داده است. دوباره سعی نمایید.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    //count_image_for_second_page(context);
    var s = (MediaQuery.of(context).size);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: header(),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 6,
            ),
            /*Container(
                width: s.width*.6 ,
                margin: EdgeInsets.only(right: 15, left: 10, top:5),
                decoration: BoxDecoration(
                    color:Colors.greenAccent,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                        bottom: Radius.circular(10)
                    )
                ),
                child: Text("تعداد تصویر ارسالی شما:    "+count_image_for_second_page_val
                  ,style: TextStyle(color: Colors.black,fontSize: 18.0),
                  textAlign: TextAlign.start,
                ),
              ),*/
            MaterialButton(
              color: Colors.blue,
              child: Text(
                "جهت مشاهده ی تعداد تصویر ارسالی کلیک نمایید",
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                count_image_for_second_page(context);
              },
            ),
            Container(
              child: Text(type == ImageSourceType.camera
                  ? "انتخاب تصویر از دوربین"
                  : "انتخاب تصویر از گالری"),
            ),
            Center(
                child: Column(
              children: [
                Container(
                  //height: s.height-700,
                  child: GestureDetector(
                    onTap: () async {
                      var source = type == ImageSourceType.camera
                          ? ImageSource.camera
                          : ImageSource.gallery;
                      var PickedImage = await imagePicker.pickImage(
                          source: source,
                          maxHeight: 600.0,
                          maxWidth: 800.0,
                          imageQuality: 70,
                          preferredCameraDevice: CameraDevice.front);
                      setState(() {
                        _image_new = File(PickedImage.path);
                        image2 = PickedImage;
                        ShowSendPicBtn = 1;
                        fileName = PickedImage.path.split('/').last;
                      });
                    },
                    child: Container(
                      width: 200,
                      height: 140,
                      decoration: BoxDecoration(color: Colors.red[200]),
                      child: _image_new != null
                          ? Image.file(
                              _image_new,
                              // width: 200.0,
                              // height: 200.0,
                              fit: BoxFit.fitHeight,
                            )
                          : Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                              // width: 200,
                              // height: 200,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                Container(
                    child: count_image_for_second_page_val == '10'
                        ? Text(
                            "تعداد تصویر ارسالی بیش از حد مجاز می باشد لطفا ابتدا تعدادی را حذف نمایید.",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.0),
                            textAlign: TextAlign.start,
                          )
                        : MaterialButton(
                            color: Colors.blue,
                            child: Text(
                              "ارسال تصویر انتخاب شده",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w300),
                            ),
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg:
                                      "در حال ارسال تصویر ، لطفا صیر نمایید. ...",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              upload(fileName);
                            },
                          )),
              ],
            )
                //padding: EdgeInsets.all(30.0),
                ),
            getrow(context),
          ],
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
              ]),
          height: 60.0,
          color: Colors.amberAccent,
        ),
      ),
    );
  }

  Widget getrow(BuildContext context) {
    s = (MediaQuery.of(context).size);
    counter_images = 0;
    print("Imgs.length is" + Imgs.length.toString());
    if (Imgs.length != 0) {
      return Container(
          //color: Colors.green,
          //height: Screen_mesure.height-500,
          height: 400,
          child: Scrollbar(
              thickness: 10,
              //sisAlwaysShown: true,
              child: ListView.separated(
                //padding: const EdgeInsets.all(0),
                itemCount: Imgs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                //physics: NeverScrollableScrollPhysics(),

                itemBuilder: (BuildContext context, int index) {
                  counter_images += 1;
                  return Container(
                    margin: EdgeInsets.all(5),
                    width: s.width * 0.95,
                    //width: 80,
                    child: Column(
                      children: [
                        Container(
                            color: (Image_id == ('${Imgs[index].id_for_image}'))
                                ? (Colors.green)
                                : Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  height: 1,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    width: 20,
                                    margin: EdgeInsets.only(right: 5, left: 3),
                                    child: Text(counter_images.toString()),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    width: s.width * 0.4,
                                    //width: 80,
                                    child: Image.network(
                                      t.getaddress() +
                                          '${Imgs[index].pic_address}',
                                      width: s.width * 0.48,
                                      height: 100,
                                    ),
                                    //child: Text("jamal"),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 60),
                                    decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10),
                                            bottom: Radius.circular(10))),
                                    width: s.width * 0.15,
                                    child: Text(
                                      '${Imgs[index].date_inserted}',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    iconSize: 22.0,
                                    color: Colors.red,
                                    onPressed: () {
                                      delimage('${Imgs[index].id_for_image}');
                                    }),
                                IconButton(
                                    icon: Icon(Icons.download_sharp),
                                    iconSize: 22.0,
                                    color: Colors.red,
                                    onPressed: () {
                                      _download(Imgs[index].pic_address);
                                      // delimage('${Imgs[index].id_for_image}')
                                      // print(Imgs[index].pic_address);
                                    }),
                                IconButton(
                                    icon: Icon(Icons.attach_file),
                                    iconSize: 22.0,
                                    color: Colors.red,
                                    onPressed: () {
                                      SetProfile('${Imgs[index].id_for_image}');
                                    }),
                                Container(
                                  // this blank container used for extra space form left
                                  margin: EdgeInsets.only(left: 30),
                                ),
                              ],
                            )),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 7,
                ),
              )));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/images/darkhastKHarid.png',
            height: 100,
            width: 300,
          ),
          Container(
            child: Text(
              "در حال حاضر هیچ پیامی وجود ندارد.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }
  }

  Future<dynamic> delimage(String ImageID) async {
    final String apiEndpoint = t.getaddress() + "Image_Delete.php";
    final Uri uri = Uri.parse(apiEndpoint);
    var response = await http.post(uri, body: {
      "id_image": ImageID,
    });
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "تصویر با موفقیت حذف شد.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      //getrow(context);
      //UploadImageMain();
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "در حذف تصویر مشکلی رخ داده لطفا یکبار دیگر سعی نمایید.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      getrow(context);
    }
  }

  Future<dynamic> SetProfile(String ImageID) async {
    final String apiEndpoint = t.getaddress() + "Profile_image.php";
    final Uri uri = Uri.parse(apiEndpoint);
    print("ImageID is that: " + ImageID);
    var response = await http.post(uri, body: {
      "id_image": ImageID,
    });
    if (response.statusCode == 200) {
      setState(() {});
      Fluttertoast.showToast(
          msg: "تصویر با موفقیت به پروفایل اضافه شد.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      //getrow(context);
      //UploadImageMain();
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg:
              "در اضافه کردن تصویر برای پروفایل مشکلی رخ داده است دوباره اقدام نمایید.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      getrow(context);
    }
  }

  void getImageData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mobileCooki = prefs.getString('mobile99')!;

    //final String uri = t.getaddress()+"msglist2.php";
    final String apiEndpoint = t.getaddress() + "Image_View.php";
    final Uri uri = Uri.parse(apiEndpoint);
    //final Uri uri =Uri.http(t.getaddress(), 'msglist2.php');
    print("mobile for msg is  " + mobileCooki);
    var response = await http.post(uri, body: {
      "mob": mobileCooki,
    });

    if (response.statusCode == 200) {
      //String check1=json.decode(response.body);
      //print(check1);
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      //print(items);
      List<Images> listOfImages = items.map<Images>((json) {
        return Images.fromJson(json);
      }).toList();
      Imgs.clear();

      for (int i = 0; i < listOfImages.length; i++) {
        Imgs.add(listOfImages[i]);
      }
      setState(() {
        //arzDataSource = ArzDataSource(arzdata: arzs);
      });
      //print(listOfArticles[i].id_Article);
      //for(var zz in  listOfArticles)
      //  print(listOfArticles["id_Article"].toString());
    } else {
      throw Exception('خطا در مشاهده ی اطلاعات');
    }
  }

  var count_image_for_second_page_val;
  count_image_for_second_page(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mobileCooki = prefs.getString('mobile99');
    var request = http.MultipartRequest('POST', ImageAssess);
    request.fields['mob'] = mobileCooki ?? '';
    var response = await http.post(ImageAssess, body: {
      "mob": mobileCooki,
    });
    print(response.body);
    if (response.statusCode == 200) {
      count_image_for_second_page_val = response.body;
      (context as Element).markNeedsBuild();
      Fluttertoast.showToast(
          msg: count_image_for_second_page_val,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      count_image_for_second_page_val = response.body;
      (context as Element).markNeedsBuild();
      Fluttertoast.showToast(
          msg: count_image_for_second_page_val,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class Images {
  final String id_for_image;
  final String name_user;
  final String pic_address;
  final String date_inserted;
  Images({
    required this.id_for_image,
    required this.name_user,
    required this.pic_address,
    required this.date_inserted,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id_for_image: json['id'],
      name_user: json['name'],
      pic_address: json['pic_add'],
      date_inserted: json['date_insert'],
    );
  }
}

Future<void> _download(String Image_Adrress) async {
  Image_Adrress = Image_Adrress.replaceAll('..', '');
  await canLaunch("http://desk2929.ir" + Image_Adrress)
      ? await launch("http://desk2929.ir" + Image_Adrress)
      : throw 'عدم وجود فایل در مسیر $Image_Adrress';
}
