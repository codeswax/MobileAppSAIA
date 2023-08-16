import 'package:flutter/material.dart';
import 'package:saia_mobile_app/core/api_client.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';
import 'package:saia_mobile_app/models/api_data.dart';
import 'package:saia_mobile_app/widgets/dialog/dialog_implementation.dart';
import 'package:saia_mobile_app/widgets/dialog/dialog_interface.dart';

class UserCredentialsWidget extends StatefulWidget {
  const UserCredentialsWidget({super.key});

  @override
  State<UserCredentialsWidget> createState() => _UserCredentialsWidgetState();
}

class _UserCredentialsWidgetState extends State<UserCredentialsWidget> {
  late TextEditingController userController;
  late TextEditingController passController;
  late TextEditingController localController;
  final ApiClient apiClient = ApiClient();
  final DialogService dialogService = DialogImplementation();
  final ValidationService validationService = ValidationService();

  @override
  void initState() {
    super.initState();
    userController = TextEditingController();
    passController = TextEditingController();
    localController = TextEditingController();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        buildTextField(
          controller: userController,
          labelText: 'Usuario',
        ),
        const SizedBox(
          height: 10,
        ),
        buildTextField(
          controller: passController,
          labelText: 'Contraseña',
          obscureText: true,
        ),
        const SizedBox(
          height: 10,
        ),
        buildTextField(
          controller: localController,
          labelText: 'Número de Local',
        ),
        const SizedBox(
          height: 20,
        ),
        buildLoginButton(context),
      ],
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        labelStyle: Theme.of(context).textTheme.bodySmall,
        labelText: labelText,
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Material(
      elevation: 5.0,
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
          LoginData credentials = LoginData(
              userController.text, passController.text, localController.text);
          proceedToLogin(context, credentials);
        },
        child: Text("Iniciar Sesión",
            style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }

  Future<void> proceedToLogin(
      BuildContext context, LoginData credentials) async {
    try {
      validationService.checkCredentials(credentials);
      await apiClient.login(credentials);
      goToEnterReceiptPage();
    } catch (e) {
      handleException(context, e);
    }
  }

  void handleException(BuildContext context, dynamic exception) {
    if (exception is AppException) {
      dialogService.showExceptionDialog(context, exception.message);
    } else {
      dialogService.showExceptionDialog(context, 'Error desconocido.');
    }
  }

  Future<void> goToEnterReceiptPage() async {
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/enterReceipt');
  }
}
