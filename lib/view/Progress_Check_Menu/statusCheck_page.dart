import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'pdf_view/pdf.dart';
import 'repairList_page.dart';
import 'trialList_page.dart';

import 'packingProccess_page.dart';
import 'partIn_page.dart';
import 'trialCheckData_page.dart';
import 'variableData.dart';
import 'washProccess_page.dart';
import 'dataRepair_page.dart';
import 'inputPart_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

String _dataId;
String _dateIn;
String _customer;
String _type;
String _partNumber;
String _serialNumber;
String _customerInfoAlarm;
String _physicCondition;
String _fanInternal;
String _fanExternal;
String _urlPhotoFront;
String _urlPhotoBack;

String _dateTrialCheck;
String _alarmActual;
String _urlPhotoAlarmCheckMonitor;
String _urlPhotoAlarmCheckModul;

String _dateWash;
String _urlPhotoWash;

int _indexRepair;
List<String> _dateRepair = [];
List<String> _brokenComponent = [];
List<String> _urlPhotoComponent = [];
List<String> _brokenComponentPosition = [];
List<String> _lotComponent = [];
List<String> _urlPhotoTrack = [];

int _indexTrial;
List<String> _dateTrial = [];
List<String> _alarmAfterRepair = [];
List<String> _urlPhotoAlarmAfterRepairMonitor = [];
List<String> _urlPhotoAlarmAfterRepairModul = [];
List<String> _statusRepair = [];

String _datePacking;
String _urlPhotoPacking;

class StatusCheckPage extends StatefulWidget {
  @override
  _StatusCheckPageState createState() => _StatusCheckPageState();
}

class _StatusCheckPageState extends State<StatusCheckPage> {
  @override
  void initState() {
    super.initState();
    _getSetList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cek Status'),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      dataId,
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  (!isDataIdAvailable)
                      ? Container(
                          child: Column(
                          children: <Widget>[
                            Center(child: Text('Data Id Belum Ada')),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.blue,
                                    child: Text(
                                      'Scan ID',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      _scanQr();
                                    },
                                  ),
                                  RaisedButton(
                                    color: Colors.blue,
                                    child: Text(
                                      'Input Part Baru',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return InputPartPage();
                                      }));
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ))
                      : Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Card(
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PartInPage();
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Part In',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return TrialCheckDataPage();
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Trial Check',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return WashProcessPage();
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Cuci',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return RepairListPage();
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Repair',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return TrialListPage();
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Trial',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return PackingProccessPage();
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Packing',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text(
                                      "Lihat Data Excel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      const url =
                                          'https://docs.google.com/spreadsheets/d/1GAgFHPnQ3cv9Za4TQr5NZODo_dLMT_MkZtqeX8Pn2bY/edit#gid=0';
                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                  ),
                                  RaisedButton(
                                    child: Text(
                                      "Download PDF",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      _getSetList();
                                      writeOnPdf();
                                      await savePdf();
                                      Directory documentDirectory =
                                          await getApplicationDocumentsDirectory();

                                      String documentPath =
                                          documentDirectory.path;

                                      String fullPath =
                                          "$documentPath/$dataId.pdf";

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfViewerPage(
                                                    path: fullPath,
                                                  )));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera_alt),
              label: "Scan Id",
              onTap: _scanQr,
            ),
            SpeedDialChild(
              child: Icon(Icons.add),
              label: "Part Masuk",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InputPartPage();
                }));
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.table_chart),
              label: "Data Repair",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DataRepairPage();
                }));
              },
            )
          ],
        ));
  }

  Future _scanQr() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        dataId = qrResult;
        isDataIdAvailable = true;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        dataId = "Camera Access Denied";
      } else {
        setState(() {
          dataId = "Unknown Error $ex";
          isDataIdAvailable = false;
        });
      }
    } on FormatException {
      setState(() {
        dataId = "Anda Belum Melakukan Scanning";
        isDataIdAvailable = false;
      });
    } catch (ex) {
      setState(() {
        dataId = "Unknown Error $ex";
        isDataIdAvailable = false;
      });
    }
  }
}

final pdf = pw.Document();

