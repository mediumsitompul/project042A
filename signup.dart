import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto; //For ... crypto.md5
import 'package:convert/convert.dart'; //For convert ... hex encode
//import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'server.dart';
import 'signup_success00.dart';
//import 'menu00.dart';
import 'package:intl/intl.dart';

class Signup00 extends StatelessWidget {
  const Signup00({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 5, 210),
          foregroundColor: Colors.white,
          title: const Center(
              child: Text("REGISTRATION FORM\n    (DAPIL SUMUT 1)")),
        ),
        body: const MySignUp(),
      ),
    );
  }
}

class MySignUp extends StatefulWidget {
  const MySignUp({Key? key}) : super(key: key);
  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  //................................................................................

  bool dropdown001Available = false;
  bool dropdown002Available = false;
  bool dropdown003Available = false;
  bool dropdown004Available = false;

  bool select001 = false;
  bool select002 = false;
  bool select003 = false;
  bool select004 = false;

  final String provincename = "";
  final String regencyname = "";
  final String kecamatanname = "";
  final String villagesname = "";

  final String provinceid = "";
  final String regencyid = "";
  final String kecamatanid = "";
  final String villagesid = "";

  //var data_01; //var data_003;
  //var data_02; //var data_004;

  var data_001;
  var data_002;
  var data_003;
  var data_004;

  var provincename1;
  var regencyname1;
  var kecamatanname1;
  var kelurahanname1;

  var usernamex;

  //String? _selected1;//003
  //String? _selected2;//004

  String? _selected001;
  String? _selected002;
  String? _selected003;
  String? _selected004;

  // HOSTING OK
  //var data001_url = "$server/province_ri.php";
  //var data002_url = "$server/kabupatentkota_ri.php";
  //var data003_url = "$server/kecamatan_v.php";//003
  //var data004_url = "$server/villages_v.php";//004

  var data001_url =
      "https://mediumsitompul.com/qcri/province_ri.php"; //t_province_all, OK
  var data002_url =
      "https://mediumsitompul.com/qcri/kabupatenkota_ri.php"; //t_kabupatenkota_all, OK
  var data003_url =
      "https://mediumsitompul.com/qcri/kecamatan_ri.php"; //t_kecamatan_all, OK
  var data004_url =
      "https://mediumsitompul.com/qcri/villages_ri.php"; // t_villages_all, OK

  //..................................................................................
  @override
  void initState() {
    //In this case: for Future function only
    get_data001();
    get_data002(provinceid);
    get_data003(regencyid); // sdh mengandung provinceid
    get_data004(kecamatanid); // sdh mengandung provinceid
    super.initState();
  }

  //******************************************************* DROP DOWN ************************************************************************************* */
  Widget data001List() {
    List<query001> data001_list = List<query001>.from(
      data_001["datajs"].map(
        (i) {
          return query001.fromJSON(i);
        },
      ),
    );

    return DropdownButton(
      hint: const Text("Pilih Province"), //Data1
      isExpanded: true,
      items: data001_list.map((query001) {
        return DropdownMenuItem(
          onTap: () {
            setState(() {
              select001 = true;
            });
          },

          child: Text(query001.provincename), //show
          value: query001.provinceid, //value yg di send
        );
      }).toList(),
      value: _selected001,
      onChanged: (newValue) {
        setState(() {
          _selected001 = newValue.toString();
          final provinceid = _selected001;
          print(
              "_selected001 provinceid ========== " + _selected001.toString());
          showToastMessage(provinceid.toString());
          get_data002(provinceid); //send to input dropdown2
          _selected002 = null;
          _selected003 = null;
          _selected004 = null;
        });
      },
    );
  }

  //******************************************************************************************************************************************** */
  Widget data002List() {
    List<query002> data002_list =
        List<query002>.from(data_002['datajs'].map((i) {
      return query002.fromJSON(i);
    }));

    return DropdownButton(
      hint: const Text("Pilih Kabupaten / Kota"), //Data2, Regency
      isExpanded: true,
      items: data002_list.map((query002) {
        return DropdownMenuItem(
          onTap: () {
            setState(() {
              select002 = true;
            });
          },

          child: Text(query002.regencyname), //DATA SHOW
          value: query002.regencyid, //DATA SENDING
        );
      }).toList(),
      value: _selected002,
      onChanged: (newValue) {
        setState(() {
          _selected002 = newValue.toString();
          //_selected002 = "";

          final regencyid = _selected002; //medium new
          print("_selected002 regency ========== " + _selected002.toString());
          showToastMessage(regencyid.toString());
          get_data003(regencyid); // medium new
          _selected003 = null;
          _selected004 = null;
        });
      },
    );
  }

