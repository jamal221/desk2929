/*import 'package:flutter/material.dart';
import 'chatPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch:Colors.blue, //primary color for theme
        ),
        home: HomePageMsg()
      //set the class here
    );
  }
}

class HomePageMsg extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<HomePageMsg> {
  var s;

  @override
  Widget build(BuildContext context) {
    s = MediaQuery
        .of(context)
        .size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            child: ChatPage(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text("Chats"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_work),
                title: Text("Channels"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box),
                title: Text("Profile"),
              ),
            ],
          ),

        )
    );
  }
}*/


