import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Apply Item Filter on JSON ListView')
        ),
        body: MainListView(),
      ),
    );
  }
}

class Studentdata {
  int studentID;
  String studentName;
  int studentPhoneNumber;
  String studentSubject;

  Studentdata({
    this.studentID,
    this.studentName,
    this.studentPhoneNumber,
    this.studentSubject
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
        studentID: json['id'],
        studentName: json['student_name'],
        studentPhoneNumber: json['student_phone_number'],
        studentSubject: json['student_class']

    );
  }
}

class MainListView extends StatefulWidget {

  MainListViewState createState() => MainListViewState();

}

class MainListViewState extends State {

  final String apiURL = 'https://flutter-examples.000webhostapp.com/getStudentInfo.php';

  Future<List<Studentdata>> fetchStudents() async {

    var response = await http.get(apiURL);

    if (response.statusCode == 200) {

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  navigateToNextActivity(BuildContext context, int dataHolder) {

    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => SecondScreenState(dataHolder.toString())
        )
    );

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Studentdata>>(
      future: fetchStudents(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator()
        );

        return ListView(
          children: snapshot.data
              .map((data) => Column(children: <Widget>[
            GestureDetector(
              onTap: (){navigateToNextActivity(context, data.studentID);},
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
                        child: Text(data.studentName,
                            style: TextStyle(fontSize: 21),
                            textAlign: TextAlign.left))

                  ]),),

            Divider(color: Colors.black),
          ],))
              .toList(),
        );
      },
    );
  }
}

class SecondScreenState extends StatefulWidget {
  final String idHolder;
  SecondScreenState(this.idHolder);
  @override
  State<StatefulWidget> createState() {
    return SecondScreen(this.idHolder);
  }
}

class SecondScreen extends State<SecondScreenState> {

  final String idHolder ;

  SecondScreen(this.idHolder);

  // API URL
  var url = 'https://flutter-examples.000webhostapp.com/filter/GetStudent.php';

  Future<List<Studentdata>> fetchStudent() async {

    var data = {'id': int.parse(idHolder)};

    var response = await http.post(url, body: json.encode(data));

    if (response.statusCode == 200) {

      print(response.statusCode);

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: Text('Showing Selected Item Details'),
                automaticallyImplyLeading: true,
                leading: IconButton(icon:Icon(Icons.arrow_back),
                  onPressed:() => Navigator.pop(context, false),
                )
            ),
            body: FutureBuilder<List<Studentdata>>(
              future: fetchStudent(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) return Center(
                    child: CircularProgressIndicator()
                );

                return ListView(
                  children: snapshot.data
                      .map((data) => Column(children: <Widget>[
                    GestureDetector(
                      onTap: (){print(data.studentName);},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                                child: Text('ID = ' + data.studentID.toString(),
                                    style: TextStyle(fontSize: 21))),

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('Name = ' + data.studentName,
                                    style: TextStyle(fontSize: 21))),

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('Phone Number = ' + data.studentPhoneNumber.toString(),
                                    style: TextStyle(fontSize: 21))),

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text('Class = ' + data.studentSubject,
                                    style: TextStyle(fontSize: 21))),

                          ]),)
                  ],))
                      .toList(),
                );
              },
            )
        ));
  }
}