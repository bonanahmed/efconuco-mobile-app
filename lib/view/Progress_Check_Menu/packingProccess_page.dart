import 'package:efconuco_mobile_app/firestore_services.dart';
import 'package:efconuco_mobile_app/view/Progress_Check_Menu/wholedata.dart';
import 'package:intl/intl.dart';

import 'imageCapture_page.dart';
import 'variableData.dart';

import 'package:flutter/material.dart';

class PackingProccessPage extends StatefulWidget {
  @override
  _PackingProccessPageState createState() => _PackingProccessPageState();
}

class _PackingProccessPageState extends State<PackingProccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Packing Process Page')),
      body: StreamBuilder<PackingData>(
          stream: DatabaseServices().dataPacking,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('ID'),
                      subtitle: Text(dataId),
                    ),
                    ListTile(
                      title: Text('Tanggal Packing'),
                      subtitle: Text(
                          '${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                    ),
                    ListTile(
                      title: Text('Foto Proses Packing'),
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
                              child: Image.network(downloadUrlLink[9])),
                        ])
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.blue,
                        textColor: Colors.white,
                        label: Text('Take Picture'),
                        onPressed: () {
                          setState(() {
                            checkUrlEnable[9] = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ImageCapture();
                          }));
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Column(
                        children: <Widget>[
                          RaisedButton.icon(
                            icon: Icon(Icons.save),
                            color: Colors.blue,
                            textColor: Colors.white,
                            label: Text("Save"),
                            onPressed: () {
                              DatabaseServices.createOrUpdatePackingData(dataId.toUpperCase(),
                                  datePacking:
                                      '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                                  urlPhotoPacking: downloadUrlLink[9]);
                              DatabaseList.createOrUpdateDataListPacking(dataId.toUpperCase(),
                                  datePacking:
                                      '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                                  urlPhotoPacking: downloadUrlLink[9]);
                              downloadUrlLink[9] = noImageUrl;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              PackingData packingData = snapshot.data;
              return Container(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('ID'),
                      subtitle: Text(dataId),
                    ),
                    ListTile(
                      title: Text('Tanggal Packing'),
                      subtitle: Text(packingData.dataDatePacking),
                    ),
                    ListTile(
                      title: Text('Foto Proses Packing'),
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
                              child: (packingData.dataUrlPhotoPacking != null)
                                  ? Image.network(
                                      packingData.dataUrlPhotoPacking)
                                  : Image.network(noImageUrl)),
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
