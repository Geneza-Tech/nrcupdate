import 'package:flutter/material.dart';
import 'package:flutter_app/App/Sign_in/sign_in%20page.dart';
import 'package:http/http.dart' as http;
import 'Homepage1.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _email = '';
String _year = '';

// try {
//   log('testing......');
//
//   final http.Response token =
//   await http.post(
//     'https://nrcoperations.co.in/fmi/data/vLatest/databases/OA_Master/sessions',
//     headers: <String, String>{
//       'Content-Type': 'application/json',
//       'Authorization': 'Basic c3VzaGlsOkphY29iNw==',
//     },
//
//   );
//   log('token:$token');
//
//   Map<String, dynamic> responsetoken = jsonDecode(token.body);
//   var result = responsetoken['response'];
//   var tokenresult = result['token'];
//
//   log('result...in field:$responsetoken');
//   final prefs = await SharedPreferences.getInstance();
//   //Return String
//   final stringValue = prefs.getString('AppMonth');
//   final appyear =prefs.getString('AppYear');
//   final contact =prefs.getString('contact');
//   print("appyear...$appyear");
//   print("value....:$stringValue");
//   print("contact...$contact");
//
//
//   var headers = {
//     'Content-Type': 'application/json',
//     'Authorization': 'Bearer $tokenresult'
//   };
//   var raw = jsonEncode({"query":[{"Reporting_Month":stringValue, "Reporting_Year":appyear, "fk_Contact_Id":contact}]});
//   var request = http.Request('POST', Uri.parse(
//       'https://nrcoperations.co.in/fmi/data/vLatest/databases/OA_Master/layouts/General_report_app_dis/_find'));
//   request.body =raw;
//  // '''{ "query":[{"Reporting_Month":"jan", "Reporting_Year":"2020", "fk_Contact_Id":"9726E1502"}]}''';
//   request.headers.addAll(headers);
//   http.StreamedResponse response = await request.send();
//   if (response.statusCode == 200) {
//     print(await response.stream.bytesToString());
//   }
//   else {
//     print(response.reasonPhrase);
//   }
//
// }
// catch (e) {
//   print(e);
//   return null;
// }

class selectmonth extends StatefulWidget {
  @override
  _selectmonthState createState() => _selectmonthState();
}

class _selectmonthState extends State<selectmonth> {
  //Future<Album> futureAlbum;
  int _value = 1;
  @override
  void initState() {
    // TODO: implement initState
    _loadCounter();
    super.initState();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('AppMonth');
    print("Appmonth..$value");
    setState(() {
      _email = (prefs.getString('AppMonth'));
      _year = (prefs.getString('AppYear'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Select Month and year"),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: new Text(_email),
                              value: 1,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: DropdownButton(
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text(_year),
                              value: 1,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: PrimaryButton(
                    btnText: "Ok",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
