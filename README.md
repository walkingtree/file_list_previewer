# file_list_previewer

A flutter package for viewing all files.

## Features:
*View all filetypes
*Remove files from list

### Getting Started


<img src="" width="200">


#### Properties

'''   final List<File> attachmentList; ''' // Pass list of files
'''  final List<String> filePaths; ''' // Pass list of filepaths
'''   final Function removeImage; ''' // Pass a function which removes the file from the list of files/filepaths.
'''    final String videoFileImage; ''' //Pass a image to show as video thumbnail
'''    final double width; ''' //  Pass width for the widget
'''   final double height; ''' // Pass height for the widget


##### Usage:

>FileListPreviewer( <br />
>    this.attachmentList, <br />
>    this.filePaths, <br />
>    this.videoFileImage = "assets/images/video.png", <br />
>    this.width = 300, <br />
>    this.height = 100, <br />
>    this.removeImage, <br />
>  );


