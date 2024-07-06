import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class FileService {
  //Constants
  static const _audioFilesDirectory = 'audio';
  static const _pdfDirectory = 'pdfs';
  static const _imageDirectory = 'image';
  final Uuid _uuid = const Uuid();

  ///Returns the applications document directory as a string
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    log("Local path: ${directory.path}");
    return directory.path;
  }

  //Creates an audio directory inside the applications documents directory
  Future<String> createAudioDirectory() async {
    var localPath = await _localPath;
    var fullPath = path.join(localPath, _audioFilesDirectory);
    log("Audio Directory path: $fullPath");
    return await createDirectory(fullPath);
  }

  ///Creates an Audio file with unique time based identifer
  ///Audio file is created with .m4a audio file extension
  Future<String> createAudioFile() async {
    var directory = await createAudioDirectory();
    var fileName = "${_uuid.v1()}.m4a";
    var fullPath = path.join(directory, fileName);
    var file = File(fullPath);
    log("File created at: ${file.path}", name: 'Audio');
    return file.path;
  }

  Future<String> createDirectory(String directoryPath) async {
    bool isDirectoryCreated = await Directory(directoryPath).exists();
    if (!isDirectoryCreated) {
      Directory(directoryPath).create().then((Directory directory) {
        log("Directory created at : ${directory.path}");
        return directory.path;
      });
    }
    log('Directory already exists at: $directoryPath');
    return directoryPath;
  }

  //PDF
  Future<String> _createPDFDirectory() async {
    var localPath = await _localPath;
    var fullPath = path.join(localPath, _pdfDirectory);
    log("PDF Directory path: $fullPath");
    return await createDirectory(fullPath);
  }

  //Images
  Future<String> _createImageDirectory() async {
    final localPath = await _localPath;
    final fullPath = path.join(localPath, _imageDirectory);
    log("Image Directory path: $fullPath");
    return await createDirectory(fullPath);
  }

  Future<String> downloadAndSavePdf({required String pdfUrl}) async {
    var directoryPath = await _createPDFDirectory();
    var fullPath = path.join(directoryPath, 'actionplans.pdf');
    final file = File(fullPath);
    if (await file.exists()) {
      return file.path;
    }

    final response = await http.get(Uri.parse(pdfUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  Future<String?> getImagePath({required String fileName}) async {
    var directoryPath = await _createImageDirectory();
    var fullPath = path.join(directoryPath, fileName);
    final file = File(fullPath);
    if (await file.exists()) {
      return file.path;
    }
    return null;
  }
}
