import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerPage extends StatelessWidget {
  const PhotoViewerPage({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(language!.photo)),
      body: PhotoView(
        imageProvider: FileImage(File(path)),
        backgroundDecoration: const BoxDecoration(color: Colors.white),
        tightMode: true,
      ),
    );
  }
}
