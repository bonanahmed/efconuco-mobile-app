import 'dart:io';
import 'variableData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

/// Widget to capture and crop the image
class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  //Which Page to be build

  /// Active image file
  File _imageFile;

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        for (int i = 0; i < checkUrlEnable.length; i++) {
          if (checkUrlEnable[i] == true) {
            checkUrlEnable[i] = false;
            isRepairAvailable = false;
            isTrialAvailable = false;
          }
        }
        Navigator.pop(context, false);
      },
      child: Scaffold(
        // Preview the image and crop it
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_imageFile != null) ...[
                Image.file(_imageFile),
                Row(
                  children: <Widget>[
                    FlatButton.icon(
                      label: Text('Ambil Ulang'),
                      icon: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                  ],
                ),
                Uploader(file: _imageFile)
              ] else ...[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Image.network(noImageUrl),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton.icon(
                        onPressed: () {
                          _pickImage(ImageSource.camera);
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Camera'),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                        icon: Icon(Icons.image),
                        label: Text('Gallery'),
                        color: Colors.blue,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  Uploader({Key key, this.file}) : super(key: key);

  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      // FirebaseStorage(storageBucket: 'gs://efconuco-mobile-app.appspot.com');
            FirebaseStorage(storageBucket: 'gs://tes-firestore-4528d.appspot.com/');


  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() {
    /// Unique file name for the file
    String filePath;

    for (int i = 0; i < downloadUrlLink.length; i++) {
      if (checkUrlEnable[i] == true && isRepairAvailable == false) {
        String _index = i.toString();
        filePath = '$dataId/$_index.png';
      } else if (checkUrlEnable[i] == true && isRepairAvailable == true) {
        String _index = i.toString();
        filePath = '$dataId/Repair ${indexRepair + 1}/$_index.png';
      } else if (checkUrlEnable[i] == true && isTrialAvailable == false) {
        String _index = i.toString();
        filePath = '$dataId/$_index.png';
      } else if (checkUrlEnable[i] == true && isTrialAvailable == true) {
        String _index = i.toString();
        filePath = '$dataId/Trial ${indexRepair + 1}/$_index.png';
      }
    }

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  Future<String> _getUrlDownload() async {
    var _downUrl = await (await _uploadTask.onComplete).ref.getDownloadURL();
    // url = _downUrl.toString();

    var url = _downUrl.toString();

    print('Download URL :$url');
    for (int i = 0; i < downloadUrlLink.length; i++) {
      if (checkUrlEnable[i] == true) {
        if (url == null) {
          downloadUrlLink[i] = '';
        } else {
          downloadUrlLink[i] = url;
          checkUrlEnable[i] = false;
        }
      }
    }

    return url;
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                // Progress bar
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
                Container(
                    padding: EdgeInsets.fromLTRB(50, 5, 50, 20),
                    child: LinearProgressIndicator(value: progressPercent)),
                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),
                if (_uploadTask.isComplete)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('File Telah di Upload'),
                    ],
                  ),
                if (_uploadTask.isComplete) ...[
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton.icon(
                          icon: Icon(Icons.arrow_back),
                          textColor: Colors.white,
                          color: Colors.blue,
                          label: Text(
                            'Back',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton.icon(
                          icon: Icon(Icons.save),
                          textColor: Colors.white,
                          color: Colors.blue,
                          label: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _getUrlDownload();
                            });
                            return Fluttertoast.showToast(
                                msg: 'Foto Telah Disimpan');
                          },
                        ),
                      ],
                    ),
                  )
                ]
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return RaisedButton.icon(
          textColor: Colors.white,
          color: Colors.blue,
          label: Text('Upload Foto'),
          icon: Icon(Icons.cloud_upload),
          onPressed: () {
            _startUpload();
          });
    }
  }
}
