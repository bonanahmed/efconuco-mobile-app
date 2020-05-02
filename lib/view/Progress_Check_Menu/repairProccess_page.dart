import 'package:efconuco_mobile_app/view/Progress_Check_Menu/repairData_page.dart';
import 'package:efconuco_mobile_app/view/Progress_Check_Menu/wholedata.dart';
import 'package:intl/intl.dart';

import '../../firestore_services.dart';
import 'variableData.dart';
import 'package:flutter/material.dart';

import 'imageCapture_page.dart';

class RepairProcessPage extends StatefulWidget {
  @override
  _RepairProcessPageState createState() => _RepairProcessPageState();
}

class _RepairProcessPageState extends State<RepairProcessPage> {
  TextEditingController brokenComponentController = TextEditingController();
  TextEditingController componentPositionController = TextEditingController();
  TextEditingController lotComponentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repair Proccess'),
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
                Text('Proses Repair : ${indexRepair + 1}'),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                    'Tanggal Repair: ${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: brokenComponentController,
                  decoration: InputDecoration(
                      hintText: "Komponen Rusak",
                      labelText: "Komponen Rusak",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text('Foto Komponen Rusak'),
                Padding(padding: EdgeInsets.all(10)),
                Image.network(downloadUrlLink[5]),
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
                          isRepairAvailable = true;
                          checkUrlEnable[5] = true;
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
                TextField(
                  controller: componentPositionController,
                  decoration: InputDecoration(
                      hintText: "Posisi Komponen Rusak",
                      labelText: "Posisi Komponen Rusak",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: lotComponentController,
                  decoration: InputDecoration(
                      hintText: "Lot Komponen",
                      labelText: "Lot Komponen",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text('Foto Jalur Komponen Rusak'),
                Padding(padding: EdgeInsets.all(10)),
                Image.network(downloadUrlLink[6]),
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
                          isRepairAvailable = true;
                          checkUrlEnable[6] = true;
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
                      DatabaseServices.createOrUpdateRepairProcessData(
                        dataId.toUpperCase(),
                        dateRepair:
                            '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                        brokenComponent: brokenComponentController.text.toUpperCase(),
                        urlPhotoComponent: downloadUrlLink[5],
                        brokenComponentPosition:
                            componentPositionController.text.toUpperCase(),
                        lotComponent: lotComponentController.text.toUpperCase(),
                        urlPhotoTrack: downloadUrlLink[6],
                      );
                      DatabaseList.createOrUpdateDataListRepair(dataId.toUpperCase(),
                        dateRepair:
                            '${DateFormat.yMd().add_jm().format(DateTime.now())}'.toUpperCase(),
                        brokenComponent: brokenComponentController.text.toUpperCase(),
                        urlPhotoComponent: downloadUrlLink[5],
                        brokenComponentPosition:
                            componentPositionController.text.toUpperCase(),
                        lotComponent: lotComponentController.text.toUpperCase(),
                        urlPhotoTrack: downloadUrlLink[6],
                      );

                      setState(() {
                        dataIndexRepair = 'Repair ${indexRepair + 1}';
                        brokenComponentController.text = '';
                        downloadUrlLink[5] =
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
                        componentPositionController.text = '';
                        lotComponentController.text = '';
                        downloadUrlLink[6] =
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
                      });
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return RepairDataPage();
                      }));
                    },
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
