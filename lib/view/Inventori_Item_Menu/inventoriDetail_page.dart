import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efconuco_mobile_app/view/Inventori_Item_Menu/inventoriInput_page.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'services.dart';

class InventoriDetailPage extends StatefulWidget {
  @override
  _InventoriDetailPageState createState() => _InventoriDetailPageState();
}

class _InventoriDetailPageState extends State<InventoriDetailPage> {
  @override
  Widget build(BuildContext context) {
    void _addToDataBase(String name) {
      List<String> splitList = name.split(" ");
      List<String> indexList = [];
      for (int i = 0; i < splitList.length; i++) {
        for (int y = 1; y < splitList[i].length + 1; y++) {
          indexList.add(splitList[i].substring(0, y).toUpperCase());
        }
      }
      print(indexList);
      DatabaseServices.addIndexToDatabase(inventoriId.toUpperCase(),
          dataIndexList: indexList);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Inventori Detail')),
      body: StreamBuilder<InventoriData>(
          stream: DatabaseServices().dataInvetori,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Data Tidak Ada',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Kembali ke List'),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          RaisedButton(
                            child: Text('Input Data Baru'),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return InventoriInputPage();
                              }));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              InventoriData inventoriData = snapshot.data;
              return Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('ID'),
                            subtitle: Text(databaseId),
                          ),
                          ListTile(
                            title: Text('Tanggal Masuk'),
                            subtitle: Text(inventoriData.dataDateIn),
                          ),
                          ListTile(
                            title: Text('Part Number'),
                            subtitle: Text(inventoriData.dataPartNumber),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Serial Number'),
                            subtitle: Text(inventoriData.dataSerialNumber),
                          ),
                          Table(
                            // border: TableBorder.all(),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.top,
                            columnWidths: {
                              0: FractionColumnWidth(.5),
                              1: FractionColumnWidth(.5),
                            },
                            children: [
                              TableRow(children: [
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Image.network(
                                        inventoriData.dataUrlPhotoFront)),
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Image.network(
                                        inventoriData.dataUrlPhotoBack)),
                              ])
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 20)),
                          RaisedButton(
                            child: Text('Ambil Barang'),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              Firestore.instance
                                  .collection("Inventori Barang")
                                  .document(databaseId)
                                  .delete();

                              return Fluttertoast.showToast(
                                  msg: 'Barang Telah di Ambil');
                            },
                          ),
                          RaisedButton(
                            child: Text('Convert Id'),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              _addToDataBase(databaseId);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
