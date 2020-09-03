# file_list_previewer

A flutter package for viewing a list of local files in the form of clickable thumbnails.

## Features:
* Covers different file types
* Presents the thumbnails for different types of files
* Preview of the file by clicking on the thumbnail 
* Dynamically Remove files from list and handle it back in the parent widget

### Getting Started

<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02.jpg" width="200">
<br />
<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(2).jpg" width="200">
<br />
<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(3).jpg" width="200">
<br />
<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(4).jpg" width="200">
<br />
<img src="https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(1).jpg" width="200">
<br />
![alt text](https://github.com/walkingtree/file_list_previewer/blob/master/assets/images/2020-09-02%20(1).jpg?raw=true)


#### Properties:

```final List<File> attachmentList;```    *// the list of files to be displayed*<br />
```final List<String> filePaths;```       *// the list of local filepaths of files to be displayed*<br />
```final Function removeImage;```         *// An optional function parameter to handle file removal from the list of files/filepaths in parent widget*<br />
```final String videoFileImage;```        *//The thumbnail image for video thumbnail to be used instead of default* <br />
```final double width;```                 *//Pass width for the widget*<br />
```final double height;```                *//Pass height for the widget*<br />


##### Usage:
*//Either one of the attachmentList or filePaths should be passed*
```final List<File> attachmentList;```    *// the list of files to be displayed*<br />
```final List<String> filePaths;```       *// the list of local filepaths of files to be displayed*<br />
```final Function removeImage;```         *// An optional function parameter to handle file removal from the list of files/filepaths in parent widget*<br />
```final String videoFileImage;```        *//The thumbnail image for video thumbnail to be used instead of default* <br />
```final double width;```                 *//the width for the widget*<br />
```final double height;```                *//the height for the widget*<br />


