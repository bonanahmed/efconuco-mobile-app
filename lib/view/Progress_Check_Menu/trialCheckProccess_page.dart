import 'package:efconuco_mobile_app/view/Progress_Check_Menu/wholedata.dart';
import 'package:intl/intl.dart';

import '../../firestore_services.dart';
import 'variableData.dart';
import 'package:flutter/material.dart';

import 'imageCapture_page.dart';

class TrialCheckProccessPage extends StatefulWidget {
  @override
  _TrialCheckProccessPageState createState() => _TrialCheckProccessPageState();
}

class _TrialCheckProccessPageState extends State<TrialCheckProccessPage> {
  TextEditingController alarmActualController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trial Check Proccess'),
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
                Text(
                    'Tanggal Trial: ${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: alarmActualController,
                  decoration: InputDecoration(
                      hintText: "Alarm Actual",
                      labelText: "Alarm Actual",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text('Foto Alarm Monitor'),
                Padding(padding: EdgeInsets.all(10)),
                Image.network(downloadUrlLink[2]),
                Padding(padding: EdgeInsets.all(10)),
                Center(
                  child: Container(
                    child: RaisedButton.icon(
                      icon: Icon(Icons.camera_alt),
                      color: Colors.blue,
                      textColor: Colors.white,
                      label: Text('Take Picture'),
                      onPressed: () {
                        setState(() {
                          checkUrlEnable[2] = true;
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
                Image.network(downloadUrlLink[3]),
                Padding(padding: EdgeInsets.all(10)),
                Center(
                  child: Container(
                    child: RaisedButton.icon(
                      icon: Icon(Icons.camera_alt),
                      color: Colors.blue,
                      textColor: Colors.white,
                      label: Text('Take Picture'),
                      onPressed: () {
                        setState(() {
                          checkUrlEnable[3] = true;
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ImageCapture();
                        }));
                      },
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    child: RaisedButton.icon(
                      icon: Icon(Icons.save),
                      color: Colors.blue,
                      textColor: Colors.white,
                      label: Text("Save"),
                      onPressed: () {
                        DatabaseServices.createOrUpdateTrialCheckData(
                            dataId.toUpperCase(),
                            dateTrialCheck:
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                            alarmActual:
                                alarmActualController.text.toUpperCase(),
                            urlPhotoAlarmCheckMonitor: downloadUrlLink[2],
                            urlPhotoAlarmCheckModul: downloadUrlLink[3]);

                        DatabaseList.createOrUpdateDataListTrialCheck(dataId.toUpperCase(),
                            dateTrialCheck:
                                '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                            alarmActual:
                                alarmActualController.text.toUpperCase(),
                            urlPhotoAlarmCheckMonitor: downloadUrlLink[2],
                            urlPhotoAlarmCheckModul: downloadUrlLink[3]);
                        setState(() {
                          alarmActualController.text = '';
                          downloadUrlLink[2] =
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
                          downloadUrlLink[3] =
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
