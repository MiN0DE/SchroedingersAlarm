import 'package:flutter/material.dart';
import 'package:flutter_login_ui/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String _time = "";
  late String _latitude ="";
  late String _longitude = "";
  late Future<bool> data ;
  Future<bool> getdata() async{
    http.Response response = await http.get(Uri.http('retrorbit.spdns.de', '/provide_Data.php'));

    List<dynamic> datafromserver = json.decode(response.body);
    _time = datafromserver[0]["Time"];
    _latitude =datafromserver[0] ["Latitude"];
    _longitude = datafromserver[0]["Longitude"];

    return true ;
  }
  @override
  void initState() {
    data = getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SchrödingersAlarm',
      home: Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: const Text(
              'SchrödingersAlarm',
            ),
            actions: [
              Theme(
                data: Theme.of(context).copyWith(
                    textTheme: TextTheme().apply(bodyColor: Colors.black),
                    dividerColor: Colors.black,
                    iconTheme: IconThemeData(color: Colors.white)),
                child: PopupMenuButton<int>(
                  color: Colors.blue,
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text("Logout"),

                          ],
                        )),
                  ],
                  onSelected: (item) =>  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage ())),

                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.PNG",
                  height: 170,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                      child: Text(
                        'Save Mode',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      color: Colors.lightGreen,
                      textColor: Colors.white,
                      onPressed: () {})),
              Container(

                  alignment: Alignment.topLeft,
                  child: Text(
                    "  Informations:",
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  )),
              FutureBuilder(

                future: data,
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasData){
                    return Container(
                        height: 100.0,
                        width: 300.0,
                        color: Colors.transparent,

                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child:  new Text(
                            "Last time online:"+_time+"\n\Status: online\n",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ));
                  }
                  else if (snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.white,)
                    );
                  }
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    // Respond to button press
                  },
                  icon: Icon(Icons.assistant_navigation),
                  label: Text('live location', style: TextStyle(fontWeight: FontWeight.w900,
                      fontSize: 25
                      )),



                ),
              ),
            ],
          )),
    );

  }
}
