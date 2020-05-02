//variable for global
String dataId = 'Scan ID Barang';
bool isDataIdAvailable = false;
String noImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';

bool isRepairAvailable = false;
bool isTrialAvailable = false;
List<bool> checkUrlEnable = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];
List<String> downloadUrlLink = [
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl,
  noImageUrl
];
int indexRepair = 0;
String dataIndexRepair = '';

int indexTrial = 0;
String dataIndexTrial = '';

class PartInData {
  final String dataDateIn;
  final String dataCustomer;
  final String dataType;
  final String dataPartNumber;
  final String dataSerialNumber;
  final String dataInfoAlarmCustomer;
  final String dataPhysicCondition;
  final String dataFanInternal;
  final String dataFanExternal;
  final String dataUrlPhotoFront;
  final String dataUrlPhotoBack;

  PartInData(
      {this.dataDateIn,
      this.dataCustomer,
      this.dataType,
      this.dataPartNumber,
      this.dataSerialNumber,
      this.dataInfoAlarmCustomer,
      this.dataPhysicCondition,
      this.dataFanExternal,
      this.dataFanInternal,
      this.dataUrlPhotoFront,
      this.dataUrlPhotoBack});
}

class TrialCheckData {
  final String dataDateTrialCheck;
  final String dataAlarmActual;
  final String dataUrlPhotoAlarmMonitor;
  final String dataUrlPhotoAlarmModul;

  TrialCheckData({
    this.dataDateTrialCheck,
    this.dataAlarmActual,
    this.dataUrlPhotoAlarmMonitor,
    this.dataUrlPhotoAlarmModul,
  });
}

class WashData {
  final String dataDateWash;
  final String dataUrlPhotoWash;

  WashData({
    this.dataDateWash,
    this.dataUrlPhotoWash,
  });
}

class RepairData {
  final String dataDateRepair;
  final String dataBrokenComponent;
  final String dataUrlPhotoComponent;
  final String dataComponentPosition;
  final String dataLotComponent;
  final String dataUrlPhotoTrack;

  RepairData({
    this.dataDateRepair,
    this.dataBrokenComponent,
    this.dataUrlPhotoComponent,
    this.dataComponentPosition,
    this.dataLotComponent,
    this.dataUrlPhotoTrack,
  });
}

class TrialData {
  final String dataDateTrial;
  final String dataAlarmAfterRepair;
  final String dataUrlPhotoAlarmAfterRepairMonitor;
  final String dataUrlPhotoAlarmAfterRepairModul;
  final String dataStatusRepair;

  TrialData(
      {this.dataDateTrial,
      this.dataAlarmAfterRepair,
      this.dataUrlPhotoAlarmAfterRepairMonitor,
      this.dataUrlPhotoAlarmAfterRepairModul,
      this.dataStatusRepair});
}

class PackingData {
  final String dataDatePacking;
  final String dataUrlPhotoPacking;

  PackingData({
    this.dataDatePacking,
    this.dataUrlPhotoPacking,
  });
}
