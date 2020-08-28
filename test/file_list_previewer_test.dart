 import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

 import 'package:file_list_previewer/file_list_previewer.dart';

 void main() {
  testWidgets('file list preview', (WidgetTester tester)async{

   await tester.pumpWidget(FileListPreviewer());

   final singleChildScrollViewFinder  = find.byKey(ValueKey("singlechildkey"));
   expect(singleChildScrollViewFinder, findsOneWidget);

   final containerFinder  = find.byKey(ValueKey("containerkey"));
   expect(containerFinder, findsOneWidget);

   final listViewFinder  = find.byKey(ValueKey("listviewkey"));
   expect(listViewFinder, findsOneWidget);


  });

 }
