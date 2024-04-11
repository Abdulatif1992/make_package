import 'package:flutter/material.dart';
import 'package:epub_reader_make_pages/epub_reader_make_pages.dart';
import 'dart:io' as io;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:make_package/models/books.dart';

class SeconScreen extends StatefulWidget {
  const SeconScreen({super.key});

  @override
  State<SeconScreen> createState() => _SeconScreenState();
}

class _SeconScreenState extends State<SeconScreen> {


  @override
  Widget build(BuildContext context) {   
    //return  ScrollBarExp(data: html, page: 4, location: 0, fullHtml: fullHtml);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ 
          ElevatedButton(
            onPressed: () { saveFromAssetToLocal();},
            child: const Text('Save file to local'),
          ),  
          const SizedBox(height: 10), 
          ElevatedButton(
            onPressed: () async{ 
              BuildContext currentContext = context;
              GetListFromEpub getList = GetListFromEpub(name:'eliot-small.epub');
              var htmlAndTitle = await getList.parseEpubWithChapters(); 
              List<String> htmlList =    htmlAndTitle.item1;          
              String fullHtml = htmlList.last;
              htmlList.length = htmlList.length-1;  
              List<BookTitle> titles = htmlAndTitle.item2;
              
              // Use the captured context inside the async function.
              if (!currentContext.mounted) return;
              await Navigator.of(currentContext).push(MaterialPageRoute(
                builder: (context) => ScrollBarExp(
                  data: htmlList,
                  page: 1,
                  location: 0,
                  fullHtml: fullHtml,
                  titles: titles,
                ),
              ));             
            },
            child: const Text('Open ScrollbarExp'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async{ 
              BuildContext currentContext = context;
              GetListFromEpub getList = GetListFromEpub(name:'eliot-small.epub');
              var htmlAndTitle = await getList.parseEpubWithChapters(); 
              List<String> htmlList =    htmlAndTitle.item1;          
              String fullHtml = htmlList.last;
              htmlList.length = htmlList.length-1;  
              List<BookTitle> titles = htmlAndTitle.item2;
              
              // Use the captured context inside the async function.
              if (!currentContext.mounted) return;
              await Navigator.of(currentContext).push(MaterialPageRoute(
                builder: (context) => ScrollBarExp2(
                  data: htmlList,
                  page: 1,
                  location: 0,
                  fullHtml: fullHtml,
                  titles: titles,
                ),
              ));               
            },
            child: const Text('Open ScrollbarExp2'),
          ),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async{ 
              BuildContext currentContext = context;
              GetListFromEpub getList = GetListFromEpub(name:'eliot-small.epub');
              var htmlAndTitle = await getList.parseEpubWithChapters(); 
              List<String> htmlList =    htmlAndTitle.item1;          
              String fullHtml = htmlList.last;
              htmlList.length = htmlList.length-1;  
              List<BookTitle> titles = htmlAndTitle.item2;
              
              int page = 0;
              double location = 0;

              bool checker = await SessionManager().containsKey("10001");
              if(checker)
              {
                HtmlBook book  = HtmlBook.fromJson( await SessionManager().get("10001"));
                page = book.page!;
                location = book.location;
              }
              // Use the captured context inside the async function.
              if (!currentContext.mounted) return;
              await Navigator.of(currentContext).push(MaterialPageRoute(
                builder: (context) => ScrollBarExp3(
                  bookId: '10001',
                  data: htmlList,
                  page: page,
                  location: location,
                  fullHtml: fullHtml,
                  titles: titles,
                ),
              ));               
            },
            child: const Text('Open ScrollbarExp3'),
          ),
        ],
      ),
    );
  }

  Future<void> saveFromAssetToLocal() async{
    
    var dir = await getApplicationDocumentsDirectory();

    // Specify the asset file name
    String filename = 'eliot-small.epub';
    
    io.File file = io.File('${dir.path}/$filename');
    

    ByteData data = await rootBundle.load('assets/$filename');
    List<int> bytes = data.buffer.asUint8List();

    await file.writeAsBytes(bytes);
  }

}