import 'dart:io';
import 'package:camera/camera.dart';
import 'package:example/TakePicturePage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:provider/provider.dart';
import 'dart:io' as io;
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;



//List<CameraDescription> cameras;
// var camera;

//Future<void> main() async {
//  cameras = await availableCameras();
//}

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
  // String fileDocName;
  io.File savedImage;
  io.File attachFile;
  // final TextEditingController txt = TextEditingController();
  var showDropdown = false;
  void toggleFlag() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  Future<void> _takePicture(_value) async {
    // print('In take picture');

    if (_value == "1") {
      pickedFile = await FilePicker.getFile(
          type: FileType.custom, allowedExtensions: ['jpg', 'png', 'mp4']);
      attachFile = File(pickedFile.path);
    } else if (_value == "2") {
      //  CameraApp(_captImage);
      //camera code goes here///
//      PermissionStatus permissionStatus = await _getPermission(PermissionGroup.camera);
//      print(permissionStatus);
//      if (permissionStatus == PermissionStatus.granted) {
//         pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
//
//      }
//      final ImagePicker _picker = ImagePicker();
//      pickedFile =  await _picker.getImage(source: ImageSource.camera);
//      attachFile = File(pickedFile.path);

      pickedFile = await _showCamera();
      attachFile = File(pickedFile);
    } else if (_value == "4") {
      attachFile = await FilePicker.getFile(
          type: FileType.custom, allowedExtensions: ['pdf']);

      // fileDocName = path.basename(attachFile.path);
      // setState(() {
      //   savedImage = attachFile;
      // });
    } else {
      //to handle audio
      return;
    }
    //  print(fileName);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    fileName = path.basename(attachFile.path);
    savedImage = await attachFile.copy('${appDir.path}/$fileName');
    // print(fileName);
    // print(savedImage);
    widget.onSelectImage(savedImage, attachFile.path);
    setState(() {
      _storedImage = attachFile;
      _filename = fileName;
      // txt.text = fileName;
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
//                SizedBox(
//                  width: MediaQuery.of(context).size.width*0.009,
//                ),
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
//                SizedBox(
//                  width: MediaQuery.of(context).size.width*0.009,
//                ),
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
        //  value: _value,
        // underline: SizedBox(),
        // icon: Icon(Icons.attach_file),
        // isExpanded: true,
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

//  void _captImage(File pickedImage, filename) {
//
//    setState(() {
//      _incident.incidentFile.add(pickedImage);
//      attachmentList.add(pickedImage);
//    });
//  }

//  Future<PermissionStatus> _getPermission(perm) async {
//    PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(perm);
//    if (permission != PermissionStatus.granted &&
//        permission != PermissionStatus.disabled) {
//      Map<PermissionGroup, PermissionStatus> permisionStatus =
//      await PermissionHandler()
//          .requestPermissions([perm]);
//      return permisionStatus[perm] ??
//          PermissionStatus.unknown;
//    } else {
//      print(permission);
//      return permission;
//    }
//  }
}
