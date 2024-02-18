import 'package:flutter/material.dart';
import 'signup.dart';
import 'menu00.dart';
import 'menu01.dart';
import 'menu11.dart';

import 'package:http/http.dart' as http; //For http.post
import 'dart:async'; //For Async
import 'dart:convert'; //For JSON
import 'package:shared_preferences/shared_preferences.dart';
import 'package:convert/convert.dart'; //For convert ... hex encode
import 'package:crypto/crypto.dart' as crypto; //For ... crypto.md5
import 'package:fluttertoast/fluttertoast.dart';
import 'server.dart';
import 'password_reset.dart';
//import 'profile00.dart';
import 'login_success.dart';
import 'login_success_pref.dart';


main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, //harus didalam 'return' tampilan dilayar
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 5, 210),
          foregroundColor: Colors.white,
          title: const Center(
              child: Center(child: Text('      REAL COUNT SYSTEM'))),
          actions: [
            IconButton(
              highlightColor: Colors.red,
              onPressed: () {
                print("+++++++++++++");
              },
              //icon: Icon(Icons.settings))
              //icon: Icon(Icons.home))
              //icon: const Icon(Icons.person,),),
              //icon: const Icon(Icons.apps,),),

              icon: const Icon(
                Icons.menu_sharp,
              ),
            ),
          ],
        ),
        body: const MyLogin(),
      ),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //var flagging = 'f02';
  var flagging = '$flagging1'; //server.dart

  bool _isObscure = true;
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  final name_controller = TextEditingController();

  late SharedPreferences pref;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    _login();
  }

  void _gotoNextPage() {
    showToastMessage("Go to Next Page...!!!");
    // TODO: implement initState
    super.initState();
  }

  Future<void> _login() async {
    final url = Uri.parse(
      //'https://mediumsitompul.com/qcri/login.php',
      'https://mediumsitompul.com/qcri/login1.php', // new Log
    );
    var response = await http.post(url, body: {
      "flagging": flagging.toString(),
      "username": username_controller.text,
      //"password": password_controller.text,
      //"password": generateMd5encode64(password_controller.text)
      "password": generateMd5(generateMd5encode64(password_controller.text)),
    });

    var datauser = jsonDecode(response.body);
    

    pref = await SharedPreferences.getInstance();
    newuser = (pref.getBool('loginpref') ?? true);
    print(newuser);
    
    print("datauser++++++++++++++++");
    print(datauser);


    if (datauser.isEmpty) {
      print('Login Fail');
      showToastMessage("Your login must be correctly...!!!");
    } else {
      if (datauser[0]['c_profile'] == 'p-00') {
        //............................................
        //MENGAMBIL Data Field yang ada di table
        var name_ = (datauser[0]["name"]);
        var username_ = (datauser[0]["username"]);
        //............................................
        //WRITE data name_, username_ to pref
        await pref.setString('namamu', name_);
        await pref.setString('usernamemu', username_);
        //.............................................
        print("Welcome p-00");
        Navigator.push(
          context,
          //MaterialPageRoute(builder: (context) => Menu00()),
          MaterialPageRoute(builder: (context) => LoginSuccessPref()),
          
        );
      }
      //....................................................

      else if (datauser[0]['c_profile'] == 'p-01') {
        //MENGAMBIL Data Field yang ada di table
        var name_ = (datauser[0]["name"]);
        var username_ = (datauser[0]["username"]);
        //WRITE data name_, username_ to pref
        await pref.setString('namamu', name_);
        await pref.setString('usernamemu', username_);
        //.............................................
        print("Welcome p-01");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu01()),
        );
      }
      //....................................................
      else if (datauser[0]['c_profile'] == 'p-11') {
        //MENGAMBIL Data Field yang ada di table
        var name_ = (datauser[0]["name"]);
        var username_ = (datauser[0]["username"]);
        //WRITE data name_, username_ to pref
        await pref.setString('namamu', name_);
        await pref.setString('usernamemu', username_);
        //.............................................
        print("Welcome p-01");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu11()),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    name_controller.dispose();

    super.dispose();
  }
  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              child: Image(
                //image: AssetImage('assets/images/timbul.jpg'),
                image: AssetImage('assets/images/medium.jpg'),

                width: 180,
                height: 180,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: TextField(
                  controller: password_controller,
                  //obscureText: !_isObscure,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(
                              //_isObscure ? Icons.visibility : Icons.visibility_off),
                              !_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (username_controller.value.text.isEmpty) {
                  showToastMessage("Please isi Username ....!!!");
                } else if (password_controller.value.text.isEmpty) {
                  showToastMessage("Please isi Password....!!!");
                }

                String username1 = username_controller.text;
                String password1 = password_controller.text;
                print('password1');
                print(password1);

                String name1 = name_controller.text;

                print('username1');
                print(username1);

                pref.setBool('loginpref', false);
                pref.setString('username', username1);
                pref.setString('name', name1);
                //pref.setString('flagging', flagging);

                print('Success Pref, but not for Login');

                _login();
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Row(
              children: [
                TextButton(
                  child: Text(
                    'Reset Pswd',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordReset()));
                  },
                ),
                TextButton(
                  child: Text(
                    'Signup',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Signup00()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            // ),

            Container(
              child: const Text(
                'Version: 2.6',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ],
        ),
      ),

      //.............................................................
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          // print("username0");
          // print(username0);

          print('Tombol Reffresh di pencettt');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Menu00(), //What is that?
              ));
        }),
        tooltip: 'Reload data',
        child: const Icon(Icons.ac_unit),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      //..............................................................
    );
  }

  //No Build Context
  //showToastMessage("Show Toast Message on Flutter");
  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

generateMd5(String data) {
  var content = const Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

generateMd5encode64(String data) {
  var content = const Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  var _digest = hex.encode(digest.bytes);
  var encode64 = base64.encode(utf8.encode(_digest));
  return encode64;
}

//No Build Context
//showToastMessage("Show Toast Message on Flutter");
void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 16.0);
}
