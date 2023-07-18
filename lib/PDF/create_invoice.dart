import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future createInvoice() async {
  final pdf = Document();
  // Create PDFWidget
  Widget pdfWidget() => Container(
        child: Center(
          child: Text('PDF'),
        ),
      );

  pdf.addPage(
    Page(
      build: (context) {
        return pdfWidget();
      },
    ),
  );

  return await Printing.layoutPdf(
    onLayout: (format) async {
      return await pdf.save();
    },
  );
}
