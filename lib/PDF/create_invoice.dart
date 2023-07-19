import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> createInvoice() async {
  final pdf = Document();

  //logo
  final logo = (await rootBundle.load("assets/images/Mahindra-Logo.png"))
      .buffer
      .asUint8List();

  // Tables Data
  final tableHeader = <String>["Item", "Quantity", "Unit Price", "Total"];
  final tableRow = <Map<String, dynamic>>[
    {
      "item": "Engine Oils",
      "qty": 5,
      "price": 300,
      "total": 1500,
    },
    {
      "item": "Break Wire",
      "qty": 550,
      "price": 100,
      "total": 55000,
    },
    {
      "item": "Battery",
      "qty": 10,
      "price": 15000,
      "total": 150000,
    },
    {
      "item": "Wiper",
      "qty": 50,
      "price": 500,
      "total": 25000,
    },
  ];
  // Create PDFWidget
  Widget pdfWidget() => Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  height: 150,
                  width: 150,
                  MemoryImage(logo),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mahindra Motors",
                      style: const TextStyle(
                        fontSize: 30,
                        color: PdfColors.grey700,
                      ),
                    ),
                    Text("+91 9727402878"),
                    Text("Vraj Shah"),
                    Text("A 102, VibrantVelly, Near Tapi River"),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Divider(
                height: 0,
                thickness: 1.5,
                color: PdfColors.black,
              ),
            ),
            Table(
              children: [
                TableRow(
                  children: tableHeader
                      .map(
                        (e) => Text(e),
                      )
                      .toList(),
                ),
                ...tableRow
                    .map(
                      (e) => TableRow(
                        children: [
                          Text(e['item']),
                          Text("${e['qty']}"),
                          Text('${e['price']}'),
                          Text("${e['total']}"),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
      );

  pdf.addPage(
    Page(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      orientation: PageOrientation.portrait,
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pdfWidget();
      },
    ),
  );

  return await pdf.save();

  // return await Printing.layoutPdf(
  //   onLayout: (format) async {
  //     return await pdf.save();
  //   },
  // );
}
