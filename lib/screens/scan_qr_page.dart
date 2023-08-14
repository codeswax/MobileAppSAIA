import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../core/api_client.dart';
import '../exceptions/custom_exceptions.dart';
import '../models/receipt_data.dart';
import '../services/secure_storage.dart';
import '../widgets/available_receipts_container.dart';
import '../widgets/qr_scanner.dart';
import '../widgets/serial_code_container.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({Key? key}) : super(key: key);

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  //bool isPanelExpanded = false;
  //late PanelController _panelController;
  late Future<List<Receipt>> receiptsList;
  final SecureStorageService storageService = SecureStorageService();
  final ApiClient _apiClient = ApiClient();

  Future<List<Receipt>> loadReceiptsList() async {
    final userData = await storageService.loadUserData();
    final docData = await storageService.loadDocumentAccessData();

    try {
      return receiptsList = _apiClient.consultReceipts(
          userData['token']!.toString(),
          int.parse(userData['local']!.toString()),
          'FAC',
          int.parse(docData['doc']!.toString()));
    } on GeneralException catch (e) {
      throw GeneralException(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    receiptsList = loadReceiptsList();
    //_panelController = PanelController();
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
                final loadedReceipts = await receiptsList;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvailableReceiptsContainer(
                      receipts: loadedReceipts,
                    ),
                  ),
                );
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
                const QRScanner(
                  receipts: [],
                ),
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
        ), /*SlidingUpPanel(
          controller: _panelController,
          minHeight: 200,
          maxHeight: MediaQuery.of(context).size.height,
          panel: AvailableReceiptsContainer(panelController: _panelController),
          collapsed: const SerialCodeContainer(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Container(
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
              const Spacer(flex: 2),
            ],
          ),
          onPanelSlide: (double pos) {
            setState(() {
              isPanelExpanded = pos > 0.2;
            });
          },
        ),*/
      ),
    );
  }
}
