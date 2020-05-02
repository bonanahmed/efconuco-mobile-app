import '../../firestore_services.dart';

import 'variableData.dart';

import 'package:flutter/material.dart';

class PartInPage extends StatefulWidget {
  @override
  _PartInPageState createState() => _PartInPageState();
}

class _PartInPageState extends State<PartInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Part In')),
      body: StreamBuilder<PartInData>(
          stream: DatabaseServices().dataPartIn,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading..");
            } else {
              PartInData partInData = snapshot.data;
              return Container(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('ID'),
                            subtitle: Text(dataId),
                          ),
                          ListTile(
                            title: Text('Tanggal Masuk'),
                            subtitle: Text(partInData.dataDateIn),
                          ),
                          ListTile(
                            title: Text('Customer'),
                            subtitle: Text(partInData.dataCustomer),
                          ),
                          ListTile(
                            title: Text('Type'),
                            subtitle: Text(partInData.dataType),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Part Number'),
                            subtitle: Text(partInData.dataPartNumber),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Serial Number'),
                            subtitle: Text(partInData.dataSerialNumber),
                          ),
                          ListTile(
                            title: Text('Info Alarm dari Customer'),
                            subtitle: Text(partInData.dataInfoAlarmCustomer),
                          ),
                          ListTile(
                            title: Text('Kondisi Fisik'),
                            subtitle: Text(partInData.dataPhysicCondition),
                          ),
                          ListTile(
                            title: Text('Kondisi Fan Eksternal'),
                            subtitle: Text(partInData.dataFanExternal),
                          ),
                          ListTile(
                            title: Text('Kondisi Fan Internal'),
                            subtitle: Text(partInData.dataFanInternal),
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
                                        partInData.dataUrlPhotoFront)),
                                Container(
                                    padding: EdgeInsets.all(15),
                                    child: Image.network(
                                        partInData.dataUrlPhotoBack)),
                              ])
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 20))
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
