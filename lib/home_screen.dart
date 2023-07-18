import 'package:flutter/cupertino.dart';
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
              onPressed: () async=>await createInvoice() ,
              child: const Text("ViewPDF"),
            ),
          ],
        ),
      ),
    );
  }
}