writeOnPdf() async {
  // const imageProvider = const AssetImage('assets/images/efconuco-logo.png');
  // final PdfImage image =
  //     await pdfImageFromImageProvider(pdf: pdf.document, image: imageProvider);

  // pdf.addPage(pw.Page(build: (pw.Context context) {
  //   return pw.Center(
  //     child: pw.Image(image),
  //   ); // Center
  // }));
// const imageProvider = const AssetImage('assets/images/efconuco-logo.png');
// final PdfImage image = await pdfImageFromImageProvider(pdf: pdf.document, image: imageProvider);
  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: pw.EdgeInsets.all(32),
    build: (pw.Context context) {
      return <pw.Widget>[
        pw.Header(level: 1, child: pw.Text("Part Masuk")),
        // pw.Image(image),
        pw.Text('ID'),
        pw.Paragraph(text: _dataId),
        pw.Text('Tanggal Masuk'),
        pw.Paragraph(text: _dateIn),
        pw.Text('Customer'),
        pw.Paragraph(text: _customer),
        pw.Text('Type'),
        pw.Paragraph(text: _type),
        pw.Text('Part Number'),
        pw.Paragraph(text: _partNumber),
        pw.Text('Serial Number'),
        pw.Paragraph(text: _serialNumber),
        pw.Text('Info Alarm dari Customer'),
        pw.Paragraph(text: _customerInfoAlarm),
        pw.Text('Kondisi Fisik'),
        pw.Paragraph(text: _physicCondition),
        pw.Text('Fan Internal'),
        pw.Paragraph(text: _fanInternal),
        pw.Text('Fan Internal'),
        pw.Paragraph(text: _fanExternal),
        pw.Text('Tampak Depan'),
        pw.Paragraph(text: _urlPhotoFront),
        pw.Text('Tampak Belakang'),
        pw.Paragraph(text: _urlPhotoBack),
        pw.Header(
          level: 1,
          child: pw.Text("Trial Check"),
        ),
        pw.Text('Tanggal Trial Check'),
        pw.Paragraph(text: _dateTrialCheck),
        pw.Text('Alarm Aktual'),
        pw.Paragraph(text: _alarmActual),
        pw.Text('Foto Alarm di Monitor'),
        pw.Paragraph(text: _urlPhotoAlarmCheckMonitor),
        pw.Text('Foto Alarm di Modul'),
        pw.Paragraph(text: _urlPhotoAlarmCheckModul),
        pw.Header(
          level: 1,
          child: pw.Text("Cuci"),
        ),
        pw.Text('Tanggal Cuci'),
        pw.Paragraph(text: _dateWash),
        pw.Text('Foto Proses Cuci'),
        pw.Paragraph(text: _urlPhotoWash),
        pw.Header(
          level: 1,
          child: pw.Text("Repair"),
        ),
        for (int i = 0; i < _indexRepair; i++) ...[
          pw.Header(
            level: 2,
            child: pw.Text("Repair ${i + 1}"),
          ),
          pw.Text('Tanggal Repair ${i + 1}'),
          pw.Paragraph(text: _dateRepair[i]),
          pw.Text('Komponen Rusak ${i + 1}'),
          pw.Paragraph(text: _brokenComponent[i]),
          pw.Text('Foto Komponen Rusak ${i + 1}'),
          pw.Paragraph(text: _urlPhotoComponent[i]),
          pw.Text('Posisi Komponen Rusak ${i + 1}'),
          pw.Paragraph(text: _brokenComponentPosition[i]),
          pw.Text('Data Lot Komponen ${i + 1}'),
          pw.Paragraph(text: _lotComponent[i]),
          pw.Text('Foto Jalur Komponen Rusak ${i + 1}'),
          pw.Paragraph(text: _urlPhotoTrack[i]),
        ],
        pw.Header(
          level: 1,
          child: pw.Text("Trial"),
        ),
        for (int i = 0; i < _indexTrial; i++) ...[
          pw.Header(
            level: 2,
            child: pw.Text("Trial ${i + 1}"),
          ),
          pw.Text('Tanggal Trial ${i + 1}'),
          pw.Paragraph(text: _dateTrial[i]),
          pw.Text('Alarm Setelah Repair ${i + 1}'),
          pw.Paragraph(text: _alarmAfterRepair[i]),
          pw.Text('Foto Alarm Setelah Repair Monitor ${i + 1}'),
          pw.Paragraph(text: _urlPhotoAlarmAfterRepairMonitor[i]),
          pw.Text('Foto Alarm Setelah Repair Modul ${i + 1}'),
          pw.Paragraph(text: _urlPhotoAlarmAfterRepairModul[i]),
          pw.Text('Status Repair ${i + 1}'),
          pw.Paragraph(text: _statusRepair[i]),
          pw.Header(
            level: 1,
            child: pw.Text("Packing"),
          ),
          pw.Text('Tanggal Packing'),
          pw.Paragraph(text: _datePacking),
          pw.Text('Foto Proses Packing'),
          pw.Paragraph(text: _urlPhotoPacking),
        ]
      ];
    },
  ));
}

