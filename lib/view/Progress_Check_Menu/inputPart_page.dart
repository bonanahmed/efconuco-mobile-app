import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efconuco_mobile_app/view/Progress_Check_Menu/wholedata.dart';

import '../../firestore_services.dart';

import 'variableData.dart';
import 'dataRepair_page.dart';
import 'statusCheck_page.dart';
import 'imageCapture_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:intl/intl.dart';

TextEditingController customerController = TextEditingController();
TextEditingController typeController = TextEditingController();
TextEditingController partNumberController = TextEditingController();
TextEditingController serialNumberController = TextEditingController();
TextEditingController alarmInfoCustomerController = TextEditingController();
TextEditingController physicConditionController = TextEditingController();
TextEditingController fanInternalController = TextEditingController();
TextEditingController fanExternalController = TextEditingController();

class InputPartPage extends StatefulWidget {
  @override
  _InputPartPageState createState() => _InputPartPageState();
}

class _InputPartPageState extends State<InputPartPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Data Repair').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Scaffold(body: Container(child: Center(child: Text('Loading....'))));
          } else {
            int _index000 = (snapshot.data.documents.length + 1);
            String _index = '000${_index000.toString()}';
            String _inputDataId =
                'IOREF${DateFormat('yyMM').format(DateTime.now())}$_index';

            return Scaffold(
                appBar: AppBar(title: Text('Input Part')),
                body: Container(
                    child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "ID : $_inputDataId",
                            style: TextStyle(fontSize: 25),
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Text(
                              'Tanggal Masuk: ${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                          Padding(padding: EdgeInsets.all(10)),
                          inputPartTextField('Customer', customerController, 1),
                          inputPartTextField('Type', typeController, 1),
                          inputPartTextField(
                              'Part Number', partNumberController, 1),
                          inputPartTextField(
                              'Serial Number', serialNumberController, 1),
                          inputPartTextField('Alarm Info dari Customer',
                              alarmInfoCustomerController, 1),
                          inputPartTextField(
                              'Kondisi Fisik ', physicConditionController, 3),
                          inputPartTextField(
                              'Fan Internal', fanInternalController, 3),
                          inputPartTextField(
                              'Fan External', fanExternalController, 3),
                          Text('Foto Depan'),
                          Padding(padding: EdgeInsets.all(10)),
                          Image.network(downloadUrlLink[0]),
                          Padding(padding: EdgeInsets.all(10)),
                          Center(
                            child: Container(
                              child: RaisedButton.icon(
                                icon: Icon(Icons.camera_alt),
                                label: Text('Take Picture'),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    checkUrlEnable[0] = true;
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
                          Text('Foto Belakang'),
                          Padding(padding: EdgeInsets.all(10)),
                          Image.network(downloadUrlLink[1]),
                          Padding(padding: EdgeInsets.all(10)),
                          Center(
                            child: Container(
                              child: RaisedButton.icon(
                                icon: Icon(Icons.camera_alt),
                                label: Text('Take Picture'),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    checkUrlEnable[1] = true;
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton.icon(
                                icon: Icon(Icons.save),
                                label: Text('Save'),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  DatabaseServices.createOrUpdatePartInData(
                                    _inputDataId.toUpperCase(),
                                    dataId: _inputDataId.toUpperCase(),
                                    date:
                                        '${DateFormat.yMd().add_jm().format(DateTime.now())}',
                                    customer: customerController.text.toUpperCase(),
                                    type: typeController.text.toUpperCase(),
                                    partNumber: partNumberController.text.toUpperCase(),
                                    serialNumber: serialNumberController.text.toUpperCase(),
                                    customerInfoAlarm:
                                        alarmInfoCustomerController.text.toUpperCase(),
                                    physicCondition:
                                        physicConditionController.text.toUpperCase(),
                                    fanInternal: fanInternalController.text.toUpperCase(),
                                    fanExternal: fanExternalController.text.toUpperCase(),
                                    urlPhotoFront: downloadUrlLink[0],
                                    urlPhotoBack: downloadUrlLink[1],
                                  );
                                  DatabaseList.createOrUpdateDataListPartIn(
                                    _inputDataId.toUpperCase(),
                                    dataId: _inputDataId.toUpperCase(),
                                    dateIn:
                                        '${DateFormat.yMd().add_jm().format(DateTime.now())}',
                                    customer: customerController.text.toUpperCase(),
                                    type: typeController.text.toUpperCase(),
                                    partNumber: partNumberController.text.toUpperCase(),
                                    serialNumber: serialNumberController.text.toUpperCase(),
                                    customerInfoAlarm:
                                        alarmInfoCustomerController.text.toUpperCase(),
                                    physicCondition:
                                        physicConditionController.text.toUpperCase(),
                                    fanInternal: fanInternalController.text.toUpperCase(),
                                    fanExternal: fanExternalController.text.toUpperCase(),
                                    urlPhotoFront: downloadUrlLink[0],
                                    urlPhotoBack: downloadUrlLink[1],
                                  );

                                  setState(() {
                                    customerController.text = '';
                                    typeController.text = '';
                                    partNumberController.text = '';
                                    serialNumberController.text = '';
                                    customerController.text = '';
                                    alarmInfoCustomerController.text = '';
                                    physicConditionController.text = '';
                                    fanInternalController.text = '';
                                    fanExternalController.text = '';
                                    downloadUrlLink[0] =
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
                                    downloadUrlLink[1] =
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              RaisedButton.icon(
                                icon: Icon(Icons.print),
                                label: Text('Print QR'),
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )),
                floatingActionButton: SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  children: [
                    SpeedDialChild(
                      child: Icon(Icons.check),
                      label: "Cek Status",
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return StatusCheckPage();
                        }));
                      },
                    ),
                    SpeedDialChild(
                      child: Icon(Icons.table_chart),
                      label: "Data Repair",
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DataRepairPage();
                        }));
                      },
                    )
                  ],
                ));
          }
        });
  }

//Procedure and backend
  Container inputPartTextField(
      String _text, TextEditingController _controller, int _maxLines) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        maxLines: _maxLines,
        controller: _controller,
        decoration: InputDecoration(
            hintText: _text,
            labelText: _text,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      ),
    );
  }
}

Future getIndex() async {
  try {
    var firestore = Firestore.instance.collection('Data Repair').getDocuments();
    QuerySnapshot querySnapshot = await firestore;

    String getIndex = querySnapshot.documents.toString();

    return getIndex;
  } catch (e) {
    print(e.toString());
  }
}
