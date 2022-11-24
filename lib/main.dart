import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marloneobbank/network/config.dart';
import 'package:marloneobbank/theme/themeConstraints.dart';
import 'package:marloneobbank/theme/themeManager.dart';
import 'package:marloneobbank/widget/textField.dart';

import 'classes/seeallclass.dart';
import 'inviteClass.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Dio dio = Dio();
  late Response teamInviteResponse;
  late Map<String, dynamic> teamInviteMap;
  late Map<String, dynamic> contactsMap;
  late Map<String, dynamic> invitesMap;

  List<dynamic> contactList = [];
  List<dynamic> inviteList = [];
  bool  loadData = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getTeamInviteList();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Change Mode"),
            actions: [Switch(value: _themeManager.themeMode == ThemeMode.dark, onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
            })],
          ),
      backgroundColor: isDark ? Colors.black: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: loadData ? CircularProgressIndicator(): Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              // textWithStyle('Team', 'fontWeight.bold', 34.0, Colors.black, 'Heebo'),
              Text(
                'Teams',
                style: _textTheme.headline4?.copyWith(
                    color:isDark?Colors.white: Colors.black,fontWeight: FontWeight.w700,  fontSize: 34,fontFamily: 'Heebo')
              ),

              Icon(
                Icons.search,
                color: Color(0xFF76808A),
              ),
              // InkWell(onTap:(){
              //
              // },child: Icon(Icons.switch_camera_sharp, color: Color(0xFF76808A),))
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All people . ${contactList.length}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SeeAllClass(list: contactList)));
                },
                child: Text('See all',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0CABDF))),
              ),
            ],
          ),
          contactList.isEmpty
              ? Container(
                  child: Text('Invalid user'),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  // physics: ScrollPhysics(),
                  // shrinkWrap: true,
                  //  primary: true,
                  itemCount: 2,
                  //contactList.length,
                  itemBuilder: (context, index) {
                    var firstname = '';
                    var lastname = '';
                    if (contactList[index]['firstname'] == null ||
                        contactList[index]['firstname'].toString().isEmpty) {
                      firstname = 'Unknown';
                    } else if (contactList[index]['lastname'] == null ||
                        contactList[index]['lastname'].toString().isEmpty) {
                      lastname = 'name';
                    } else {
                      print('last name ${contactList[index]['lastname']}');
                      print('first name ${contactList[index]['firstname']}');
                      firstname = contactList[index]['firstname'];
                      lastname = contactList[index]['lastname'];
                    }
                    print('last name ${lastname}----');
                    return Column(children: [
                      SizedBox(
                        height: 8,
                      ),
                      Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 10, top: 17, bottom: 17, right: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1A62C6),
                                    border: Border.all(
                                        width: 1, color: Color(0xFF1A62C6)),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    // color: AppColors().orange,
                                  ),
                                  height: 40,
                                  width: 40,
                                  child: Text(
                                    '${firstname[0].toUpperCase()} ${lastname[0].toUpperCase()}',
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Heebo'),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$firstname $lastname',
                                      style: _textTheme.headline4?.copyWith(
                                          color:isDark?Colors.white: Colors.black,fontWeight: FontWeight.w600,  fontSize: 16,fontFamily: 'NotoSans')

                                    ),
                                    Text(contactList[index]['isactive']
                                        ? 'Active'
                                        : 'Inavtive', style: _textTheme.headline4?.copyWith(
                                        color:isDark?Colors.grey: Colors.white,fontWeight: FontWeight.w400,  fontSize: 12,fontFamily: 'NotoSans')
                                      ,)
                                  ],
                                ),
                                Spacer(),
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '${contactList[index]['role_name'].toString()}',
                                      textAlign: TextAlign.right,
                                      style:  _textTheme.headline4?.copyWith(
                    color:isDark?Colors.white : Colors.black,fontWeight: FontWeight.w400,  fontSize: 14,fontFamily: 'NotoSans')



                                    ))
                              ],
                            ),
                          )),
                    ]);
                  }),
          SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Invited people . ${inviteList.length}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
              ),
              Text('See all',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0CABDF))),
            ],
          ),
          ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              // physics: ScrollPhysics(),
              // shrinkWrap: true,
              //  primary: true,
              itemCount: 2,
              //inviteList.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFAC816E),
                            border:
                                Border.all(width: 1, color: Color(0xFFAC816E)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            // color: AppColors().orange,
                          ),
                          margin:
                              EdgeInsets.only(left: 15, top: 17, bottom: 17),
                          height: 40,
                          width: 40,
                          child: const Text(
                            'EJ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Heebo'),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Container(width: 240,
                              child: Text(
                                '${inviteList[index]['email']}',
                                style:  _textTheme.headline4?.copyWith(
                                    color:isDark?Colors.white: Colors.black,fontWeight: FontWeight.w600,  fontSize: 16,fontFamily: 'NotoSans')



                              ),
                            ),
                            Text('${inviteList[index]['config_name']}',

                                style: _textTheme.headline4?.copyWith(
                                    color:isDark?Colors.grey : Colors.black,fontWeight: FontWeight.w400,  fontSize: 12,fontFamily: 'NotoSans')
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]);
              }),
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Loans',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.money),
              label: 'Contracts',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teams',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_mark),
            label: 'Chats',
            backgroundColor: Colors.white,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        iconSize: 25,
        onTap: _onItemTapped,
        elevation: 5,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
      floatingActionButton: FloatingActionButton( backgroundColor: Colors.blue ,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InviteClass()));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    ));
  }

  void getTeamInviteList() async {
    try {
      dio.options.headers["authtoken"] =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY2OTI5NjMxNSwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjY5Mjk2MzE1LCJleHAiOjE2NjkyOTk5MTUsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.rJSrb0cuPd6KdYkS6Y7QpDGVPjcWcBbljZxLirgwg04LSTQvsp2MBsa2bk1OQ7h4HIgLeZI_Ut05vDaFOA-FTeK0pFaCaqxJKgLU3VDn1Tkub30q6Wi0Q__AQVAaZcMVwfwHKkDCBYvmAO2XlmBkRf9qx8KtsZTV4scd7h8tFNQ3B7HOtD1NsIj9U-8PTqfS9ZMoreR-xicCeD0gz200PWwHYgwlUe4L2Te5vOD2AuUq8-Gl2YgFDzWWQY_cKTxOnZS6UVLk9YYb5-yks5zGKXFxSqQSLyhdk1TNqLHXAmyAG1HYrm59DjFOsnE0l3ppmi9akPgV2XuACvRQNVywGA";
      teamInviteResponse = await dio.get(Config.teamInviteUrl);
      teamInviteMap = json.decode(teamInviteResponse.toString());

      if (teamInviteResponse.statusCode == 200) {
        loadData = false;
        if (teamInviteMap['error_flag'] == 'SUCCESS') {
          var data = teamInviteMap['data'];
          print('data is $data');
          contactList.addAll(teamInviteMap['data']['contacts']);
          inviteList.addAll(teamInviteMap['data']['invites']);
          print('data is contacts ${contactList.length}');
          setState(() {});
        }
      } else {
        print('data is else ');
      }
    } on DioError catch (e) {
      // print('error code ${e.response.statusCode}');

      print('error msg get cart ${e.message} ddd ${e.response?.data}');
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          // loadData = false;
          // pagenotfound = true;
          setState(() {
            print('data error ${e.response?.data['token']}');

            Fluttertoast.showToast(msg: '${e.response?.data['token']}');
          });
        } /*else if (e.response?.data['status'] == 'Token is Expired' ||
        e.response.data['status'] == 'Token is Invalid') {
      print('token is invalid 113 ${e.response.data['status']}');

    }*/

      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print('error ' + e.message);
      }
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        //  Navigator.push(context, MaterialPageRoute(builder: (context) => NoInternetClass()));
      }
    }
  }
}
