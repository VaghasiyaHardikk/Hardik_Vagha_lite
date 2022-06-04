// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'mainpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyLoginPage(),
    );
  }
  var UserName;
  var password;
  var SerialNumber;
  var SessionHostId;
  var HostMAC;
  var HostName;
  var LastSeen;
  var LocalIP;
  var LoginProvider;
  var key;
  var ProviderKey;
  var PublicIP;
  void Google(
      String UserName,
      Password,
      SerialNumber,
      SessionHostId,
      HostName,
      HostMAC,
      LoginProvider,
      ProviderKey,
      LastSeen,
      PublicIP,
      LocalIP,
      key) async {
    // ignore: unused_local_variable
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Response response = await post(
          Uri.parse('https://mtestsd.rbkei.in/api/CreateTokan'),
          body: {
            'UserName': UserName,
            'Password': Password,
            'SerialNumber': SerialNumber,
            'SessionHostId': SessionHostId,
            'HostName': HostName,
            'HostMAC': HostMAC,
            'LoginProvider': LoginProvider,
            'ProviderKey': ProviderKey,
            'LastSeen': LastSeen,
            'PublicIP': PublicIP,
            'LocalIP': LocalIP,
            'key': key
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);

        print('Login');
      } else {
        print('failed');
      }
      } catch (e) {
      print(e.toString());
    }
  }

}

class MyLoginPage extends StatefulWidget {
   
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  var UserName;
  var password;
  var SerialNumber;
  var SessionHostId;
  var HostMAC;
  var HostName;
  var LastSeen;
  var LocalIP;
  var LoginProvider;
  var NotificationToken;
  var ProviderKey;
  var PublicIP;

  void login(
      String UserName,
      Password,
      SerialNumber,
      SessionHostId,
      HostName,
      HostMAC,
      LoginProvider,
      ProviderKey,
      LastSeen,
      PublicIP,
      LocalIP,
      NotificationToken) async {
    // ignore: unused_local_variable
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      Response response = await post(
          Uri.parse('https://mtestsd.rbkei.in/api/CreateTokan'),
          body: {
            'UserName': UserName,
            'Password': Password,
            'SerialNumber': SerialNumber,
            'SessionHostId': SessionHostId,
            'HostName': HostName,
            'HostMAC': HostMAC,
            'LoginProvider': LoginProvider,
            'ProviderKey': ProviderKey,
            'LastSeen': LastSeen,
            'PublicIP': PublicIP,
            'LocalIP': LocalIP,
            'NotificationToken': NotificationToken
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);

        print('Login');
      } else {
        print('failed');
      }
       } catch (e) {
      print(e.toString());
    }
  }

  SharedPreferences? logindata;
  bool? newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata!.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Center(child: Image.asset("assets/schooldesk.png",height: 40,))),
      ),
      body:
      
      
      Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              
              textColor: Colors.white,
              color: Colors.amber,
              onPressed: () {
                var data;
                login(
                        username_controller.text.toString(),
                        password_controller.text.toString(),
                        SerialNumber.toString(),
                        SessionHostId.toString(),
                        HostName.toString(),
                        HostMAC.toString(),
                        LoginProvider.toString(),
                        ProviderKey.toString(),
                        LastSeen.toString(),
                        PublicIP.toString(),
                        LocalIP.toString(),
                        NotificationToken.toString(),
                      );
                String username = username_controller.text;
                String password = password_controller.text;

                if (username != '' && password != '') {
                  print('Successfull');
                  logindata!.setBool('login', false);

                  logindata!.setString('username', username);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyDashboard()));
                }
              },
              child: Text("Log-In"),
            )
          ],
        ),
      ),
    );
    
  }
}