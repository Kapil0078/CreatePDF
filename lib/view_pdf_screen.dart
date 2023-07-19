import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ViewPDFScreen extends StatelessWidget {
  final Uint8List pdf;
  const ViewPDFScreen({super.key, required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View PDF"),
      ),
      body: PdfPreview.builder(
        build: (format) => pdf,
        loadingWidget: const Center(
          child: CircularProgressIndicator(
            color: Colors.deepPurple,
          ),
        ),
        initialPageFormat: PdfPageFormat.a4,
        canChangeOrientation: false,
        useActions: true,
        allowSharing: true,
        allowPrinting: true,
        canChangePageFormat: false,
        dynamicLayout: false,
        pdfFileName: "Invoice.pdf",
        pagesBuilder: (context, pages) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final page in pages)
                    Container(
                      color: Colors.white,
                      child: Image(
                        image: page.image,
                        width: page.width.toDouble(),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
