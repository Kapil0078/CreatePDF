// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pdf_generate/PDF/create_invoice.dart';
import 'package:pdf_generate/view_pdf_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF View"),
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final pdf = await createInvoice();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPDFScreen(pdf: pdf),
                  ),
                );
              },
              child: const Text("ViewPDF"),
            ),
          ],
        ),
      ),
    );
  }
}
