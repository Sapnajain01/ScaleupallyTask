import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'network/config.dart';

class InviteClass extends StatefulWidget {
  const InviteClass({Key? key}) : super(key: key);

  @override
  State<InviteClass> createState() => _InviteClassState();
}

class _InviteClassState extends State<InviteClass> {
  final TextEditingController _emailController = TextEditingController();

  static const values = <String>[
    'Admin',
    'Approver',
    'Preparer',
    'Viewer',
    'Employee'
  ];

  String selectedRole = 'Admin';
  final selectedColor = Color(0xFFE9EEF0);
  final selectedRoleColor = Color(0xFF0CABDF);
  final unselectedroleColor = Color(0xFF75808A);
  final unselectedColor = Colors.white;
  late StateSetter _setState;
  Dio dio = Dio();
  late Map<String, dynamic> inviteMap;

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
        child: Scaffold(
            backgroundColor: isDark ? Colors.black: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: isDark ? Colors.white: Colors.black,
              ),
              elevation: 0,
              brightness: Brightness.dark,
              // or use Brightness.dark
              backgroundColor: isDark ? Colors.black: Colors.white,
              titleSpacing: 0,

              automaticallyImplyLeading: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invite',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Heebo'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xFF232323): Color(0xFFE9EEF0),
                      border: Border.all(width: 1, color: isDark ? Color(0xFF232323):Color(0xFFE9EEF0)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      // color: AppColors().orange,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Businness email',
                            style: TextStyle(
                                color: Color(0xFF787F89),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'NotoSans'),
                          ),
                          TextField(
                            style:
                            _textTheme.headline4?.copyWith(
                                color:isDark?Colors.white: Colors.black,fontWeight: FontWeight.w400,  fontSize: 14,fontFamily: 'NotoSans')

                             ,
                            minLines: 1,
                            maxLines: 1,
                            controller: _emailController,
                            onChanged: (String text) {
                              setState(() {});
                            },
                            decoration: const InputDecoration.collapsed(
                              hintText: "Enter email ",

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(24.0),
                            ),
                          ),
                          context: context,
                          isScrollControlled: true,
                          useRootNavigator: true,
                          builder: (context) =>
                              StatefulBuilder(builder: (context, setstate) {
                                _setState = setstate;
                                return Wrap(children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 8, left: 16, right: 16),
                                    //height: 90,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Team roles',
                                              style:  _textTheme.headline4?.copyWith(
                                                  color:isDark?Colors.white: Colors.black,fontWeight: FontWeight.w600,  fontSize: 16,fontFamily: 'NotoSans')


                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: values.map((value) {
                                                  final selected =
                                                      this.selectedRole ==
                                                          value;
                                                  final bgcolor = selected
                                                      ? isDark ? Color(0xFF232323) : selectedColor
                                                      : isDark ? Color(0xFF232323) :unselectedColor;
                                                  final rolecolor = selected
                                                      ? selectedRoleColor
                                                      : unselectedroleColor;
                                                  return InkWell(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 55,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: bgcolor,
                                                          border: Border.all(
                                                              width: 1,
                                                              color: bgcolor),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(10),
                                                          ),
                                                          // color: AppColors().orange,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Text(
                                                            value,
                                                            style: TextStyle(
                                                                color:
                                                                    rolecolor,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'NotoSans'),
                                                          ),
                                                        )),
                                                    onTap: () {
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                      // selectedRole = value;
                                                      _setState(() {
                                                        selectedRole = value;
                                                      });
                                                    },
                                                  );
                                                }).toList())
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]);
                              }));
                    },
                    child: Container(

                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                        color: isDark ? Color(0xFF232323): Color(0xFFE9EEF0),
                        border: Border.all(width: 1, color: isDark ? Color(0xFF232323): Color(0xFFE9EEF0),),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        // color: AppColors().orange,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedRole,
                              style: TextStyle(
                                  color: unselectedroleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'NotoSans'),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ]),
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: MaterialButton(
                              onPressed: () {},
                              child: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF0CABDF).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          1, 10), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                    child: Text("Continue",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white)),
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(EdgeInsets.all(15)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF0CABDF)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF0CABDF)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                  color: Color(0xFF0CABDF),
                                                )))),
                                    onPressed: () {
                                      if (_emailController.text.isEmpty) {
                                        Fluttertoast.showToast(msg: 'Please enter email',
                                            toastLength: Toast.LENGTH_LONG);
                                      } else {
                                        //Fluttertoast.showToast(msg: 'Please enter sdsdsds');
                                        var roleId = 1;
                                        if (selectedRole.contains('Approver')) {
                                          roleId = 2;
                                        } else if (selectedRole
                                            .contains('Preparer')) {
                                          roleId = 3;
                                        } else if (selectedRole.contains('Viewer')) {
                                          roleId = 4;
                                        } else if(selectedRole.contains('Employee')){
                                          roleId = 5;
                                        } else {

                                          sendInvite(_emailController.text.trim(),roleId);
                                        }
                                      }
                                    }),
                              )))),
                ],
              ),
            )));
  }

  void sendInvite(String trim, int roleId) async {

    var formData = FormData.fromMap({
      'email': trim,
      'role': roleId,
    });

    try {
      dio.options.headers["authtoken"] =
      "eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY2OTI5NjMxNSwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjY5Mjk2MzE1LCJleHAiOjE2NjkyOTk5MTUsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.rJSrb0cuPd6KdYkS6Y7QpDGVPjcWcBbljZxLirgwg04LSTQvsp2MBsa2bk1OQ7h4HIgLeZI_Ut05vDaFOA-FTeK0pFaCaqxJKgLU3VDn1Tkub30q6Wi0Q__AQVAaZcMVwfwHKkDCBYvmAO2XlmBkRf9qx8KtsZTV4scd7h8tFNQ3B7HOtD1NsIj9U-8PTqfS9ZMoreR-xicCeD0gz200PWwHYgwlUe4L2Te5vOD2AuUq8-Gl2YgFDzWWQY_cKTxOnZS6UVLk9YYb5-yks5zGKXFxSqQSLyhdk1TNqLHXAmyAG1HYrm59DjFOsnE0l3ppmi9akPgV2XuACvRQNVywGA";      dio.options.contentType= Headers.formUrlEncodedContentType;
    //  dio.options.headers["Content-Type"] = "application/x-www-form-urlencoded";
    Response  inviteResponse = await dio.post(Config.inviteMemberUrl,
      data: {'email': trim,
      'role': roleId},
       // options: Options(contentType: Headers.formUrlEncodedContentType),
        //options: Options(headers: {'Authorization': 'Bearer $auth_token'})
      );
      inviteMap = json.decode(inviteResponse.toString());
      if (inviteResponse.statusCode == 200 || inviteResponse.statusCode == 201) {
        if (inviteMap['error_flag'] == 'SUCCESS') {
          setState(() {
            Fluttertoast.showToast(msg: '${inviteMap['message']}');
            //dispose();
          });
        } else if(inviteMap['error_flag'] == 'EMAIL_EXISTS'){
          setState(() {
            Fluttertoast.showToast(msg: '${inviteMap['message']}');
          });
        }
      } else {
        print('data is else ${inviteResponse.statusCode}');
      }
    }
    on DioError catch (e) {
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
      }}
    }
  }