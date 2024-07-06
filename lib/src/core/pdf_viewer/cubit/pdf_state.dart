part of 'pdf_cubit.dart';

@immutable
class PdfState extends Equatable {
  const PdfState(this.pdfFilePath, this.error);
  final String pdfFilePath;
  final CCError? error;

  @override
  List<Object?> get props => [pdfFilePath, error];
}
