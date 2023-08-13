import 'package:flutter/material.dart';
import 'package:saia_mobile_app/screens/enter_receipt_page.dart';
import 'package:saia_mobile_app/screens/finish_page.dart';
import 'package:saia_mobile_app/screens/preview_page.dart';
import 'package:saia_mobile_app/screens/scan_qr_page.dart';
import 'package:saia_mobile_app/screens/start_page.dart';

void main() {
  runApp(const MainApp());
}

const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color blueColor = Color(0xff4658A7);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: const Color(0xffF6AD3A),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontSize: 48.0,
                color: blackColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 5),
            titleLarge: TextStyle(
                fontSize: 30.0,
                color: blackColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 5),
            bodyMedium: TextStyle(
                fontSize: 20.0,
                color: blackColor,
                fontWeight: FontWeight.normal),
            bodySmall: TextStyle(
              fontSize: 15.0,
              color: blackColor,
              fontWeight: FontWeight.normal,
            ),
            labelLarge: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                color: blueColor,
                letterSpacing: 2),
            labelMedium: TextStyle(
              fontSize: 20.0,
              color: whiteColor,
              fontWeight: FontWeight.normal,
            ),
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/enterReceipt': (context) => const EnterReceiptPage(),
        '/scanQR': (context) => const ScanQrPage(),
        '/preview': (context) => const PreviewPage(),
        '/finish': (context) => const FinishPage(),
      },
    );
  }
}
