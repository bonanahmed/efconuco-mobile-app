import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efconuco_mobile_app/view/Inventori_Item_Menu/inventoriDetail_page.dart';
import 'package:efconuco_mobile_app/view/Inventori_Item_Menu/inventoriInput_page.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/services.dart';

import 'services.dart';

TextEditingController searchController = TextEditingController(text: '');
String contohSearch = '';
int dataLength = 0;

class InventoriItemPage extends StatefulWidget {
  @override
  _InventoriItemPageState createState() => _InventoriItemPageState();
}

class _InventoriItemPageState extends State<InventoriItemPage> {
  @override
  void initState() {
    super.initState();
    searchController.text = '';
    contohSearch = '';
  }

  @override
  void dispose() {
    super.dispose();
    searchController.text = '';
    contohSearch = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Inventori Barang'),
        ),
        body: InventoriItemList(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera_alt),
              label: "Scan QR",
              onTap: _scanQr,
            ),
            SpeedDialChild(
              child: Icon(Icons.add),
              label: "Barang Baru",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InventoriInputPage();
                }));
              },
            ),
          ],
        ));
  }

  Future _scanQr() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        searchController.text = qrResult;
        contohSearch = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        print("Camera Access Denied");
      } else {
        setState(() {
          print("Unknown Error $ex");
        });
      }
    } on FormatException {
      setState(() {
        print("Anda Belum Melakukan Scanning");
      });
    } catch (ex) {
      setState(() {
        print("Unknown Error $ex");
        isDataIdAvailable = false;
      });
    }
  }
}

class InventoriItemList extends StatefulWidget {
  @override
  _InventoriItemListState createState() => _InventoriItemListState();
}

class _InventoriItemListState extends State<InventoriItemList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              onSubmitted: (value) {
                setState(() {
                  contohSearch = value.toUpperCase();
                });
              },
              onChanged: (value) {
                setState(() {
                  contohSearch = value.toUpperCase();
                });
              },
            ),
          ),
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Banyaknya Barang : $dataLength'));
            },
          ),
          FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Card(
                                child: ListTile(
                                  title: (snapshot.data[index]
                                                  .data['Serial_Number'] ==
                                              null ||
                                          snapshot.data[index]
                                                  .data['Serial_Number'] ==
                                              '')
                                      ? Text('Part Number: ' +
                                          snapshot
                                              .data[index].data['Part_Number'])
                                      : Text('Part Number: ' +
                                          snapshot
                                              .data[index].data['Part_Number']),
                                  subtitle: (snapshot.data[index]
                                                  .data['Serial_Number'] ==
                                              null ||
                                          snapshot.data[index]
                                                  .data['Serial_Number'] ==
                                              '')
                                      ? Text('Serial Number: Tidak Ada')
                                      : Text('Serial Number: ' +
                                          snapshot.data[index]
                                              .data['Serial_Number']),
                                  onTap: () {
                                    setState(() {
                                      databaseId =
                                          snapshot.data[index].data['ID'];
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return InventoriDetailPage();
                                    }));
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future getData() async {
    if (searchController.text == '' || searchController.text == null) {
      var firestore = Firestore.instance;
      QuerySnapshot qn =
          await firestore.collection('Inventori Barang').getDocuments();
      dataLength = qn.documents.length;
      return qn.documents;
    } else {
      var firestore = Firestore.instance;
      QuerySnapshot qn = await firestore
          .collection("Inventori Barang")
          .where('searchIndex', arrayContains: contohSearch)
          .getDocuments();

      dataLength = qn.documents.length;
      return qn.documents;
    }
  }
}
