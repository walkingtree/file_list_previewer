library file_list_previewer;

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class FileListPreviewer extends StatefulWidget {
  // The list of Files
  final List<File> attachmentList;
  // The list of filepaths
  final List<String> filePaths;
  // The function to handle remove image functionality
  final Function removeImage;
  //The optional image for video files
  final String videoFileImage;
  //The width of the preview
  final double width;
  //The width of the preview
  final double height;

  const FileListPreviewer({
    this.attachmentList,
    this.filePaths,
    this.videoFileImage = "assets/images/video.png",
    this.width = 300,
    this.height = 100,
    this.removeImage,
  });

  @override
  _FileListPreviewerState createState() => _FileListPreviewerState();
}

class _FileListPreviewerState extends State<FileListPreviewer> {
  List<File> _filePathList = [];

  bool _isLoading = false;
  void _removeImage(File pickedFile) {
    setState(() {
      _filePathList.remove(pickedFile);
    });
    widget.removeImage(pickedFile);
  }

  @override
  void initState() {
    super.initState();
    if (widget.attachmentList == null && widget.filePaths != null) {
      // for (var i = 0; i < widget.filePaths.length ?? 0; i++) {
      //   File filepath = File(widget.filePaths[i]);
      //   _filePathList.add(filepath);
      // }
      // setState(() {});
      widget.filePaths.forEach(
        (element) {
          File filepath = File(element);
          _filePathList.add(filepath);
        },
      );
    } else {
      _filePathList = widget.attachmentList;
    }
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _filePathList = [];
    // });

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: widget.height,
            width: widget.width,
            child: _isLoading == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _filePathList != null ? _filePathList.length : 0,
                    itemBuilder: (BuildContext context, int index) {
                      var extn = _filePathList[index].toString().substring(
                          _filePathList[index].toString().lastIndexOf('.'),
                          _filePathList[index].toString().length - 1);
                      return GestureDetector(
                        child: Stack(
                          children: [
                            (extn == ".jpg" || extn == ".jpeg" || extn == ".png"
                                ? new Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: FileImage(_filePathList[index])
                                          //   image: new FileImage(attachFile),
                                          ),
                                    ),
                                  )
                                : (extn == '.mp4'
                                    ? Container(
                                        width: 100.0,
                                        height: 100.0,
                                        //  child:Icon(Icons.videocam,size: 40,))
                                        child: Image(
                                          image:
                                              AssetImage(widget.videoFileImage),
                                          fit: BoxFit.scaleDown,
                                        ))
                                    : Material(
                                        type: MaterialType.transparency,
                                        child: SingleChildScrollView(
                                          child: Container(
                                            width: 100.0,
                                            height: 100.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "File ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  Icon(Icons.insert_drive_file)
                                                ]),
                                          ),
                                        ),
                                      ))),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: widget.removeImage != null
                                  ? GestureDetector(
                                      onTap: () =>
                                          _removeImage(_filePathList[index]),
                                      child: Card(
                                        elevation: 10,
                                        color: Colors.white,
                                        shape: CircleBorder(),
                                        child: Icon(
                                          Icons.clear,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        ),
                        onTap: () async {
                          OpenFile.open(_filePathList[index].path);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
