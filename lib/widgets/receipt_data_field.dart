import 'package:flutter/material.dart';
import 'package:saia_mobile_app/core/api_client.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/models/api_data.dart';
import '../services/secure_storage.dart';
import 'dialog/dialog_implementation.dart';
import 'dialog/dialog_interface.dart';

class ReceiptDataWidget extends StatefulWidget {
  const ReceiptDataWidget({super.key});
  @override
  State<ReceiptDataWidget> createState() => _ReceiptDataWidgetState();
}

class _ReceiptDataWidgetState extends State<ReceiptDataWidget> {
  late TextEditingController _docIdController;
  final ApiClient apiClient = ApiClient();
  final SecureStorageService secureStorageService = SecureStorageService();
  final DialogService dialogService = DialogImplementation();
  final ValidationService validationService = ValidationService();

  @override
  void initState() {
    super.initState();
    _docIdController = TextEditingController();
  }

  @override
  void dispose() {
    _docIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _docIdController,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            hintText: 'Número de Documento',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 20,
        ),
        Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(25.0),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onPressed: () async {
              final userData = await secureStorageService.loadUserData();
              String token = userData['token']!.toString();
              int local = int.parse(userData['local']!.toString());
              proceedToValidateReceipt(token, local);
            },
            child:
                Text("Ingresar", style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ],
    );
  }

  Future<void> proceedToValidateReceipt(String token, num local) async {
    try {
      validationService.checkReceiptData(_docIdController.text);
      ReceiptQueryData receiptQueryData =
          ReceiptQueryData(local, 'FAC', int.parse(_docIdController.text));
      await apiClient.consultAvailabilityOfReceipts(token, receiptQueryData);
      goToScanQRPage();
    } on InvalidInputException catch (e) {
      dialogService.showExceptionDialog(context, e.message);
    } on GeneralException catch (e) {
      dialogService.showExceptionDialog(context, e.message);
    }
  }

  Future<void> goToScanQRPage() async {
    if (!context.mounted) return;
    Navigator.pushNamed(context, '/scanQR');
  }
}
