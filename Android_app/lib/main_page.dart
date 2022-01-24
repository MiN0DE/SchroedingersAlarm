import 'package:flutter/material.dart';
import 'package:flutter_login_ui/login_page.dart';
import 'package:http/http.dart' as http;
import 'circulation.dart';
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
  bool isConn = false;
  Future<bool> getdata() async{
    http.Response response = await http.get(Uri.http('retrorbit.spdns.de', '/provide_Data.php'));

    dynamic datafromserver = json.decode(response.body);
    _time = datafromserver["Time"];
    _latitude =datafromserver ["Latitude"];
    _longitude = datafromserver["Longitude"];

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
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Icon(Icons.menu),
            title: const Text(
              'SchrödingersAlarm',
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue,
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

            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Home', icon: Icon(Icons.home)),
                Tab(text: 'Status', icon: Icon(Icons.sensors)),
                Tab(text: 'Cartes', icon: Icon(Icons.location_on_outlined )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                 Image.asset('assets/images/heylo.PNG'),
                 CircularButton(),

                ]
          ),),



              Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: (isConn) ? Colors.red : Colors.green,
                      child: (isConn)
                          ? Icon(
                        Icons.wifi_off,
                        size: 100,
                      )
                          : Icon(
                        Icons.sensors,
                        size: 150,
                      ),
                    ),
                  ),
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
                ),],),),
              Center(child: Text('BIRDS')),
            ],
          ),
        ),
      ),
    );
  }
}
