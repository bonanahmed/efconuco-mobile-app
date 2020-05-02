import 'package:efconuco_mobile_app/firestore_services.dart';
import 'package:efconuco_mobile_app/view/Progress_Check_Menu/wholedata.dart';
import 'package:intl/intl.dart';

import 'imageCapture_page.dart';
import 'variableData.dart';

import 'package:flutter/material.dart';

class WashProcessPage extends StatefulWidget {
  @override
  _WashProcessPageState createState() => _WashProcessPageState();
}

class _WashProcessPageState extends State<WashProcessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wash Proccess Page')),
      body: StreamBuilder<WashData>(
          stream: DatabaseServices().dataWash,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('ID'),
                            subtitle: Text(dataId),
                          ),
                          ListTile(
                            title: Text('Tanggal Cuci'),
                            subtitle: Text(
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                          ),
                          ListTile(
                            title: Text('Foto Proses Cuci'),
                          ),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Image.network(downloadUrlLink[4])),
                          Container(
                            child: RaisedButton.icon(
                              icon: Icon(Icons.camera_alt),
                              color: Colors.blue,
                              textColor: Colors.white,
                              label: Text('Take Picture'),
                              onPressed: () {
                                setState(() {
                                  checkUrlEnable[4] = true;
                                });
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ImageCapture();
                                }));
                              },
                            ),
                          ),
                          RaisedButton.icon(
                            icon: Icon(Icons.save),
                            color: Colors.blue,
                            textColor: Colors.white,
                            label: Text("Save"),
                            onPressed: () {
                              DatabaseServices.createOrUpdateWashData(dataId.toUpperCase(),
                                  dateWash:
                                      '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                                  urlPhotoWash: downloadUrlLink[4]);
                              DatabaseList.createOrUpdateDataListWash(dataId.toUpperCase(),
                                  dateWash:
                                      '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                                  urlPhotoWash: downloadUrlLink[4]);
                              downloadUrlLink[4] = noImageUrl;
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              WashData washData = snapshot.data;
              return Container(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('ID'),
                      subtitle: Text(dataId),
                    ),
                    ListTile(
                      title: Text('Tanggal Cuci'),
                      subtitle: Text(washData.dataDateWash),
                    ),
                    ListTile(
                      title: Text('Foto Proses Cuci'),
                    ),
                    Table(
                      // border: TableBorder.all(),
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: {
                        0: FractionColumnWidth(.5),
                        1: FractionColumnWidth(.5),
                      },
                      children: [
                        TableRow(children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: (washData.dataUrlPhotoWash != null)
                                  ? Image.network(washData.dataUrlPhotoWash)
                                  : Image.network('')),
                        ])
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20))
                  ],
                ),
              );
            }
          }),
    );
  }
}
