import 'package:flutter/material.dart';
import 'package:saia_mobile_app/widgets/credentials_field.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/icons/logo.jpg'),
                fit: BoxFit.cover,
              ),
              Text("REGISTRO DE INVENTARIO",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
              const UserCredentialsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
