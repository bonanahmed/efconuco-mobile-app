import 'package:cloud_firestore/cloud_firestore.dart';

import 'variableData.dart';

class DatabaseList {
  static CollectionReference dataRepairRef =
      Firestore.instance.collection('List Data Repair');

  static Future<void> createOrUpdateDataListPartIn(
    String id, {
    String dataId,
    String dateIn,
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
      'Tanggal_Masuk': dateIn,
      'Customer': customer,
      'Type': type,
      'Part_Number': partNumber,
      'Serial_Number': serialNumber,
      'Info_Alarm_dari_Customer': customerInfoAlarm,
      'Kondisi_Fisik': physicCondition,
      'Fan_Internal': fanInternal,
      'Fan_Eksternal': fanExternal,
      'Url_Foto_Depan': urlPhotoFront,
      'Url_Foto_Belakang': urlPhotoBack,
    }, merge: true);
  }

  static Future<void> createOrUpdateDataListTrialCheck(
    String id, {
    String dateTrialCheck,
    String alarmActual,
    String urlPhotoAlarmCheckMonitor,
    String urlPhotoAlarmCheckModul,
  }) async {
    await dataRepairRef.document(id).setData({
      'Tanggal_Trial_Check': dateTrialCheck,
      'Alarm_Aktual': alarmActual,
      'Url_Foto_Alarm_Monitor': urlPhotoAlarmCheckMonitor,
      'Url_Foto_Alarm_Modul': urlPhotoAlarmCheckModul,
    }, merge: true);
  }

  static Future<void> createOrUpdateDataListWash(
    String id, {
    String dateWash,
    String urlPhotoWash,
  }) async {
    await dataRepairRef.document(id).setData({
      'Tanggal_Cuci': dateWash,
      'Url_Foto_Cuci': urlPhotoWash,
    }, merge: true);
  }

  static Future<void> createOrUpdateDataListPacking(
    String id, {
    String datePacking,
    String urlPhotoPacking,
  }) async {
    await dataRepairRef.document(id).setData({
      'Tanggal_Packing': datePacking,
      'Url_Foto_Packing': urlPhotoPacking,
    }, merge: true);
  }

  static Future<void> createOrUpdateDataListRepair(
    String id, {
    String dateRepair,
    String brokenComponent,
    String urlPhotoComponent,
    String brokenComponentPosition,
    String lotComponent,
    String urlPhotoTrack,
    int repairCount,
  }) async {
    await dataRepairRef.document(id).setData({
      'Tanggal_Repair_${indexRepair + 1}': dateRepair,
      'Komponen_Rusak_${indexRepair + 1}': brokenComponent,
      'Foto_Komponen_Rusak_${indexRepair + 1}': urlPhotoComponent,
      'Posisi_Komponen_Rusak_${indexRepair + 1}': brokenComponentPosition,
      'Data_Lot_Komponen_${indexRepair + 1}': lotComponent,
      'Foto_Jalur_Komponen_Rusak_${indexRepair + 1}': urlPhotoTrack,
      'repairCount': indexRepair + 1,
    }, merge: true);
  }

  static Future<void> createOrUpdateDataListTrial(
    String id, {
    String dateTrial,
    String alarmAfterRepair,
    String urlPhotoAlarmAfterRepairMonitor,
    String urlPhotoAlarmAfterRepairModul,
    String statusRepair,
    int trialCount,
  }) async {
    await dataRepairRef.document(id).setData({
      'Tanggal_Trial_${indexTrial + 1}': dateTrial,
      'Alarm_Setelah_Repair_${indexTrial + 1}': alarmAfterRepair,
      'Url_Foto_Alarm_Setelah_Repair_Monitor_${indexTrial + 1}':urlPhotoAlarmAfterRepairMonitor,
      'Url_Foto_Alarm_Setelah_Repair_Modul_${indexTrial + 1}':urlPhotoAlarmAfterRepairModul,
      'Status_Repair_${indexTrial + 1}': statusRepair,
      'trialCount': indexTrial + 1,
    }, merge: true);
  }
}
