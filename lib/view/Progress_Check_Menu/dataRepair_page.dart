import 'package:cloud_firestore/cloud_firestore.dart';
import 'variableData.dart';

import 'inputPart_page.dart';
import 'statusCheck_page.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

String contohSearch = '';
TextEditingController searchController = TextEditingController();

class DataRepairPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Repair'),
        ),
        body: DataRepairList(),
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

class DataRepairList extends StatefulWidget {
  @override
  _DataRepairListState createState() => _DataRepairListState();
}

class _DataRepairListState extends State<DataRepairList> {
  Future getData() async {
    if (searchController.text == '' || searchController.text == null) {
      var firestore = Firestore.instance;
      QuerySnapshot qn =
          await firestore.collection('Data Repair').getDocuments();
      return qn.documents;
    } else {
      var firestore = Firestore.instance
          .collection("Data Repair")
          .where('ID', isEqualTo: contohSearch)
          .getDocuments();
      QuerySnapshot qn = await firestore;
      return qn.documents;
    }
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
            ),
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
                                  title: Text(snapshot.data[index].data['ID']),
                                  onTap: () {
                                    setState(() {
                                      dataId = snapshot.data[index].data['ID'];
                                      isDataIdAvailable = true;
                                      for (int i = 0;
                                          i < checkUrlEnable.length;
                                          i++) {
                                        checkUrlEnable[i] = false;
                                        downloadUrlLink[i] = noImageUrl;
                                      }
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return StatusCheckPage();
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
}
