import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

Future<Uint8List> createInvoice() async {
  final pdf = Document();

  //Font
  final w100 = await rootBundle.load("assets/fonts/Montserrat-ExtraLight.ttf");
  final w200 = await rootBundle.load("assets/fonts/Montserrat-Light.ttf");
  final w300 = await rootBundle.load("assets/fonts/Montserrat-Thin.ttf");
  final w400 = await rootBundle.load("assets/fonts/Montserrat-Regular.ttf");
  final w500 = await rootBundle.load("assets/fonts/Montserrat-Medium.ttf");
  final w600 = await rootBundle.load("assets/fonts/Montserrat-SemiBold.ttf");
  final w700 = await rootBundle.load("assets/fonts/Montserrat-Bold.ttf");
  final w800 = await rootBundle.load("assets/fonts/Montserrat-ExtraBold.ttf");
  final w900 = await rootBundle.load("assets/fonts/Montserrat-Black.ttf");

  final font100 = Font.ttf(w100);
  final font200 = Font.ttf(w200);
  final font300 = Font.ttf(w300);
  final font400 = Font.ttf(w400);
  final font500 = Font.ttf(w500);
  final font600 = Font.ttf(w600);
  final font700 = Font.ttf(w700);
  final font800 = Font.ttf(w800);
  final font900 = Font.ttf(w900);

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

  TextStyle rowTableStyle() => TextStyle(
        color: PdfColors.grey800,
        font: font500,
        fontBold: font500,
        fontSize: 17.5,
      );

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
          Text(
            key,
            style: TextStyle(
              color: PdfColors.grey600,
              font: font700,
              fontBold: font700,
              fontSize: 20,
            ),
          ),
          SizedBox(width: width),
          Text(
            value,
            style: TextStyle(
              color: PdfColors.black,
              font: font800,
              fontBold: font800,
              fontSize: 20,
            ),
          ),
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
                SizedBox(
                  width: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mahindra Motors",
                        style: TextStyle(
                          font: font900,
                          fontBold: font900,
                          fontSize: 30,
                          color: PdfColors.grey900,
                        ),
                      ),
                      Text(
                        "+91 9727402878",
                        style: TextStyle(
                          color: PdfColors.black,
                          font: font400,
                          fontBold: font400,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Gautam Adani",
                        style: TextStyle(
                          color: PdfColors.black,
                          font: font400,
                          fontBold: font400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Adani House, Near Mithakhali Crossing, Navrangpura, Ahmedabad-380009, Gujarat, India",
                        style: TextStyle(
                          color: PdfColors.black,
                          font: font400,
                          fontBold: font400,
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
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
                1: const FlexColumnWidth(2.5),
                2: const FlexColumnWidth(2.5),
                3: const FlexColumnWidth(3),
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
                          height: 30,
                          child: Center(
                            child: Text(
                              e,
                              style: TextStyle(
                                color: PdfColors.black,
                                font: font700,
                                fontBold: font700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                ...tableRow
                    .map(
                      (e) => TableRow(
                        children: [
                          SizedBox(
                            height: 25,
                            child: Center(
                              child: Text(
                                e['item'],
                                style: rowTableStyle(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Center(
                              child:
                                  Text("${e['qty']}", style: rowTableStyle()),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Center(
                              child: Text(
                                '${e['price']}',
                                style: rowTableStyle(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: Center(
                              child: Text(
                                "${e['total']}",
                                style: rowTableStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 225,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    keyValue(
                      key: "Subtotal",
                      value:
                          "\u20B9 ${List<int>.from(tableRow.map((e) => e["total"])).toList().reduce((value, element) => value + element)}",
                    ),
                    SizedBox(height: 7),
                    keyValue(
                      key: "Tax(0%)",
                      value: "\u20B9 0",
                      width: 105,
                    ),
                    SizedBox(height: 7),
                    Divider(
                      height: 0,
                      thickness: 1.2,
                    ),
                    SizedBox(height: 7),
                    keyValue(
                      key: "Total",
                      value:
                          "\u20B9 ${List<int>.from(tableRow.map((e) => e["total"])).toList().reduce((value, element) => value + element)}",
                      width: 75,
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: const EdgeInsets.only(
                bottom: 50,
                left: 50,
              ),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Thank You",
                    style: TextStyle(
                      color: PdfColors.black,
                      font: font800,
                      fontBold: font800,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Payment Information".toUpperCase(),
                    style: TextStyle(
                      color: PdfColors.grey900,
                      font: font700,
                      fontBold: font700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "PayTm Payment Bank",
                    style: TextStyle(
                      color: PdfColors.grey800,
                      font: font500,
                      fontBold: font500,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Account Name : Mukesh Ambani",
                    style: TextStyle(
                      color: PdfColors.grey800,
                      font: font500,
                      fontBold: font500,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Account No       : 919977885566",
                    style: TextStyle(
                      color: PdfColors.grey800,
                      font: font500,
                      fontBold: font500,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "IFSC Code          : PYTM0123456",
                    style: TextStyle(
                      color: PdfColors.grey800,
                      font: font500,
                      fontBold: font500,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "PayBy                  : Jio Pay on 21/07/2023",
                    style: TextStyle(
                      color: PdfColors.grey800,
                      font: font500,
                      fontBold: font500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
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
