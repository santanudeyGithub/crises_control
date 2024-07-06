import 'package:bloc/bloc.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/services/file_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  PdfCubit(this._fileService, this.pdfUrl) : super(const PdfState('', null));
  final FileService _fileService;
  final String pdfUrl;

  Future<String> _downloadPDF({required String pdfUrl}) async {
    var path = await _fileService.downloadAndSavePdf(pdfUrl: pdfUrl);
    return path;
  }

  displayPDFromURL() async {
    var path = await _downloadPDF(pdfUrl: pdfUrl);
    emit(PdfState(path, null));
  }
}
