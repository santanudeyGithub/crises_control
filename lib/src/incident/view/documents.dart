import 'package:crises_control/src/CustomAppbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';

class Documents extends StatefulWidget {
  const Documents({super.key});

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  String? _filePath;
  Future<String?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path;
    } else {
      return null;
    }
  }

  Future<void> _openPDFViewer() async {
    String? filePath = await _pickFile();

    if (filePath != null) {
      setState(() {
        _filePath = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              //title: language!.title_incident_messages,
              title: 'Documents',
            ),
          ),
          Positioned(
            top: 420, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: SingleChildScrollView(
              child: Center(
                child: _filePath == null
                    ? Text(
                        'No PDF selected.',
                        style: GoogleFonts.urbanist(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0B223C)),
                      )
                    : PDFView(
                        filePath: _filePath!,
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 200.0,
                  minWidth: 500.0,
                ),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _openPDFViewer,
                        child: Text('Open PDF Viewer'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
