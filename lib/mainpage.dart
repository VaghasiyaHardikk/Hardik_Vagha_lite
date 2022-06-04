// ignore_for_file: unused_import, unused_element
////////////////after login/////////////////////////
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rbkei/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  _launchURLApp() async {
  const url = 'https://test.rbkei.org/Student/GetStudentProfile?IsProfile=True';
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: true, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  SharedPreferences? logindata;
  String? username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata!.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        title: Center(child: Center(child: Image.asset("assets/schooldesk.png",height: 40,))),
      ),
      body:
      WebView(
        initialUrl: 'https://test.rbkei.org/Student/GetStudentProfile?IsProfile=True',
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
      
    ));
  }
}