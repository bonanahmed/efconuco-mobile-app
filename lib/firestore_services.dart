import 'package:cloud_firestore/cloud_firestore.dart';
import 'view/Progress_Check_Menu/variableData.dart';


class DatabaseServices {
  static CollectionReference dataRepairRef =
      Firestore.instance.collection('Data Repair');

//Part In/Data Repair

  static Future<void> createOrUpdatePartInData(
    String id, {
    String dataId,
    String date,
    String customer,
    String type,
    String partNumber,
    String serialNumber,
    String customerInfoAlarm,
    String physicCondition,
    String fanInternal,
    String fanExternal,
    String urlPhotoFront,
    String urlPhotoBack,
  }) async {
    await dataRepairRef.document(id).setData({
      'ID': dataId,
      'Tanggal_Masuk': date,
      'Customer': customer,
      'Type': type,
      'Part_Number': partNumber,
      'Serial_Number': serialNumber,
      'Info_Alarm_dari_Customer': customerInfoAlarm,
      'Kondisi_Fisik': physicCondition,
      'Fan_Internal': fanInternal,
      'Fan_Eksternal': fanExternal,
      'Url_Foto_Depan': urlPhotoFront,
      'Url_Foto_Belakang': urlPhotoBack
    }, merge: true);
  }

  Stream<PartInData> get dataPartIn {
    return dataRepairRef
        .document(dataId)
        .snapshots()
        .map(_partInDataFromSnapShot);
  }

  PartInData _partInDataFromSnapShot(DocumentSnapshot snapshot) {
    return PartInData(
      dataDateIn: snapshot.data['Tanggal_Masuk'],
      dataCustomer: snapshot.data['Customer'],
      dataType: snapshot.data['Type'],
      dataPartNumber: snapshot.data['Part_Number'],
      dataSerialNumber: snapshot.data['Serial_Number'],
      dataInfoAlarmCustomer: snapshot.data['Info_Alarm_dari_Customer'],
      dataPhysicCondition: snapshot.data['Kondisi_Fisik'],
      dataFanExternal: snapshot.data['Fan_Eksternal'],
      dataFanInternal: snapshot.data['Fan_Internal'],
      dataUrlPhotoFront: snapshot.data['Url_Foto_Depan'],
      dataUrlPhotoBack: snapshot.data['Url_Foto_Belakang'],
    );
  }

  //Data Trial Check
  static Future<void> createOrUpdateTrialCheckData(
    String id, {
    String dateTrialCheck,
    String alarmActual,
    String urlPhotoAlarmCheckMonitor,
    String urlPhotoAlarmCheckModul,
  }) async {
    await dataRepairRef
        .document(id)
        .collection('Proses Repair')
        .document('Trial Check')
        .setData({
      'Tanggal_Trial_Check': dateTrialCheck,
      'Alarm_Aktual': alarmActual,
      'Url_Foto_Alarm_Monitor': urlPhotoAlarmCheckMonitor,
      'Url_Foto_Alarm_Modul': urlPhotoAlarmCheckModul,
    }, merge: true);
  }

  Stream<TrialCheckData> get dataTrialCheck {
    return dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Trial Check')
        .snapshots()
        .map(_trialCheckDataFromSnapShot);
  }

  TrialCheckData _trialCheckDataFromSnapShot(DocumentSnapshot snapshot) {
    return TrialCheckData(
        dataDateTrialCheck: snapshot.data['Tanggal_Trial_Check'],
        dataAlarmActual: snapshot.data['Alarm_Aktual'],
        dataUrlPhotoAlarmMonitor: snapshot.data['Url_Foto_Alarm_Monitor'],
        dataUrlPhotoAlarmModul: snapshot.data['Url_Foto_Alarm_Modul']);
  }

  //Data Wash
  static Future<void> createOrUpdateWashData(
    String id, {
    String dateWash,
    String urlPhotoWash,
  }) async {
    await dataRepairRef
        .document(id)
        .collection('Proses Repair')
        .document('Cuci')
        .setData({
      'Tanggal_Cuci': dateWash,
      'Url_Foto_Cuci': urlPhotoWash,
    }, merge: true);
  }

  Stream<WashData> get dataWash {
    return dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Cuci')
        .snapshots()
        .map(_washDataFromSnapShot);
  }

  WashData _washDataFromSnapShot(DocumentSnapshot snapshot) {
    return WashData(
      dataDateWash: snapshot.data['Tanggal_Cuci'],
      dataUrlPhotoWash: snapshot.data['Url_Foto_Cuci'],
    );
  }

