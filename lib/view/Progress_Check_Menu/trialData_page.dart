import '../../firestore_services.dart';

import 'variableData.dart';

import 'package:flutter/material.dart';

class TrialDataPage extends StatefulWidget {
  @override
  _TrialDataPageState createState() => _TrialDataPageState();
}

class _TrialDataPageState extends State<TrialDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trial Data Page')),
      body: StreamBuilder<TrialData>(
          stream: DatabaseServices().dataTrial,
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
                        Text('Loading...'),
                      ],
                    )
                  ],
                ),
              );
            } else {
              TrialData trialData = snapshot.data;
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
                      subtitle: Text(trialData.dataDateTrial),
                    ),
                    if (trialData.dataStatusRepair == 'Repair Ulang') ...[
                      ListTile(
                        title: Text('Alarm'),
                        subtitle: Text(trialData.dataAlarmAfterRepair),
                      ),
                      ListTile(
                        title: Text('Foto Alarm Monitor'),
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
                                child: Image.network(trialData
                                    .dataUrlPhotoAlarmAfterRepairMonitor)),
                          ])
                        ],
                      ),
                      ListTile(
                        title: Text('Foto Alarm Modul'),
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
                                child: Image.network(trialData
                                    .dataUrlPhotoAlarmAfterRepairModul)),
                          ])
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20))
                    ] else ...[
                      ListTile(
                        title: Text('Status'),
                        subtitle: Text(trialData.dataStatusRepair),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      ListTile(
                        title: Text('Foto Alarm Monitor'),
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
                                child: Image.network(trialData
                                    .dataUrlPhotoAlarmAfterRepairMonitor)),
                          ])
                        ],
                      ),
                      ListTile(
                        title: Text('Foto Alarm Modul'),
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
                                child: Image.network(trialData
                                    .dataUrlPhotoAlarmAfterRepairModul)),
                          ])
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20))
                    ],
                  ],
                ),
              );
            }
          }),
    );
  }
}
