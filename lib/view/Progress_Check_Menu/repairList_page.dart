import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efconuco_mobile_app/view/Progress_Check_Menu/repairData_page.dart';
import 'package:efconuco_mobile_app/view/Progress_Check_Menu/repairProccess_page.dart';
import 'variableData.dart';

import 'inputPart_page.dart';
import 'statusCheck_page.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class RepairListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Repair'),
        ),
        body: RepairList(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.check),
                label: "Cek Status",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StatusCheckPage();
                  }));
                }),
            SpeedDialChild(
              child: Icon(Icons.add),
              label: "Part Masuk",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InputPartPage();
                }));
              },
            ),
          ],
        ));
  }
}

class RepairList extends StatefulWidget {
  @override
  _RepairListState createState() => _RepairListState();
}

class _RepairListState extends State<RepairList> {
  Future _getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Data Repair')
        .document(dataId)
        .collection('Proses Repair')
        .document('Repair')
        .collection('Repair List')
        .getDocuments();
    indexRepair = qn.documents.length;
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              } else {
                return Column(
                  children: <Widget>[
                    SizedBox(
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
                                      title: Text(
                                          snapshot.data[index].data['index']),
                                      onTap: () {
                                        setState(() {
                                          dataIndexRepair = snapshot
                                              .data[index].data['index'];
                                          for (int i = 0;
                                              i < checkUrlEnable.length;
                                              i++) {
                                            checkUrlEnable[i] = false;
                                            downloadUrlLink[i] = noImageUrl;
                                          }
                                        });
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return RepairDataPage();
                                        }));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    RaisedButton.icon(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RepairProcessPage();
                        }));
                      },
                      icon: Icon(Icons.navigate_next),
                      label: Text('Proses Selanjutnya'),
                      color: Colors.blue,
                      textColor: Colors.white,
                    )
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