Future savePdf() async {
  Directory documentDirectory = await getApplicationDocumentsDirectory();

  String documentPath = documentDirectory.path;

  File file = File("$documentPath/$dataId.pdf");

  file.writeAsBytesSync(pdf.save());
}

Future<String> _getSetList() async {
  String dataRepairList = 'Loading.....';
  DocumentReference dataRepairRef =
      Firestore.instance.collection('List Data Repair').document(dataId);

  var snapshot = await dataRepairRef.get();
  print('Tunggu Sebentar');
  if (isDataIdAvailable) {
    _dataId = snapshot['ID'];
    _dateIn = snapshot['Tanggal_Masuk'];
    _customer = snapshot['Customer'];
    _type = snapshot['Type'];
    _partNumber = snapshot['Part_Number'];
    _serialNumber = snapshot['Serial_Number'];
    _customerInfoAlarm = snapshot['Info_Alarm_dari_Customer'];
    _physicCondition = snapshot['Kondisi_Fisik'];
    _fanInternal = snapshot['Fan_Internal'];
    _fanExternal = snapshot['Fan_Eksternal'];
    _urlPhotoFront = snapshot['Url_Foto_Depan'];
    _urlPhotoBack = snapshot['Url_Foto_Belakang'];
    _dateTrialCheck = snapshot['Tanggal_Trial_Check'];
    _alarmActual = snapshot['Alarm_Aktual'];
    _urlPhotoAlarmCheckMonitor = snapshot['Url_Foto_Alarm_Monitor'];
    _urlPhotoAlarmCheckModul = snapshot['Url_Foto_Alarm_Modul'];
    _dateWash = snapshot['Tanggal_Cuci'];
    _urlPhotoWash = snapshot['Url_Foto_Cuci'];
    _indexRepair = snapshot['repairCount'];
    if (_indexRepair != null) {
      for (int i = 0; i < _indexRepair; i++) {
        _dateRepair.add(snapshot['Tanggal_Repair_${i + 1}']);
        _brokenComponent.add(snapshot['Komponen_Rusak_${i + 1}']);
        _urlPhotoComponent.add(snapshot['Foto_Komponen_Rusak_${i + 1}']);
        _brokenComponentPosition
            .add(snapshot['Posisi_Komponen_Rusak_${i + 1}']);
        _lotComponent.add(snapshot['Data_Lot_Komponen_${i + 1}']);
        _urlPhotoTrack.add(snapshot['Foto_Jalur_Komponen_Rusak_${i + 1}']);
      }
    }

    _indexTrial = snapshot['trialCount'];
    if (_indexTrial != null) {
      for (int i = 0; i < _indexTrial; i++) {
        _dateTrial.add(snapshot['Tanggal_Trial_${i + 1}']);
        _alarmAfterRepair.add(snapshot['Alarm_Setelah_Repair_${i + 1}']);
        _urlPhotoAlarmAfterRepairMonitor
            .add(snapshot['Url_Foto_Alarm_Setelah_Repair_Monitor_${i + 1}']);
        _urlPhotoAlarmAfterRepairModul
            .add(snapshot['Url_Foto_Alarm_Setelah_Repair_Modul_${i + 1}']);
        _statusRepair.add(snapshot['Status_Repair_${i + 1}']);
      }
    }
    _datePacking = snapshot['Tanggal_Packing'];
    _urlPhotoPacking = snapshot['Url_Foto_Packing'];
  }

  return dataRepairList;
}
