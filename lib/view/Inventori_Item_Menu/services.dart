import 'package:cloud_firestore/cloud_firestore.dart';

String databaseId = '';
String inventoriId = '';
bool isDataIdAvailable = false;
String noImageUrl =
    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png';
List<bool> checkUrlEnable = [
  false,
  false,
];
List<String> downloadUrlLink = [
  noImageUrl,
  noImageUrl,
];

class DatabaseServices {
  static CollectionReference dataInventoriRef =
      Firestore.instance.collection('Inventori Barang');

//Inventori

  static Future<void> createOrUpdateInventoriData(
    String id, {
    String dataInventoriId,
    String date,
    String partNumber,
    String serialNumber,
    String urlPhotoFront,
    String urlPhotoBack,
    List<String> dataIndexList,
  }) async {
    await dataInventoriRef.document(inventoriId).setData({
      'ID': dataInventoriId.toUpperCase(),
      'Tanggal_Masuk': date,
      'Part_Number': partNumber,
      'Serial_Number': serialNumber,
      'Url_Foto_Depan': urlPhotoFront,
      'Url_Foto_Belakang': urlPhotoBack,
      'searchIndex': dataIndexList
    }, merge: true);
  }

  static Future<void> addIndexToDatabase(
    String id, {
    List<String> dataIndexList,
  }) async {
    await dataInventoriRef
        .document(databaseId)
        .setData({'searchIndex': dataIndexList}, merge: true);
  }

  Stream<InventoriData> get dataInvetori {
    return dataInventoriRef
        .document(databaseId)
        .snapshots()
        .map(_inventoriDataFromSnapShot);
  }

  InventoriData _inventoriDataFromSnapShot(DocumentSnapshot snapshot) {
    return InventoriData(
      dataDateIn: snapshot.data['Tanggal_Masuk'],
      dataPartNumber: snapshot.data['Part_Number'],
      dataSerialNumber: snapshot.data['Serial_Number'],
      dataUrlPhotoFront: snapshot.data['Url_Foto_Depan'],
      dataUrlPhotoBack: snapshot.data['Url_Foto_Belakang'],
    );
  }
}

class InventoriData {
  final String dataDateIn;

  final String dataPartNumber;
  final String dataSerialNumber;
  final String dataUrlPhotoFront;
  final String dataUrlPhotoBack;

  InventoriData(
      {this.dataDateIn,
      this.dataPartNumber,
      this.dataSerialNumber,
      this.dataUrlPhotoFront,
      this.dataUrlPhotoBack});
}
