import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> createInvoice() async {
  final pdf = Document();

  //Font

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
    }
  ];

  // keyValue

  Widget keyValue({
    required String key,
    required String value,
    double width = 40,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key),
          SizedBox(width: width),
          Text(value),
        ],
      );
  // Create PDFWidget
  Widget pdfWidget() => Container(
        width: double.maxFinite,
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
              padding: const EdgeInsets.only(top: 20, bottom: 35),
              child: Divider(
                height: 0,
                thickness: 1.5,
                color: PdfColors.black,
              ),
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: <int, TableColumnWidth>{
                0: const FlexColumnWidth(3),
                1: const FlexColumnWidth(1),
                2: const FlexColumnWidth(1),
                3: const FlexColumnWidth(2),
              },
              border: TableBorder.symmetric(
                inside: const BorderSide(
                  color: PdfColors.grey500,
                  width: 0.75,
                ),
                outside: const BorderSide(
                  color: PdfColors.black,
                  width: 1,
                ),
              ),
              children: [
                TableRow(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  decoration: BoxDecoration(
                    color: PdfColor.fromHex("C0C0C0"),
                  ),
                  children: tableHeader
                      .map(
                        (e) => SizedBox(
                          height: 25,
                          child: Center(child: Text(e)),
                        ),
                      )
                      .toList(),
                ),
                ...tableRow
                    .map(
                      (e) => TableRow(
                        children: [
                          SizedBox(
                            height: 20,
                            child: Center(child: Text(e['item'])),
                          ),
                          SizedBox(
                            height: 20,
                            child: Center(child: Text("${e['qty']}")),
                          ),
                          SizedBox(
                            height: 20,
                            child: Center(child: Text('${e['price']}')),
                          ),
                          SizedBox(
                            height: 20,
                            child: Center(child: Text("${e['total']}")),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                  width: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      keyValue(
                        key: "Subtotal",
                        value: List<int>.from(tableRow.map((e) => e["total"]))
                            .toList()
                            .reduce((value, element) => value + element)
                            .toString(),
                      ),
                      keyValue(
                        key: "Tax(0%)",
                        value: "0",
                      ),
                      Divider(
                        height: 0,
                        thickness: 1.2,
                      ),
                      keyValue(
                        key: "Total",
                        value: List<int>.from(tableRow.map((e) => e["total"]))
                            .toList()
                            .reduce((value, element) => value + element)
                            .toString(),
                        width: 58,
                      )
                    ],
                  )),
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
