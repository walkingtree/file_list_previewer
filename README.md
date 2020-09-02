# file_list_previewer

A flutter package for viewing a list of local files in the form of clickable thumbnails.

## Features:
* Covers different file types
* Presents the thumbnails for different types of files
* Preview of the file by clicking on the thumbnail 
* Dynamically Remove files from list and handle it back in the parent widget

### Getting Started

<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(2).jpg" width="200">
 <br />
<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02.jpg" width="200">
 <br />
<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(1).jpg" width="200">


#### Properties:

```final List<File> attachmentList;```    *// Pass list of files*<br />
```final List<String> filePaths;```       *// Pass list of filepaths*<br />
```final Function removeImage;```         *// Pass a function which removes the file from the list of files/filepaths.*<br />
```final String videoFileImage;```        *//Pass a image to show as video thumbnail* <br />
```final double width;```                 *//Pass width for the widget*<br />
```final double height;```                *//Pass height for the widget*<br />


##### Usage:
//Either one of the attachmentList or filePaths should be passed
>FileListPreviewer( <br />
>    attachmentList : attachmentList <br />
>    filePaths : filePaths <br />
>    videoFileImage : videoFileImage  <br />
>    width : 10  <br />
>    height : 10 <br />
>    removeImage :  removeImage() <br />
>  );

