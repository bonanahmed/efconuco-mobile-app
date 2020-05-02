// import 'accountManagement_page.dart';
import '../auth_services.dart';
import 'Inventori_Item_Menu/inventoriItem_page.dart';
import 'Progress_Check_Menu/statusCheck_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final FirebaseUser user;
  MainPage(this.user);
  // String username = user.uid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu Utama'),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: Container(
                    width: 1000,
                    height: 1000,
                    padding: EdgeInsets.all(20),
                    child: Image.asset('assets/images/efconuco-logo.png'))),
            Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          // 'Selamat Datang ' + user.uid,
                          'Selamat Datang Admin',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 130,
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.check_box),
                                  iconSize: 50,
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StatusCheckPage();
                                    }));
                                  },
                                ),
                                Text(
                                  'Cek Progress Repair',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 130,
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.storage),
                                  iconSize: 50,
                                  onPressed: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return InventoriItemPage();
                                    }));
                                  },
                                ),
                                Text(
                                  'Inventori Barang',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 130,
                            child: Column(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.account_box),
                                  iconSize: 50,
                                  onPressed: () async {
                                    await AuthServices.signOut();
                                    // onPressed: () {
                                    //   Navigator.push(context,
                                    //       MaterialPageRoute(builder: (context) {
                                    //     return AccountManagementPage();
                                    //   }));
                                    // }
                                  },
                                ),
                                Text(
                                  'Manage Akun',
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        )),
      ),
    );
  }
}
