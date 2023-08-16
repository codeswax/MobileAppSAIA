import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:saia_mobile_app/models/report_data.dart';
import '../widgets/pdf_format.dart';

class PreviewPage extends StatelessWidget {
  final DataStorage dataStorage;
  const PreviewPage({Key? key, required this.dataStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 70, 71, 72),
        title: Text(
          'Reporte',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: PdfPreview(
        build: (context) => makePdf(dataStorage),
      ),
    );
  }
}
