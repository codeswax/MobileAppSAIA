import 'package:flutter/material.dart';
import 'package:saia_mobile_app/core/api_client.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import '../services/secure_storage.dart';

class ReceiptDataWidget extends StatefulWidget {
  const ReceiptDataWidget({super.key});
  @override
  State<ReceiptDataWidget> createState() => _ReceiptDataWidgetState();
}

class _ReceiptDataWidgetState extends State<ReceiptDataWidget> {
  late TextEditingController _docIdController;
  final ApiClient _apiClient = ApiClient();
  final SecureStorageService storageService = SecureStorageService();

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
              _validateReceiptData();
            },
            child:
                Text("Ingresar", style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ],
    );
  }

  Future<void> _validateReceiptData() async {
    try {
      final userData = await storageService.loadUserData();
      checkReceiptData(_docIdController.text);
      await _apiClient.consultAvailabilityOfReceipts(
          userData['token']!.toString(),
          int.parse(userData['local']!.toString()),
          'FAC',
          int.parse(_docIdController.text));
      _toScanQR();
    } on InvalidInputException catch (e) {
      _showDialogInvalidReceiptData(e.message);
    } on GeneralException catch (e) {
      _showDialogInvalidReceiptData(e.message);
    }
  }

  Future<void> _toScanQR() async {
    if (!context.mounted) return;
    Navigator.pushNamed(context, '/scanQR');
  }

  Future<void> _showDialogInvalidReceiptData(String content) async {
    if (!context.mounted) return;
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                'ERROR',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              content: Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'OK',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ));
  }
}
