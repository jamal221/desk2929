/*import 'package:desk2929/ticketlist.dart';
import 'package:flutter/material.dart';
import 'test123.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
test123 t=new test123();
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch:Colors.blue, //primary color for theme
        ),
        home: ChatPageMsg()
      //set the class here
    );
  }
}
List<Messages> msgs = <Messages>[];

class ChatPageMsg extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<ChatPageMsg> {
  var s;
  /*List<ChatUsers> chatUsers = [
    ChatUsers(text: "Jane Russel", secondaryText: "Awesome Setup", image: "images/userImage1.jpeg", time: "Now"),
    ChatUsers(text: "Glady's Murphy", secondaryText: "That's Great", image: "images/userImage2.jpeg", time: "Yesterday"),
    ChatUsers(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "images/userImage3.jpeg", time: "31 Mar"),
    ChatUsers(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "images/userImage4.jpeg", time: "28 Mar"),
    ChatUsers(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "images/userImage5.jpeg", time: "23 Mar"),
    ChatUsers(text: "Jacob Pena", secondaryText: "will update you in evening", image: "images/userImage6.jpeg", time: "17 Mar"),
    ChatUsers(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "images/userImage7.jpeg", time: "24 Feb"),
    ChatUsers(text: "John Wick", secondaryText: "How are you?", image: "images/userImage8.jpeg", time: "18 Feb"),
  ];*/


  @override
  Widget build(BuildContext context) {
    s = MediaQuery
        .of(context)
        .size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                      Container(
                        padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.pink[50],
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add,color: Colors.pink,size: 20,),
                            SizedBox(width: 2,),
                            Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.grey.shade100
                        )
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: msgs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ConversationList(
                    name: "jamal",
                    UserT:msgs[index].userText,
                    UserD:msgs[index].userDate,
                    AdminT:msgs[index].adminText,
                    AdminD:msgs[index].adminDate
                    isMessageRead: (index == 0 || index == 3)?true:false,
                  );
                },
              ),
            ],
          ),
        ),

        )
    );
  }
}
void getMsgData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mobileCooki= prefs.getString('mobile99');

  final String uri = t.getaddress()+"msglist2.php";
  //final Uri uri =Uri.http(t.getaddress(), 'msglist2.php');
  print("mobile for msg is  "+mobileCooki);
  var response = await http.post(uri, body: {
    "mobilemsg": mobileCooki,
  });


  if (response.statusCode == 200) {

    //String check1=json.decode(response.body);
    //print(check1);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    //print(items);
    List<Messages> listOfmsgs = items.map<Messages>((json) {
      return Messages.fromJson(json);
    }).toList();
    msgs.clear();

    for(int i=0;i<listOfmsgs.length;i++)
    {
      msgs.add(listOfmsgs[i]);
    }


    //print(listOfArticles[i].id_Article);
    //for(var zz in  listOfArticles)
    //  print(listOfArticles["id_Article"].toString());
  }
  else {
    throw Exception('خطا در مشاهده ی اطلاعات');
  }

}
class Messages {
  final String userText;
  final String adminText;
  final String userDate;
  final String adminDate;
  final String type;


  Messages({
    this.userText,
    this.adminText,
    this.userDate,
    this.adminDate,
    this.type,
  });

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      userText: json['msg'],
      type: json['statuse'],
      userDate: json['date1'],
      adminDate: json['date_response'],
      adminText: json['msg_response'],
    );
  }
}*/



