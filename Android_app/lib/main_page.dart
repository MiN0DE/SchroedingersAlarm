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
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                  Container(
                      margin: EdgeInsets.all(25),
                      child: FlatButton(
                          child: Text(
                            'Save Mode',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          color: Colors.lightGreen,
                          textColor: Colors.white,
                          onPressed: () {})
                  ),
                ]
          ),),



              Center(child: Text('CATS')),
              Center(child: Text('BIRDS')),
            ],
          ),
        ),
      ),
    );
  }
}
