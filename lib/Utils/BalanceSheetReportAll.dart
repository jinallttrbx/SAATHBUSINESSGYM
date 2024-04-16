// import 'dart:io';
//
// import 'package:dio/dio.dart';
//
// import 'package:flutter/material.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:printing/printing.dart';
//
// class BalanceSheetReport {
//   Future<bool> generateSinglePdf(
//       BuildContext context,
//       String? what,
//       String? date1,
//       String? amout,
//       String? description,
//       String? transName,
//       String? transMobile,
//       String? paymentMode) async {
//     final font = await PdfGoogleFonts.nunitoExtraLight();
//     final imgUrl = "";
//     var dio;
//     pw.Document pdf = pw.Document();
//     pdf.addPage(pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         orientation: pw.PageOrientation.portrait,
//         build: (pw.Context context) => [
//               _contentHeader_partner(context, font),
//               _contentPartner(context, date1!, amout!, font, description,
//                   transName, transMobile, paymentMode),
//               pw.SizedBox(height: 20),
//             ]));
//     if (what == 'open') {
//       saveDocument(name: 'Payment Recipt.pdf', pdf: pdf, context: context);
//     } else if (what == 'share') {
//       //share pdf
//       await Printing.sharePdf(
//         bytes: await pdf.save(),
//         filename: 'vendor report.pdf',
//       );
//     }
//     //view pdf
//     return true;
//     //return saveDocument(name: '$custname.pdf', pdf: pdf);
//   }
//
//   static Future<File> saveDocument({
//     required String name,
//     required pw.Document pdf,
//     required BuildContext context,
//   }) async {
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$name');
//     openFile(file);
//     print("file path === ${dir.path}");
//     await file.writeAsBytes(await pdf.save());
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.storage,
//     ].request();
//     // if (statuses[Permission.storage]!.isGranted) {
//     //   var dir1 = await DownloadsPathProvider.downloadsDirectory;
//     //   if (dir1 != null) {
//     //     String savename1 = "file.pdf";
//     //     String savePath1 = dir1.path + "/$savename1";
//     //     print(savePath1);
//     //     try {
//     //       await Dio().download(file.path, savePath1,
//     //           onReceiveProgress: (received, total) {
//     //         if (total != -1) {
//     //           print((received / total * 100).toStringAsFixed(0) + "%");
//     //         }
//     //       });
//     //       print("File is saved to download folder.");
//     //     } on DioError catch (e) {
//     //       print(e.message);
//     //     }
//     //   }
//     // } else {
//     //   print("No permission to read and write.");
//     // }
//     return file;
//   }
//
//   Future download2(Dio dio, String url, String savePath) async {
//     //get pdf from link
//     Response response = await dio.get(
//       url,
//       options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           validateStatus: (status) {
//             return status! < 500;
//           }),
//     );
//     File file = File(savePath);
//     var raf = file.openSync(mode: FileMode.write);
//     raf.writeFromSync(response.data);
//     await raf.close();
//   }
//
//   static Future openFile(File file) async {
//     final url = file.path;
//     await OpenFile.open(url);
//   }
//
//   static pw.Widget _buildHeader(pw.Context context) {
//     return pw.SizedBox(
//       height: 0,
//     );
//   }
//
//   static String convertdate(String edate) {
//     String tempstring = edate.toString();
//     return " " +
//         tempstring.substring(6, 8) +
//         "/" +
//         tempstring.substring(4, 6) +
//         "/" +
//         tempstring.substring(0, 4);
//   }
//
//   _contentHeader_partner(pw.Context context, pw.Font font) {
//     return pw.Container(
//         child: pw.Center(
//             child: pw.Text("Payment Receipt",
//                 style: pw.TextStyle(
//                     font: font,
//                     fontSize: 35,
//                     color: PdfColor.fromHex('000000'),
//                     fontWeight: pw.FontWeight.bold))));
//   }
//
//   _contentPartner(
//       pw.Context context,
//       String date1,
//       String amout,
//       pw.Font font,
//       String? description,
//       String? transName,
//       String? transMobile,
//       String? paymentMode) {
//     return pw.Container(
//         child: pw.Column(
//       children: [
//         pw.Row(children: [
//           pw.Text("Date : -",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           pw.Text(date1.toString(),
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//         ]),
//         pw.Row(children: [
//           pw.Text("Amount : -",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           pw.Text(amout.toString(),
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//         ]),
//         pw.Row(children: [
//           pw.Text("Description : -",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           pw.Text(description.toString(),
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//         ]),
//         pw.Row(children: [
//           pw.Text("Client Name : -",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           pw.Text(transName.toString(),
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//         ]),
//         pw.Row(children: [
//           pw.Text("Mobile Number : -",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           pw.Text(transMobile.toString(),
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//         ]),
//         pw.Row(children: [
//           pw.Text("Payment Type : -",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           pw.Text(paymentMode.toString(),
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//         ]),
//         pw.SizedBox(height: 80),
//         pw.Row(children: [
//           pw.Text("This Receipt is System Generated",
//               style: pw.TextStyle(
//                   font: font, fontSize: 20, color: PdfColor.fromHex('000000'))),
//           // pw.Text(amout.toString(),style: pw.TextStyle(font: font,fontSize: 20,color:PdfColor.fromHex('000000'))),
//         ]),
//       ],
//     ));
//   }
//
// ///////////////////////////////////////expance account ///////////////////////////
//
// ///////////////////////////////////////////////////// vendor /////////////////////////////////////////
//
// //////////////////////////////////////////////////////////////////////////////////////////////////////////
// }
