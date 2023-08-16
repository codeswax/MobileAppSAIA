import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:saia_mobile_app/core/api_client.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/services/secure_storage.dart';
import 'package:saia_mobile_app/widgets/dialog/dialog_implementation.dart';
import 'package:saia_mobile_app/widgets/dialog/dialog_interface.dart';
import '../models/api_data.dart';
import '../models/battery_data.dart';
import '../models/receipt_data.dart';
import '../models/report_data.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({
    super.key,
  });

  @override
  State<QRScanner> createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  late Future<List<Receipt>> receiptsList;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  final ApiClient apiClient = ApiClient();
  final DialogService dialogService = DialogImplementation();
  final ValidationService validationService = ValidationService();
  final SecureStorageService secureStorageService = SecureStorageService();

  Future<List<Receipt>> loadReceiptsList() async {
    final userData = await secureStorageService.loadUserData();
    final docData = await secureStorageService.loadDocumentAccessData();
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
  void reassemble() {
    super.reassemble();
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: ClipRect(
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.transparent,
            borderRadius: 40,
            borderLength: 40,
            borderWidth: 10,
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        validateQR(result!.code!);
        controller.pauseCamera();
      });
    });
  }

  void showResultDialog(String code) {
    final modelName =
        Battery.getProductNameFromFamilyCode(code.substring(4, 6));
    final modelCode =
        Battery.getProductModelFromFamilyCode(code.substring(28, 38));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Código QR identificado',
              style: Theme.of(context).textTheme.bodyMedium),
          content: Text(
            'S/N: $code\nFamilia: $modelName \nModelo: $modelCode',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
                controller!.resumeCamera();
              },
              child: Text(
                'Cancelar',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () async {
                Navigator.of(context).pop();
                controller!.resumeCamera();
                var completeItemName = "BATERIA $modelName $modelCode";
                var r = await receiptsList;
                var matchingReceipt = r.firstWhere(
                  (receipt) => receipt.itemName == completeItemName,
                );
                final userData = await secureStorageService.loadUserData();
                String user = userData['username']!.toString();
                String token = userData['token']!.toString();
                SerialAssignmentData serialAssignmentData =
                    SerialAssignmentData(code, user, matchingReceipt);
                try {
                  String message =
                      await apiClient.assignSerial(token, serialAssignmentData);

                  DataStorage().assignedReceipts.add(serialAssignmentData);

                  dialogService.showCompletionDialog(context, message);
                } on GeneralException catch (e) {
                  dialogService.showExceptionDialog(context, e.message);
                }
              },
              child: Text('Registrar',
                  style: Theme.of(context).textTheme.labelSmall),
            ),
          ],
        );
      },
    );
  }

  void validateQR(String code) {
    try {
      validationService.checkQR(code);
      showResultDialog(code);
    } on InvalidQRException catch (e) {
      dialogService.showExceptionDialog(context, e.message);
    } on GeneralException catch (e) {
      dialogService.showExceptionDialog(context, e.message);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
