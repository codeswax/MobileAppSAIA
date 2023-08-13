import 'package:flutter/material.dart';
import 'package:saia_mobile_app/core/api_client.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';

class UserCredentialsWidget extends StatefulWidget {
  const UserCredentialsWidget({super.key});

  @override
  State<UserCredentialsWidget> createState() => _UserCredentialsWidgetState();
}

class _UserCredentialsWidgetState extends State<UserCredentialsWidget> {
  late TextEditingController _userController;
  late TextEditingController _passController;
  late TextEditingController _localController;
  final ApiClient _apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
    _passController = TextEditingController();
    _localController = TextEditingController();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    _localController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: _userController,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            labelStyle: Theme.of(context).textTheme.bodySmall,
            labelText: 'Usuario',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _passController,
          obscureText: true,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            labelStyle: Theme.of(context).textTheme.bodySmall,
            labelText: 'Contraseña',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _localController,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
            ),
            labelStyle: Theme.of(context).textTheme.bodySmall,
            labelText: 'Número de Local',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Material(
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
              _validateLogin();
            },
            child: Text("Iniciar Sesión",
                style: Theme.of(context).textTheme.labelLarge),
          ),
        ),
      ],
    );
  }

  Future<void> _validateLogin() async {
    try {
      checkCredentials(
          _userController.text, _passController.text, _localController.text);
      await _apiClient.login(_userController.text, _passController.text,
          int.parse(_localController.text));
      _toEnterReceipt();
    } on InvalidInputException catch (e) {
      _showExceptionDialog(e.message);
    } on InvalidCredentialsException catch (e) {
      _showExceptionDialog(e.message);
    } on GeneralException catch (e) {
      _showExceptionDialog(e.message);
    }
  }

  Future<void> _toEnterReceipt() async {
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/enterReceipt');
  }

  Future<void> _showExceptionDialog(String content) async {
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