  //******************************************************************************************************************************************** */
  Widget data003List() {
    List<query003> data003_list =
        List<query003>.from(data_003['datajs'].map((i) {
      return query003.fromJSON(i);
    }));

    return DropdownButton(
      hint: const Text("Pilih Kecamatan"), //Data3, Kecamatan
      isExpanded: true,
      items: data003_list.map((query003) {
        return DropdownMenuItem(
          onTap: () {
            setState(() {
              select003 = true;
            });
          },
          child: Text(query003.kecamatanname),
          value: query003.kecamatanid,
        );
      }).toList(),
      value: _selected003,
      onChanged: (newValue) {
        setState(() {
          _selected003 = newValue.toString();
          final kecamatanid = _selected003;
          print("_selected003 Kecamatan ========== " + _selected003.toString());
          showToastMessage(kecamatanid.toString());
          get_data004(
              kecamatanid); //Jika tidak ada query lagi dibawahnya. STOP THIS
          _selected004 = null;
        });
      },
    );
  }

  //******************************************************************************************************************************************** */

  Widget data004List() {
    List<query004> data004_list =
        List<query004>.from(data_004['datajs'].map((i) {
      return query004.fromJSON(i);
    }));

    return DropdownButton(
      hint: const Text("Pilih Kelurahan"), //Data4, Villages
      isExpanded: true,
      items: data004_list.map((query004) {
        return DropdownMenuItem(
          onTap: () {
            setState(() {
              select004 = true;
            });
          },
          child: Text(query004.villagesname),
          value: query004.villagesid,
        );
      }).toList(),
      value: _selected004,
      onChanged: (newValue) {
        setState(() {
          _selected004 = newValue.toString();
          final villagesid = _selected004;
          print("_selected004 villages =========== " + _selected004.toString());
          showToastMessage(villagesid.toString());
          //get_data5(nextid); //Jika tidak ada query lagi dibawahnya. Jika tidak, maka STOP THIS
          //_selected5 = null;
        });
      },
    );
  }
  // //******************************************************************************************************************************************** */

  Future<void> get_data001() async {
    //NO.3
    var res001 = await http.post(Uri.parse(data001_url));
    print("res001 = " + res001.toString());
    if (res001.statusCode == 200) {
      setState(() {
        data_001 = json.decode(res001.body); // data JSON like di file PHP
        print("data_001 = " + data_001.toString());

        //*************************** */
        setState(() {
          dropdown001Available = true;
        });
        //*************************** */
      });
    } else {
      setState(() {
        // bool error = true;
        // String message = "Error during fetching data";
      });
    }
  }
  //========================================================================================================================================

//now
  Future<void> get_data002(res001) async {
    final provinceid = res001;

    //pakai final: OK
    final res002 = await http
        .post(Uri.parse(data002_url + "?pilihan1=" + provinceid.toString()));

    print("res002 = " + res002.toString());

    if (res002.statusCode == 200) {
      setState(() {
        data_002 = json.decode(res002.body.toString());
        print("data_002 = " + data_002.toString());

        //*************************** */
        setState(() {
          dropdown002Available = true;
        });
        //*************************** */
      });
    } else {
      setState(() {
        // bool error = true;
        // String message = "Error during fetching data";
      });
    }
  }

  //========================================================================================================================================
  Future<void> get_data003(res002) async {
    final regencyid = res002;

    final res003 = await http
        .post(Uri.parse(data003_url + "?pilihan2=" + regencyid.toString()));

    print("res003 = " + res003.toString());

    if (res003.statusCode == 200) {
      setState(() {
        data_003 = json.decode(res003.body.toString()); //new medium
        print("data_003 = " + data_003.toString());

        //*************************** */
        setState(() {
          dropdown003Available = true;
        });
        //*************************** */
      });
    } else {
      setState(() {
        // bool error = true;
        // String message = "Error during fetching data";
      });
    }
  }

  Future<void> get_data004(res003) async {
    final kecamatanid = res003;

    var res004 = await http
        .post(Uri.parse(data004_url + "?pilihan3=" + kecamatanid.toString()));

    print("res004 = " + res004.toString());

    if (res004.statusCode == 200) {
      setState(() {
        data_004 = json.decode(res004.body.toString()); //new medium
        print("data_004 = " + data_004.toString());

        //*************************** */
        setState(() {
          dropdown004Available = true;
        });
        //*************************** */
      });
    } else {
      setState(() {
        // bool error = true;
        // String message = "Error during fetching data";
      });
    }
  }
  //zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  Future<void> _signup() async {
    final url = Uri.parse(
      '$server/signup000.php',
    );
    var response = await http.post(url, body: {
      "username": usernameController.text,
      "password": generateMd5(generateMd5encode64(passwordController.text)),
      "name": nameController.text,
      "province": _selected001.toString(),
      "regency": _selected002.toString(),
      "kecamatan": _selected003.toString(),
      "kelurahan": _selected004.toString(),
      "birthday": dateInputController.text,
    });
    final result1 = jsonDecode(response.body);
    print(result1);