  static Future<void> createOrUpdateRepairProcessData(
    String id, {
    String index,
    String dateRepair,
    String brokenComponent,
    String urlPhotoComponent,
    String brokenComponentPosition,
    String lotComponent,
    String urlPhotoTrack,
  }) async {
    QuerySnapshot qnRepair = await dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Repair')
        .collection('Repair List')
        .getDocuments();
    indexRepair = qnRepair.documents.length + 1;
    await dataRepairRef
        .document(id)
        .collection('Proses Repair')
        .document('Repair')
        .collection('Repair List')
        .document('Repair $indexRepair')
        .setData({
      'index': 'Repair $indexRepair',
      'Tanggal_Repair': dateRepair,
      'Komponen_Rusak': brokenComponent,
      'Foto_Komponen_Rusak': urlPhotoComponent,
      'Posisi_Komponen_Rusak': brokenComponentPosition,
      'Data_Lot_Komponen': lotComponent,
      'Foto_Jalur_Komponen_Rusak': urlPhotoTrack,
    }, merge: true);
  }

  Stream<RepairData> get dataRepair {
    return dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Repair')
        .collection('Repair List')
        .document(dataIndexRepair)
        .snapshots()
        .map(_repairProcessDataFromSnapShot);
  }

  RepairData _repairProcessDataFromSnapShot(DocumentSnapshot snapshot) {
    return RepairData(
        dataDateRepair: snapshot.data['Tanggal_Repair'],
        dataBrokenComponent: snapshot.data['Komponen_Rusak'],
        dataUrlPhotoComponent: snapshot.data['Foto_Komponen_Rusak'],
        dataComponentPosition: snapshot.data['Posisi_Komponen_Rusak'],
        dataLotComponent: snapshot.data['Data_Lot_Komponen'],
        dataUrlPhotoTrack: snapshot.data['Foto_Jalur_Komponen_Rusak']);
  }

  //Data Trial
  static Future<void> createOrUpdateTrialData(
    String id, {
    String index,
    String dateTrial,
    String alarmAfterRepair,
    String urlPhotoAlarmAfterRepairMonitor,
    String urlPhotoAlarmAfterRepairModul,
    String statusRepair,
  }) async {
    QuerySnapshot qnRepair = await dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Trial')
        .collection('Trial List')
        .getDocuments();
    indexTrial = qnRepair.documents.length + 1;
    await dataRepairRef
        .document(id)
        .collection('Proses Repair')
        .document('Trial')
        .collection('Trial List')
        .document('Trial $indexTrial')
        .setData({
      'index': 'Trial $indexTrial',
      'Tanggal_Trial': dateTrial,
      'Alarm_Setelah_Repair': alarmAfterRepair,
      'Url_Foto_Alarm_Setelah_Repair_Monitor': urlPhotoAlarmAfterRepairMonitor,
      'Url_Foto_Alarm_Setelah_Repair_Modul': urlPhotoAlarmAfterRepairModul,
      'Status_Repair': statusRepair,
    }, merge: true);
  }

  Stream<TrialData> get dataTrial {
    return dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Trial')
        .collection('Trial List')
        .document(dataIndexTrial)
        .snapshots()
        .map(_trialDataFromSnapShot);
  }

  TrialData _trialDataFromSnapShot(DocumentSnapshot snapshot) {
    return TrialData(
      dataDateTrial: snapshot.data['Tanggal_Trial'],
      dataAlarmAfterRepair: snapshot.data['Alarm_Setelah_Repair'],
      dataUrlPhotoAlarmAfterRepairMonitor:
          snapshot.data['Url_Foto_Alarm_Setelah_Repair_Monitor'],
      dataUrlPhotoAlarmAfterRepairModul:
          snapshot.data['Url_Foto_Alarm_Setelah_Repair_Modul'],
      dataStatusRepair: snapshot.data['Status_Repair'],
    );
  }

  //Data Packing
  static Future<void> createOrUpdatePackingData(
    String id, {
    String datePacking,
    String urlPhotoPacking,
  }) async {
    await dataRepairRef
        .document(id)
        .collection('Proses Repair')
        .document('Packing')
        .setData({
      'Tanggal_Packing': datePacking,
      'Url_Foto_Packing': urlPhotoPacking,
    }, merge: true);
  }

  Stream<PackingData> get dataPacking {
    return dataRepairRef
        .document(dataId)
        .collection('Proses Repair')
        .document('Packing')
        .snapshots()
        .map(_packingDataFromSnapShot);
  }

  PackingData _packingDataFromSnapShot(DocumentSnapshot snapshot) {
    return PackingData(
      dataDatePacking: snapshot.data['Tanggal_Packing'],
      dataUrlPhotoPacking: snapshot.data['Url_Foto_Packing'],
    );
  }
}
