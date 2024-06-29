import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';

import 'package:businessgym/components/snackbar.dart';

import '../model/QuicktransectionreportModel.dart';

class BalanceSheetReport {
  Future<bool> generateSinglePdf(
      BuildContext context,
      String? what,
      String? date1,
      String? amout,
      String? description,
      String? transName,
      String? transMobile,
      String? paymentMode) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final imgUrl = "";
    var dio;
    pw.Document pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) => [
          _contentHeader_partner(context, font),
          _contentPartner(context, date1!, amout!, font, description,
              transName, transMobile, paymentMode),
          pw.SizedBox(height: 20),
        ]));
    final directory = await getExternalStorageDirectory();
    final file = File("${directory?.path}/example.pdf");

    final pdfBytes = await pdf.save();

    await file.writeAsBytes(pdfBytes.toList());

    DocumentFileSavePlus().saveMultipleFiles(
      dataList: [
        pdfBytes,
      ],
      fileNameList: [
        "Payment Recipt${DateTime.now()} .pdf",
      ],
      mimeTypeList: [
        "Payment Recipt${DateTime.now()} /pdf",
      ],
    ).whenComplete(() => Text(""));
    openFile(file);
    if (what == 'open') {
      saveDocument(
          name: 'Payment Recipt${DateTime.now()}.pdf',
          pdf: pdf,
          context: context);
      Methods1.orderSuccessAlert(context, "PDF Download Successfully");
      print("inside save----------------------------");
    } else if (what == 'share') {
      //share pdf
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'vendor report.pdf',
      );


    }
    //view pdf
    return true;
    //return saveDocument(name: '$custname.pdf', pdf: pdf);
  }

  static Future<File?>? saveDocument({
    required String name,
    required pw.Document pdf,
    required BuildContext context,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    openFile(file);
    print("file path === ${file.path}");
    await file
        .writeAsBytes(await pdf.save())
        .then((value) => print("value $value"));
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (statuses[Permission.storage]!.isGranted) {
      // var dir1 = await DownloadsPathProvider.downloadsDirectory;
      // if (dir1 != null) {
      //   String savename1 = "file.pdf";
      //   String savePath1 = dir1.path + "/$savename1";
      //   print(savePath1);
      //   try {
      //     await Dio().download(file.path, savePath1,
      //         onReceiveProgress: (received, total) {
      //       if (total != -1) {
      //         print((received / total * 100).toStringAsFixed(0) + "%");
      //       }
      //     });
      //     print("File is saved to download folder.");
      //   } catch (e) {
      //     print(e.toString());
      //     print("error");
      //   }
      // }
      //  } else {
      // print("No permission to read and write.");
    }
    // return file;
  }

  Future download2(Dio dio, String url, String savePath) async {
    //get pdf from link
    Response response = await dio.get(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static pw.Widget _buildHeader(pw.Context context) {
    return pw.SizedBox(
      height: 0,
    );
  }

  static String convertdate(String edate) {
    String tempstring = edate.toString();
    return " " +
        tempstring.substring(6, 8) +
        "/" +
        tempstring.substring(4, 6) +
        "/" +
        tempstring.substring(0, 4);
  }

  _contentHeader_partner(pw.Context context, pw.Font font) {
    return pw.Container(
      child: pw.Center(
        child: pw.Text(
          "Payment Receipt",
          style: pw.TextStyle(
              font: font,
              fontSize: 35,
              color: PdfColor.fromHex('000000'),
              fontWeight: pw.FontWeight.bold),
        ),
      ),
    );
  }

  _contentPartner(
      pw.Context context,
      String date1,
      String amout,
      pw.Font font,
      String? description,
      String? transName,
      String? transMobile,
      String? paymentMode) {
    return pw.Container(
        child: pw.Column(
          children: [
            pw.Row(children: [
              pw.Text("Date : -",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              pw.Text(date1.toString(),
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
            ]),
            pw.Row(children: [
              pw.Text("Amount : -",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              pw.Text(amout.toString(),
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
            ]),
            pw.Row(children: [
              pw.Text("Description : -",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              pw.Text(description==null?"-":description,
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
            ]),
            pw.Row(children: [
              pw.Text("Client Name : -",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              pw.Text(transName.toString(),
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
            ]),
            pw.Row(children: [
              pw.Text("Mobile Number : -",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              pw.Text(transMobile==null?"-":transMobile.toString(),
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
            ]),
            pw.Row(children: [
              pw.Text("Payment Type : -",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              pw.Text(paymentMode.toString(),
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
            ]),
            pw.SizedBox(height: 80),
            pw.Row(children: [
              pw.Text("This Receipt is System Generated",
                  style: pw.TextStyle(
                      font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
              // pw.Text(amout.toString(),style: pw.TextStyle(font: font,fontSize: 20,color:PdfColor.fromHex('000000'))),
            ]),
          ],
        ));
  }

///////////////////////////////////////expance account ///////////////////////////

///////////////////////////////////////////////////// vendor /////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
}

class BalanceSheetReportDownloadAll {
  Future<bool> generateSinglePdf(
      BuildContext context,
      String? what,
      String? date1,
      String? date2,
      String totalAmount,
      String totalIncome,
      String totalExpanse,
      List<SubData> transactionData,
      String username,
      String address,String city
      ) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData image = await rootBundle.load('assets/images/logo.png');

    Uint8List imageData = (image).buffer.asUint8List();
    final imgUrl = "";
    var dio;
    pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        // header: (context) => _contentHeader_partner(context, font),
        footer: (context) => _contentFooter_partner(context, font),
        maxPages: 1000,
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          return [
            _contentPartner(context, date1!, date2!, totalAmount, totalIncome,
                totalExpanse, transactionData, imageData,username,address,city),
          ];
        },
      ),
    );
    final directory = await getExternalStorageDirectory();
    final file = File("${directory?.path}/example.pdf");

    final pdfBytes = await pdf.save();

    await file.writeAsBytes(pdfBytes.toList());

    await DocumentFileSavePlus().saveMultipleFiles(
      dataList: [
        pdfBytes,
      ],
      fileNameList: [
        "Payment Recipt${DateTime.now()}.pdf",
      ],
      mimeTypeList: [
        "Payment Recipt${DateTime.now()}.pdf",
      ],
    ).whenComplete(() => Text(""));

    if (what == 'open') {
      saveDocument(name: 'Payment Recipt.pdf', pdf: pdf, context: context);
    } else if (what == 'share') {
      //share pdf
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'vendor report.pdf',
      );
    }
    //view pdf
    return true;
    //return saveDocument(name: '$custname.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
    required BuildContext context,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    openFile(file);
    print("file path === ${dir.path}");
    await file.writeAsBytes(await pdf.save());
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    // if (statuses[Permission.storage]!.isGranted) {
    //   var dir1 = await DownloadsPathProvider.downloadsDirectory;
    //   if (dir1 != null) {
    //     String savename1 = "file.pdf";
    //     String savePath1 = dir1.path + "/$savename1";
    //     print(savePath1);
    //     try {
    //       await Dio().download(file.path, savePath1,
    //           onReceiveProgress: (received, total) {
    //         if (total != -1) {
    //           print((received / total * 100).toStringAsFixed(0) + "%");
    //         }
    //       });
    //       print("File is saved to download folder.");
    //     } on DioError catch (e) {
    //       print(e.message);
    //     }
    //   }
    // } else {
    //   print("No permission to read and write.");
    // }
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static pw.Widget _buildHeader(pw.Context context) {
    return pw.SizedBox(
      height: 0,
    );
  }

  static String convertdate(String edate) {
    String tempstring = edate.toString();
    return " " +
        tempstring.substring(6, 8) +
        "/" +
        tempstring.substring(4, 6) +
        "/" +
        tempstring.substring(0, 4);
  }

  _contentHeader_partner(pw.Context context, pw.Font font) {
    return pw.Container(
      child: pw.Center(
        child: pw.Text(
          "Payment Receipt",
          style: pw.TextStyle(
              font: font,
              fontSize: 16,
              color: PdfColor.fromHex('000000'),
              fontWeight: pw.FontWeight.bold),
        ),
      ),
    );
  }

  _contentFooter_partner(pw.Context context, pw.Font font) {
    return pw.Container(
      child: pw.Center(
        child: pw.Text(
          "This Receipt is System Generated",
          style: pw.TextStyle(
            fontSize: 14,
            color: PdfColor.fromHex('000000'),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _contentPartner(
      pw.Context context,
      String date1,
      String date2,
      String totalAmount,
      String totalIncome,
      String totalExpanse,
      List<SubData> transactionData,
      Uint8List imageData,
      String username,
      String address,
      String city
      ) {
    return pw.Container(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Image(pw.MemoryImage(imageData), height: 60),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            username,
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
          pw.Text(
            address,
            style: const pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
          pw.Text(
          city,
            style: const pw.TextStyle(
              fontSize: 14,
              color: PdfColors.black,
            ),
          ),
          pw.SizedBox(height: 40),
          pw.Divider(),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  "Total Balance",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  "Total Income",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Text(
                  "Total Expanse",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black,
                  ),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Expanded(
                  child: pw.Container(
                    height: 30,
                    color: PdfColors.green300,
                    alignment: pw.Alignment.centerRight,
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Text(
                      totalAmount,
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  )),
              pw.Expanded(
                  child: pw.Container(
                    height: 30,
                    color: PdfColors.green100,
                    alignment: pw.Alignment.centerRight,
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Text(
                      totalIncome,
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  )),
              pw.Expanded(
                  child: pw.Container(
                    height: 30,
                    color: PdfColors.red100,
                    alignment: pw.Alignment.centerRight,
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Text(
                      totalExpanse,
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  )),
            ],
          ),
          pw.SizedBox(height: 40),
          pw.Divider(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                "Transaction",
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColor.fromHex('000000'),
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
          pw.Divider(),
          pw.SizedBox(height: 10),
          pw.Row(
            children: [
              pw.Text(
                "Date : ",
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColor.fromHex('000000'),
                ),
              ),
              pw.Text(
                "$date1  to  $date2",
                style: pw.TextStyle(
                  fontSize: 12,
                  color: PdfColor.fromHex('000000'),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 30),
          pw.Row(
            children: [
              pw.Expanded(
                  child: pw.Container(
                    height: 30,
                    child: pw.Text(
                      "Name",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  )),
              pw.Expanded(
                  child: pw.Container(
                    height: 30,
                    child: pw.Text(
                      "Date",
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  )),
              pw.Expanded(
                child: pw.Container(
                  height: 30,
                  child: pw.Text(
                    "Payment Method",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 30,
                  child: pw.Text(
                    "Amount",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          pw.Divider(height: 0),
          ...transactionData.map(
                (e) => pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Row(
                  children: [
                    pw.Expanded(
                        child: pw.Container(
                          height: 40,
                          alignment: pw.Alignment.centerLeft,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                          child: pw.Text(
                            e.transName ?? '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.black,
                            ),
                          ),
                        )),
                    pw.Expanded(
                        child: pw.Container(
                          height: 40,
                          alignment: pw.Alignment.centerLeft,
                          padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                          child: pw.Text(
                            e.transDate ?? '',
                            style: const pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.black,
                            ),
                          ),
                        )),
                    pw.Expanded(
                      child: pw.Container(
                        height: 40,
                        alignment: pw.Alignment.centerLeft,
                        padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                        child: pw.Text(
                          e.paymentMode ?? '',
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        height: 40,
                        color: e.flag == 'credit'
                            ? PdfColors.green100
                            : PdfColors.red100,
                        alignment: pw.Alignment.centerRight,
                        padding: const pw.EdgeInsets.symmetric(horizontal: 5),
                        child: pw.Text(
                          e.flag == 'credit'
                              ? "+${e.creditAmount}"
                              : "-${e.debitAmount}",
                          style: const pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Divider(height: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

///////////////////////////////////////expance account ///////////////////////////

///////////////////////////////////////////////////// vendor /////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////
}
