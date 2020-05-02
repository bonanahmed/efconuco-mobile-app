import 'package:efconuco_mobile_app/firestore_services.dart';
import 'trialCheckProccess_page.dart';

import 'variableData.dart';

import 'package:flutter/material.dart';

class TrialCheckDataPage extends StatefulWidget {
  @override
  _TrialCheckDataPageState createState() => _TrialCheckDataPageState();
}

class _TrialCheckDataPageState extends State<TrialCheckDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trial Check Data Page')),
      body: StreamBuilder<TrialCheckData>(
          stream: DatabaseServices().dataTrialCheck,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              // return Text("Loading..");
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Data Tidak Ditemukan'),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Input Data',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TrialCheckProccessPage();
                            }));
                          },
                        )
                      ],
                    )
                  ],
                ),
              );
            } else {
              TrialCheckData trialCheckData = snapshot.data;
              return Container(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('ID'),
                      subtitle: Text(dataId),
                    ),
                    ListTile(
                      title: Text('Tanggal Trial'),
                      subtitle: Text(trialCheckData.dataDateTrialCheck),
                    ),
                    ListTile(
                      title: Text('Alarm'),
                      subtitle: Text(trialCheckData.dataAlarmActual),
                    ),
                    ListTile(
                      title: Text('Foto Alarm Monitor'),
                    ),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: {
                        0: FractionColumnWidth(.5),
                        1: FractionColumnWidth(.5),
                      },
                      children: [
                        TableRow(children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Image.network(
                                  trialCheckData.dataUrlPhotoAlarmMonitor)),
                        ])
                      ],
                    ),
                    ListTile(
                      title: Text('Foto Alarm Modul'),
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
                              child: Image.network(
                                  trialCheckData.dataUrlPhotoAlarmModul)),
                        ])
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                  ],
                ),
              );
            }
          }),
    );
  }
}
