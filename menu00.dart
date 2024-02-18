import 'package:flutter/material.dart';
import 'pareto00_kel.dart';
import 'pareto00_tps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'upload00_entry_datasuara_tps.dart';
import 'pareto00_kec.dart';
import 'pareto00_kabkota.dart';
import 'table00_user.dart';
import 'table00_tps_suara.dart';
import 'table00_tps_kelurahan.dart';
import 'table00_tps_kecamatan.dart';
import 'table00_tps_kabupatenkota.dart';
import 'table00_suara_kabupatenkota.dart';
import 'table00_suara_kecamatan.dart';
import 'table00_suara_kelurahan.dart';
import 'profile00.dart';
import 'table00_user_log.dart';
import 'search00_tps.dart';





class Menu00 extends StatelessWidget {
  const Menu00({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 50, 5, 210),
          foregroundColor: Colors.white,
          title: const Center(child: Text('REAL COUNT SYSTEM')),
          actions: [
            IconButton(
                onPressed: () {
                  print("+++++++++++++");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyProfile00()));
                },
                //icon: Icon(Icons.settings))
                //icon: Icon(Icons.home))
                //icon: Icon(Icons.menu))
                icon: Icon(Icons.person))
            //icon: Icon(Icons.person_add_alt_1_outlined))
          ],
        ),
        body: const NextPage_02_Pref(),
      ),
    );
  }
}

class NextPage_02_Pref extends StatefulWidget {
  const NextPage_02_Pref({Key? key}) : super(key: key);

  @override
  State<NextPage_02_Pref> createState() => _NextPagePrefState();
}

class _NextPagePrefState extends State<NextPage_02_Pref> {
  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  late SharedPreferences pref;
  late String username1 = "";
  late String namamu1 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  Future<void> initial() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username1 = pref.getString('username')!;
      namamu1 = pref.getString('namamu')!;
    });
  }

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Welcome " + namamu1 + "\n" + username1))),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: ListView(
          children: <Widget>[
            const Image(
              //image: AssetImage('assets/images/timbul.jpg'),
              image: AssetImage('assets/images/medium.jpg'),
            ),

            SizedBox(
              height: 2,
            ),

            const Text(
              " Main Menu Admin:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("01. Login"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableUser()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("02. User Registered"))),
            ),
            //.....................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    print(" 123 ++++++++++++++++++++");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const Upload00_EntryDataSuaraTps()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("03. Entry Data Rekap Suara di TPS"))),
            ),
            //.....................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableTps00()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("04. Table Jumlah Suara di TPS"))),
            ),
            //.....................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyTps()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("05. Graph Report Suara di TPS"))),
            ),
            //.....................................................................
            //.....................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyKabKota()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("06. Graph Report Suara di KabKota"))),
            ),
            //.....................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyKec()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("07. Graph Report Suara di Kec"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyKel()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("08. Graph Report Suara di Kel"))),
            ),
            //.....................................................................
            //.....................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableTpsLoc1()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("09. Table #TPS per Kelurahan"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableTpsLoc2()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("10. Table #TPS per Kecamatan"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableTpsLoc3()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("11. Table #TPS per KabupatenKota"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TableSuaraKabupatenkota()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("12. Table #SUARA per KabupatenKota"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableSuaraKec()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("13. Table #SUARA per Kecamatan"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TableSuaraKel()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("14. Table #SUARA per Kelurahan"))),
            ),
            //.....................................................................
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchingTps00()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("15. Searching TPS"))),
            ),
            //...........................................................................

            Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 0, 2),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Table00_UserLog()));
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("16. Table User Log"))),
            ),
            //...........................................................................
          ],
        ),
      ),
    );
  }
}