    //******************************************************************** */
    if (nameController.value.text.isNotEmpty) {
      //the last widget validated control
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupSuccess00()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //..................................................................

          dropdown001Available == false ? Container() : data001List(),
          dropdown002Available == false ? Container() : data002List(),
          dropdown003Available == false ? Container() : data003List(),
          dropdown004Available == false ? Container() : data004List(),
          //................................................................

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 60, 8, 10),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your Phone Number'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your Password'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter your Name'),
            ),
          ),

          //.........................................
          Container(
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.width / 3,
              child: Center(
                  child: TextField(
                controller: dateInputController,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Birthday" //label text of field
                    ),
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInputController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ))),

          //........................................

          const SizedBox(
            height: 40,
          ),

          //......................................... VALIDATION INCLUDE ......................
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
            child: ElevatedButton(
                onPressed: () {
                  if (!select001) {
                    showToastMessage("Please select PROVINCE ....!!!");
                  } else if (!select002) {
                    showToastMessage("Please select KABUPATEN/ KOTA ....!!!");
                  } else if (!select003) {
                    showToastMessage("Please select KECAMATAN ....!!!");
                  } else if (!select004) {
                    showToastMessage("Please select kelurahan ....!!!");
                  } else if (usernameController.value.text.isEmpty) {
                    showToastMessage("Please isi Phone Number.... !!!");
                  } else if (passwordController.value.text.isEmpty) {
                    showToastMessage("Please enter your password....!!!");
                  } else if (nameController.value.text.isEmpty) {
                    showToastMessage("Please enter your name....!!!");
                  } else if (dateInputController.value.text.isEmpty) {
                    showToastMessage("Please enter your Birthday....!!!");
                  } else
                    _signup();
                },
                child: const Text(' E N T E R')),
          )
        ],
      ),

      //................... floatingActionButton >>> IN SCAFFOLD() ................
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (() {
      //     // print("username0");
      //     // print(username0);

      //     print('Tombol Reffresh di pencettt');

      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MainMenu00(), //What is that?
      //         ));
      //   }),
      //   tooltip: 'Reload data',
      //   child: const Icon(Icons.ac_unit),
      //   foregroundColor: Colors.white,
      //   backgroundColor: Colors.red,
      // ),
      //...........................................................................
    );
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

class query001 {
  var provincename;
  var provinceid;
  query001({required this.provincename, required this.provinceid});

  factory query001.fromJSON(Map<String, dynamic> datarow) {
    var provincename = datarow['province_name'];
    var provinceid = datarow['province_id'];
    print("provinceid = " + provinceid.toString());
    print("provincename = " + provincename.toString());
    return query001(provincename: provincename, provinceid: provinceid);
  }
}

class query002 {
  var regencyid;
  var regencyname;
  query002({required this.regencyid, required this.regencyname});

  factory query002.fromJSON(Map<String, dynamic> datarow) {
    var regencyid = datarow['regency_id'] as String;
    var regencyname = datarow['regency_name'] as String;
    print("regencyid = " + regencyid.toString());
    print("regencyname = " + regencyname.toString());
    return query002(regencyid: regencyid, regencyname: regencyname);
  }
}

class query003 {
  var kecamatanid;
  var kecamatanname;
  query003({required this.kecamatanid, required this.kecamatanname});

  factory query003.fromJSON(Map<String, dynamic> datarow) {
    var kecamatanid = datarow['kecamatan_id'] as String;
    var kecamatanname = datarow['kecamatan_name'] as String;
    print("kecamatanid = " + kecamatanid.toString());
    print("kecamatanname = " + kecamatanname.toString());
    return query003(kecamatanid: kecamatanid, kecamatanname: kecamatanname);
  }
}

class query004 {
  var villagesid;
  var villagesname;
  query004({required this.villagesid, required this.villagesname});

  factory query004.fromJSON(Map<String, dynamic> datarow) {
    var villagesid = datarow['villages_id'] as String;
    var villagesname = datarow['villages_name'] as String;
    print("villagesid = " + villagesid.toString());
    print("villagesname = " + villagesname.toString());
    return query004(villagesid: villagesid, villagesname: villagesname);
  }
}
