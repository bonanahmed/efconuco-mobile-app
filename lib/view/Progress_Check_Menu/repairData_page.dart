import '../../firestore_services.dart';

import 'variableData.dart';

import 'package:flutter/material.dart';

class RepairDataPage extends StatefulWidget {
  @override
  RepairDataPageState createState() => RepairDataPageState();
}

class RepairDataPageState extends State<RepairDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Repair Data Page')),
      body: StreamBuilder<RepairData>(
          stream: DatabaseServices().dataRepair,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              RepairData repairData = snapshot.data;
              return Container(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('ID'),
                      subtitle: Text(dataId),
                    ),
                    ListTile(
                      title: Text('Tanggal Repair'),
                      subtitle: Text(repairData.dataDateRepair),
                    ),
                    ListTile(
                      title: Text('Komponen Rusak'),
                      subtitle: Text(repairData.dataBrokenComponent),
                    ),
                    ListTile(
                      title: Text('Foto Komponen'),
                    ),
                    Image.network(repairData.dataUrlPhotoComponent),
                    ListTile(
                      title: Text('Posisi Komponen Rusak'),
                      subtitle: Text(repairData.dataComponentPosition),
                    ),
                    ListTile(
                      title: Text('Lot Komponen'),
                      subtitle: Text(repairData.dataLotComponent),
                    ),
                    ListTile(
                      title: Text('Foto Jalur Komponen Rusak'),
                    ),
                    Image.network(repairData.dataUrlPhotoTrack),
                    Padding(padding: EdgeInsets.only(top: 15)),
                    Padding(padding: EdgeInsets.only(bottom: 20))
                  ],
                ),
              );
            } else {
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
            }
          }),
    );
  }
}
