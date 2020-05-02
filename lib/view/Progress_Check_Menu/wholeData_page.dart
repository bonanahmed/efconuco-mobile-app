import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../firestore_services.dart';

import 'imageCapture_page.dart';
import 'trialCheckProccess_page.dart';
import 'variableData.dart';

import 'package:flutter/material.dart';

PartInData partInData;
TrialCheckData trialCheckData;
WashData washData;
PackingData packingData;

class WholeDataPage extends StatefulWidget {
  @override
  _WholeDataPageState createState() => _WholeDataPageState();
}

class _WholeDataPageState extends State<WholeDataPage> {
  Future _getDataRepair() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Data Repair')
        .document(dataId)
        .collection('Proses Repair')
        .document('Repair')
        .collection('Repair List')
        .getDocuments();
    return qn.documents;
  }

  Future _getDataTrial() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Data Repair')
        .document(dataId)
        .collection('Proses Repair')
        .document('Trial')
        .collection('Trial List')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Keseluruhan Data')),
      body: ListView(
        children: <Widget>[
          StreamBuilder<PartInData>(
              stream: DatabaseServices().dataPartIn,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading..");
                } else {
                  partInData = snapshot.data;
                  return Container(
                    child: Column(
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
                                subtitle:
                                    Text(partInData.dataInfoAlarmCustomer),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
          StreamBuilder<TrialCheckData>(
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
                            Text('Data Trial Check Tidak Ditemukan'),
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
                  trialCheckData = snapshot.data;
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
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
                                      trialCheckData.dataUrlPhotoAlarmMonitor)),
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
                                  child: Image.network(
                                      trialCheckData.dataUrlPhotoAlarmModul)),
                            ])
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
          StreamBuilder<WashData>(
              stream: DatabaseServices().dataWash,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Column(
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
                                  DatabaseServices.createOrUpdateWashData(
                                      dataId,
                                      dateWash:
                                          '${DateFormat.yMd().add_jm().format(DateTime.now())}',
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
                  washData = snapshot.data;
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Tanggal Cuci'),
                          subtitle: Text(washData.dataDateWash),
                        ),
                        ListTile(
                          title: Text('Foto Proses Cuci'),
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
                                  child: (washData.dataUrlPhotoWash != null)
                                      ? Image.network(washData.dataUrlPhotoWash)
                                      : Image.network(noImageUrl)),
                            ])
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }),
          FutureBuilder(
            future: _getDataRepair(),
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
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                            snapshot.data[index].data['index']),
                                      ),
                                      ListTile(
                                        title: Text('Tanggal Repair'),
                                        subtitle: Text(snapshot.data[index]
                                            .data['Tanggal_Repair']),
                                      ),
                                      ListTile(
                                        title: Text('Komponen Rusak'),
                                        subtitle: Text(snapshot.data[index]
                                            .data['Komponen_Rusak']),
                                      ),
                                      ListTile(
                                        title: Text('Foto Komponen Rusak'),
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
                                                child: (snapshot.data[index]
                                                                .data[
                                                            'Foto_Komponen_Rusak'] !=
                                                        null)
                                                    ? Image.network(snapshot
                                                            .data[index].data[
                                                        'Foto_Komponen_Rusak'])
                                                    : Image.network(
                                                        noImageUrl)),
                                          ])
                                        ],
                                      ),
                                      ListTile(
                                        title: Text('Posisi Komponen Rusak'),
                                        subtitle: Text(snapshot.data[index]
                                            .data['Posisi_Komponen_Rusak']),
                                      ),
                                      ListTile(
                                        title: Text('Lot Komponen'),
                                        subtitle: Text(snapshot.data[index]
                                            .data['Data_Lot_Komponen']),
                                      ),
                                      ListTile(
                                        title:
                                            Text('Foto Jalur Komponen Rusak'),
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
                                                child: (snapshot.data[index]
                                                                .data[
                                                            'Foto_Jalur_Komponen_Rusak'] !=
                                                        null)
                                                    ? Image.network(snapshot
                                                            .data[index].data[
                                                        'Foto_Jalur_Komponen_Rusak'])
                                                    : Image.network(
                                                        noImageUrl)),
                                          ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              }
            },
          ),
          FutureBuilder(
            future: _getDataTrial(),
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
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                            snapshot.data[index].data['index']),
                                      ),
                                      ListTile(
                                        title: Text('Tanggal Trial'),
                                        subtitle: Text(snapshot
                                            .data[index].data['Tanggal_Trial']),
                                      ),
                                      if (snapshot.data[index]
                                              .data['Status_Repair'] ==
                                          'Repair Ulang') ...[
                                        ListTile(
                                          title: Text('Alarm Setelah Repair'),
                                          subtitle: Text(snapshot
                                              .data[index].data['index']),
                                        ),
                                      ],
                                      ListTile(
                                        title: Text('Foto Monitor'),
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
                                                child: (snapshot.data[index]
                                                                .data[
                                                            'Url_Foto_Alarm_Setelah_Repair_Monitor'] !=
                                                        null)
                                                    ? Image.network(snapshot
                                                            .data[index].data[
                                                        'Url_Foto_Alarm_Setelah_Repair_Monitor'])
                                                    : Image.network(
                                                        noImageUrl)),
                                          ])
                                        ],
                                      ),
                                      ListTile(
                                        title: Text('Foto Modul'),
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
                                                child: (snapshot.data[index]
                                                                .data[
                                                            'Url_Foto_Alarm_Setelah_Repair_Modul'] !=
                                                        null)
                                                    ? Image.network(snapshot
                                                            .data[index].data[
                                                        'Url_Foto_Alarm_Setelah_Repair_Modul'])
                                                    : Image.network(
                                                        noImageUrl)),
                                          ])
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                );
              }
            },
          ),
          StreamBuilder<PackingData>(
              stream: DatabaseServices().dataPacking,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
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
                                  DatabaseServices.createOrUpdatePackingData(
                                      dataId,
                                      datePacking:
                                          '${DateFormat.yMd().add_jm().format(DateTime.now())}',
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
                  packingData = snapshot.data;
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Tanggal Packing'),
                          subtitle: Text(packingData.dataDatePacking),
                        ),
                        ListTile(
                          title: Text('Foto Proses Packing'),
                        ),
                        Table(
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
                                  child:
                                      (packingData.dataUrlPhotoPacking != null)
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
        ],
      ),
    );
  }
}
