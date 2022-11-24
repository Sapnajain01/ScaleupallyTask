import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeAllClass extends StatefulWidget {

final List list;
   SeeAllClass({Key? key, required this.list}) : super(key: key);

  @override
  State<SeeAllClass> createState() => _SeeAllClassState();
}

class _SeeAllClassState extends State<SeeAllClass> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // physics: ScrollPhysics(),
        // shrinkWrap: true,
        //  primary: true,
        itemCount: widget.list.length,
        //contactList.length,
        itemBuilder: (context, index) {
          var firstname = '';
          var lastname = '';
          if (widget.list[index]['firstname'] == null ||
              widget.list[index]['firstname'].toString().isEmpty) {
            firstname = 'Unknown';
          } else if (widget.list[index]['lastname'] == null ||
              widget.list[index]['lastname'].toString().isEmpty) {
            lastname = 'name';
          } else {
            print('last name ${widget.list[index]['lastname']}');
            print('first name ${widget.list[index]['firstname']}');
            firstname = widget.list[index]['firstname'];
            lastname = widget.list[index]['lastname'];
          }
          print('last name --${lastname}----');
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
                          Text(
                            '$firstname $lastname',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'NotoSans'),
                          ),
                          Text(widget.list[index]['isactive']
                              ? 'Active'
                              : 'Inavtive')
                        ],
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.topRight,
                          child: Text(
                            '${widget.list[index]['role_name'].toString()}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'NotoSans'),
                          ))
                    ],
                  ),
                )),
          ]);
        }),));
  }
}
