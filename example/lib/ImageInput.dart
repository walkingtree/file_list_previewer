import 'dart:io';
import 'package:camera/camera.dart';
import 'package:example/TakePicturePage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  String _filename;

  String fileName;

  var pickedFile;

  io.File savedImage;
  io.File attachFile;

  var showDropdown = false;
  void toggleFlag() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  Future<void> _takePicture(_value) async {
    if (_value == "1") {
      pickedFile = await FilePicker.getFile(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'mp4']);
      attachFile = File(pickedFile.path);
    } else if (_value == "2") {
      pickedFile = await _showCamera();
      attachFile = File(pickedFile);
    } else if (_value == "4") {
      attachFile = await FilePicker.getFile(
          type: FileType.custom, allowedExtensions: ['pdf']);
    } else {
      //to handle audio
      return;
    }

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    fileName = path.basename(attachFile.path);
    savedImage = await attachFile.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage, attachFile.path);
    setState(() {
      _storedImage = attachFile;
      _filename = fileName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.38,
      child: DropdownButton(
        isExpanded: true,
        underline: SizedBox(),
        icon: Icon(Icons.attachment, color: Colors.green),
        hint: Text("Attach Evidence", style: TextStyle(color: Colors.green)),
        items: [
          DropdownMenuItem(
            value: "1",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.image),
//                SizedBox(
//                  width: MediaQuery.of(context).size.width*0.009,
//                ),
                Text(
                  "Image/Video",
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "2",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.camera),
                Text(
                  "Camera",
                ),
              ],
            ),
          ),
          DropdownMenuItem(
            value: "4",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.insert_drive_file),
                Text(
                  "File",
                ),
              ],
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            var _value = value;
            _takePicture(_value);
          });
        },
      ),
    );
  }

  _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));

    return result;
  }
}
