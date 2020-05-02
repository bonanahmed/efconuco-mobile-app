import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:intl/intl.dart';

import 'imageCapture_page.dart';
import 'inventoriItem_page.dart';
import 'services.dart';

TextEditingController partNumberController = TextEditingController();
TextEditingController serialNumberController = TextEditingController();
String partNumber = '';
String serialNumber = '';

class InventoriInputPage extends StatefulWidget {
  @override
  _InventoriInputPageState createState() => _InventoriInputPageState();
}

class _InventoriInputPageState extends State<InventoriInputPage> {
  @override
  void initState() {
    super.initState();
    partNumber = '';
    serialNumber = '';
    inventoriId = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Input Inventori')),
        body: Container(
            child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // inputPartTextField('Inventori Id', inventoriIdController, 1),
                  Text('ID Inventori: ${inventoriId.toUpperCase()}'),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                      'Tanggal Masuk: ${DateFormat.yMd().add_jm().format(DateTime.now())}'),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      maxLines: 1,
                      controller: partNumberController,
                      decoration: InputDecoration(
                          hintText: 'Part Number',
                          labelText: 'Part Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onChanged: (value) {
                        setState(() {
                          partNumber = value;
                          inventoriId = partNumber.toUpperCase();
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      maxLines: 1,
                      controller: serialNumberController,
                      decoration: InputDecoration(
                          hintText: 'Serial Number',
                          labelText: 'Serial Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onChanged: (value) {
                        setState(() {
                          serialNumber = value;
                          if (serialNumber == '' || serialNumber == null) {
                            inventoriId = partNumber;
                          } else {
                            inventoriId = partNumber.toUpperCase() +
                                '-' +
                                serialNumber.toUpperCase();
                          }
                        });
                      },
                    ),
                  ),
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
                          List<String> splitList = inventoriId.split(" ");
                          List<String> indexList = [];
                          for (int i = 0; i < splitList.length; i++) {
                            for (int y = 1; y < splitList[i].length + 1; y++) {
                              indexList.add(
                                  splitList[i].substring(0, y).toUpperCase());
                            }
                          }
                          print(indexList);
                          DatabaseServices.createOrUpdateInventoriData(
                              inventoriId.toUpperCase(),
                              dataInventoriId: inventoriId.toUpperCase(),
                              date:
                                  '${DateFormat.yMd().add_jm().format(DateTime.now())}'
                                      .toUpperCase(),
                              partNumber:
                                  partNumberController.text.toUpperCase(),
                              serialNumber:
                                  serialNumberController.text.toUpperCase(),
                              urlPhotoFront: downloadUrlLink[0],
                              urlPhotoBack: downloadUrlLink[1],
                              dataIndexList: indexList);
                          setState(() {
                            inventoriId = '';
                            partNumber = '';
                            serialNumber = '';
                            partNumberController.text = '';
                            serialNumberController.text = '';
                            downloadUrlLink[0] = noImageUrl;
                            downloadUrlLink[1] = noImageUrl;
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
              label: "Data Inventori",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InventoriItemPage();
                }));
              },
            ),
          ],
        ));
  }
}

//Procedure and backend
