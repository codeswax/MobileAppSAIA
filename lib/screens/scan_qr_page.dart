import 'package:flutter/material.dart';
import 'package:saia_mobile_app/main.dart';
import 'package:saia_mobile_app/models/api_data.dart';
import 'package:saia_mobile_app/models/report_data.dart';
import '../core/api_client.dart';
import '../exceptions/custom_exceptions.dart';
import '../models/receipt_data.dart';
import '../services/secure_storage.dart';
import '../widgets/available_receipts_container.dart';
import '../widgets/qr_scanner.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  late Future<List<Receipt>> receiptsList;
  late List<Receipt> assignedReceipts;
  final SecureStorageService storageService = SecureStorageService();
  final ApiClient apiClient = ApiClient();

  Future<List<Receipt>> loadReceiptsList() async {
    final userData = await storageService.loadUserData();
    final docData = await storageService.loadDocumentAccessData();
    try {
      return receiptsList = apiClient.consultReceipts(
          userData['token']!.toString(),
          ReceiptQueryData(int.parse(userData['local']!.toString()), 'FAC',
              int.parse(docData['doc']!.toString())));
    } on GeneralException catch (e) {
      throw GeneralException(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    receiptsList = loadReceiptsList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff5C5E5F),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 70, 71, 72),
          title: Text(
            'Escanea',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.receipt_long),
              tooltip: 'Ver recibos sin serie',
              onPressed: () async {
                final loadedReceipts = loadReceiptsList();
                goToAvailableReceiptsPage(await loadedReceipts);
              },
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Align(
            child: Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,
              children: [
                const QRScanner(),
                Row(
                  children: [
                    const Icon(
                      Icons.live_help,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: Text(
                        "Mantén fijo el celular para hasta que se capture correctamente.",
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToAvailableReceiptsPage(List<Receipt> loadedReceipts) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailableReceiptsContainer(
            receipts: loadedReceipts, dataStorage: dataStorage),
      ),
    );
  }
}
