
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'dart:ui' as ui;

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
  final key;
  //The width of the preview
  final double height;

  const FileListPreviewer({
    this.attachmentList,
    this.filePaths,
    this.videoFileImage = "assets/images/video.png",
    this.width = 300,
    this.height = 100,
    this.key,
    this.removeImage,
  });

  @override
  _FileListPreviewerState createState() => _FileListPreviewerState();
}

class _FileListPreviewerState extends State<FileListPreviewer> {
  List<File> _filePathList = [];

  bool _isLoading = false;
  //Method to remove the file attached
  void _removeImage(File pickedFile) {
    setState(() {
      _filePathList.remove(pickedFile); //removing image from the local list
    });
    widget.removeImage(
        pickedFile); // removing image from the list passed as data to file_list_previewer.
  }

  @override
  void initState() {
    super.initState();

    //If the input is filepaths,this condition converts filepaths to files else in other cases the input files are taken as input.
    // _filePathList is the local list of the data came as input,based on the input conditions checks and assigns data to the local list.

    if (widget.attachmentList == null && widget.filePaths != null) {
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

  //Widget returns a listview builder

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: new MediaQueryData.fromWindow(ui.window),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          key: ValueKey('singlechildkey'),
          child: Container(
            key: ValueKey('containerkey'),
            height: widget.height,
            width: widget.width,
            child: _isLoading == true
                ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            )
                :

            //ListView builder builds all the attached files which passed as input.
            ListView.builder(
              key: ValueKey('listviewkey'),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _filePathList != null ? _filePathList.length : 0,
              itemBuilder: (BuildContext context, int index) {
                // Finding the file extension to show appropriate thumbnail for that file type.
                //File extension is found with substring of the filename
                var extn = _filePathList[index].toString().substring(
                    _filePathList[index].toString().lastIndexOf('.'),
                    _filePathList[index].toString().length - 1);
                return GestureDetector(
                  child: Stack(
                    children: [
                      //Conditions checks for image files and shows the image with help of image widget
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
                          :
                      //Condition checks for video files and shows the thumbnail for video i.e, widget.videoFileImage
                      (extn == '.mp4'
                          ? Container(
                          width: 100.0,
                          height: 100.0,
                          //  child:Icon(Icons.videocam,size: 40,))
                          child: Image(
                            image:
                            AssetImage(widget.videoFileImage),
                            fit: BoxFit.scaleDown,
                          ))
                          :
                      //In all other cases the default file icon card is shown.
                      Material(
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
                                    "File",
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
                          onTap: () => _removeImage(_filePathList[
                          index]), //calls the _removeImage function to remove the file from list.
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
                    //OnTap the file is opened with appropriate filetype with  OpenFile  plugin.
                    OpenFile.open(_filePathList[index].path);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
