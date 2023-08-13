import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

Future<void> generatePDF(pw.Widget content) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: content,
        );
      },
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}
