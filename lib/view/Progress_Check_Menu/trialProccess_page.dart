import 'package:efconuco_mobile_app/view/Progress_Check_Menu/trialData_page.dart';
import 'package:intl/intl.dart';

import '../../firestore_services.dart';
import 'variableData.dart';
import 'package:flutter/material.dart';

import 'imageCapture_page.dart';
import 'wholedata.dart';

// enum RepairCondition { exist, notExist }

// RepairCondition _repairCondition = RepairCondition.exist;

bool _exist = true;
bool _notExist = false;
bool _currentState = true;

class TrialProcessPage extends StatefulWidget {
  @override
  _TrialProcessPageState createState() => _TrialProcessPageState();
}

class _TrialProcessPageState extends State<TrialProcessPage> {
  TextEditingController alarmAfterRepairController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trial Proccess'),
      ),
      body: Container(
          child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ID : $dataId",
                  style: TextStyle(fontSize: 25),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text('Proses Trial : ${indexTrial + 1}'),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                    'Tanggal Trial: ${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                Padding(padding: EdgeInsets.all(10)),
                Text('Alarm Setelah Repair'),
                Row(
                  children: <Widget>[
                    Radio(
                        value: _exist,
                        groupValue: _currentState,
                        onChanged: (value) {
                          setState(() {
                            _currentState = value;
                          });
                        }),
                    Text('Ada')
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                        value: _notExist,
                        groupValue: _currentState,
                        onChanged: (value) {
                          setState(() {
                            _currentState = value;
                          });
                        }),
                    Text('Tidak Ada')
                  ],
                ),
                if (_currentState) ...[
                  Padding(padding: EdgeInsets.all(10)),
                  TextField(
                    controller: alarmAfterRepairController,
                    decoration: InputDecoration(
                        hintText: "Alarm Setelah Repair",
                        labelText: "Alarm Setelah Repair",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Foto Alarm Monitor'),
                  Padding(padding: EdgeInsets.all(10)),
                  Image.network(downloadUrlLink[7]),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.blue,
                        textColor: Colors.white,
                        label: Text('Take Picture'),
                        onPressed: () {
                          setState(() {
                            isTrialAvailable = true;
                            checkUrlEnable[7] = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ImageCapture();
                          }));
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Foto Alarm Modul'),
                  Padding(padding: EdgeInsets.all(10)),
                  Image.network(downloadUrlLink[8]),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.blue,
                        textColor: Colors.white,
                        label: Text('Take Picture'),
                        onPressed: () {
                          setState(() {
                            isTrialAvailable = true;
                            checkUrlEnable[8] = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ImageCapture();
                          }));
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: RaisedButton.icon(
                      icon: Icon(Icons.save),
                      color: Colors.blue,
                      textColor: Colors.white,
                      label: Text("Save"),
                      onPressed: () {
                        DatabaseServices.createOrUpdateTrialData(dataId.toUpperCase(),
                            dateTrial:
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                            alarmAfterRepair: alarmAfterRepairController.text.toUpperCase(),
                            urlPhotoAlarmAfterRepairMonitor: downloadUrlLink[7],
                            urlPhotoAlarmAfterRepairModul: downloadUrlLink[8],
                            statusRepair: 'Repair Ulang');
                        DatabaseList.createOrUpdateDataListTrial(dataId,
                            dateTrial:
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                            alarmAfterRepair: alarmAfterRepairController.text.toUpperCase(),
                            urlPhotoAlarmAfterRepairMonitor: downloadUrlLink[7],
                            urlPhotoAlarmAfterRepairModul: downloadUrlLink[8],
                            statusRepair: 'Repair Ulang');
                        setState(() {
                          dataIndexTrial = 'Trial ${indexTrial + 1}';
                          alarmAfterRepairController.text = '';
                          downloadUrlLink[7] = noImageUrl;
                          downloadUrlLink[8] = noImageUrl;
                        });
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return TrialDataPage();
                        }));
                      },
                    ),
                  ),
                ] else ...[
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Foto Alarm Monitor'),
                  Padding(padding: EdgeInsets.all(10)),
                  Image.network(downloadUrlLink[7]),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.blue,
                        textColor: Colors.white,
                        label: Text('Take Picture'),
                        onPressed: () {
                          setState(() {
                            isTrialAvailable = true;
                            checkUrlEnable[7] = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ImageCapture();
                          }));
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text('Foto Alarm Modul'),
                  Padding(padding: EdgeInsets.all(10)),
                  Image.network(downloadUrlLink[8]),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        color: Colors.blue,
                        textColor: Colors.white,
                        label: Text('Take Picture'),
                        onPressed: () {
                          setState(() {
                            isTrialAvailable = true;
                            checkUrlEnable[8] = true;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ImageCapture();
                          }));
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Center(
                    child: RaisedButton.icon(
                      icon: Icon(Icons.save),
                      color: Colors.blue,
                      textColor: Colors.white,
                      label: Text("Save"),
                      onPressed: () {
                        DatabaseServices.createOrUpdateTrialData(dataId.toUpperCase(),
                            dateTrial:
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                            alarmAfterRepair: 'Tidak Ada',
                            urlPhotoAlarmAfterRepairMonitor: downloadUrlLink[7],
                            urlPhotoAlarmAfterRepairModul: downloadUrlLink[8],
                            statusRepair: 'Selesai');
                        DatabaseList.createOrUpdateDataListTrial(dataId.toUpperCase(),
                            dateTrial:
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                            alarmAfterRepair: 'Tidak Ada',
                            urlPhotoAlarmAfterRepairMonitor: downloadUrlLink[7],
                            urlPhotoAlarmAfterRepairModul: downloadUrlLink[8],
                            statusRepair: 'Selesai');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return TrialDataPage();
                        }));
                        setState(() {
                          dataIndexTrial = 'Trial ${indexTrial + 1}';
                          alarmAfterRepairController.text = '';
                          downloadUrlLink[7] = noImageUrl;
                          downloadUrlLink[8] = noImageUrl;
                        });
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      )),
    );
  }
}
