
import 'package:example/file_List_Preview.dart';
import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'ImageInput.dart';
import 'dart:io' as io;

void main() {
  runApp(MyApp(

  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
               visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<io.File> attachmentList = [];
  List<String> fileattachmentList = [];
  void _selectImage(io.File pickedImage, filename) {

    setState(() {

      attachmentList.add(pickedImage);
      fileattachmentList.add(pickedImage.path);
    });
  }

  void _removeImage(io.File pickedFile) {

    setState(() {
      attachmentList.remove(pickedFile);
      fileattachmentList.remove(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title:Text("File List Preview Example")
      ),
      body: Column(
       // crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: ImageInput(_selectImage),
            ),
          ),
          attachmentList.length >= 1
              ? Padding(
            padding: const EdgeInsets.all(5),
            child: FileListPreviewer(
              removeImage: _removeImage,
              attachmentList: attachmentList,
              filePaths: fileattachmentList,
            ),
          )
              : SizedBox(),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
