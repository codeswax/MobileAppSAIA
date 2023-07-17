import 'package:flutter/material.dart';
import 'package:saia_mobile_app/screens/enter_receipt_page.dart';
import 'package:saia_mobile_app/screens/finish_page.dart';
import 'package:saia_mobile_app/screens/preview_page.dart';
import 'package:saia_mobile_app/screens/scan_qr_page.dart';
import 'package:saia_mobile_app/screens/start_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Lato'),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/enterReceipt': (context) => const EnterReceiptPage(),
        '/scanQR': (context) => ScanQrPage(),
        '/preview': (context) => const PreviewPage(),
        '/finish': (context) => const FinishPage(),
      },
    );
  }
}
