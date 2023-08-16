import 'package:flutter/material.dart';
import 'package:saia_mobile_app/models/report_data.dart';
import 'package:saia_mobile_app/screens/enter_receipt_page.dart';
import 'package:saia_mobile_app/screens/finish_page.dart';
import 'package:saia_mobile_app/screens/preview_page.dart';
import 'package:saia_mobile_app/screens/scan_qr_page.dart';
import 'package:saia_mobile_app/screens/start_page.dart';
import 'package:saia_mobile_app/utils/colors_constants.dart';
import 'package:saia_mobile_app/widgets/available_receipts_container.dart';

void main() {
  runApp(const MainApp());
}

DataStorage dataStorage = DataStorage();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManagement.getTheme(),
      initialRoute: '/',
      routes: RouteManagement.getRoutes(),
    );
  }
}

class RouteManagement {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/': (context) => const StartPage(),
      '/enterReceipt': (context) => const EnterReceiptPage(),
      '/scanQR': (context) => const ScanQrPage(),
      '/preview': (context) => PreviewPage(dataStorage: dataStorage),
      '/receipts': ((context) => AvailableReceiptsContainer(
            receipts: const [],
            dataStorage: dataStorage,
          )),
      '/finish': (context) => const FinishPage(),
    };
  }
}

class ThemeManagement {
  static ThemeData getTheme() {
    return ThemeData(
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
            titleSmall: TextStyle(
                fontSize: 20.0, color: whiteColor, fontWeight: FontWeight.w100),
            bodyMedium: TextStyle(
                fontSize: 20.0,
                color: blackColor,
                fontWeight: FontWeight.normal),
            bodySmall: TextStyle(
              fontSize: 18.0,
              color: blackColor,
              fontWeight: FontWeight.normal,
            ),
            labelLarge: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
                color: blueColor,
                letterSpacing: 1),
            labelMedium: TextStyle(
              fontSize: 18.0,
              color: whiteColor,
              fontWeight: FontWeight.normal,
            ),
            labelSmall: TextStyle(
              fontSize: 15.0,
              color: whiteColor,
              fontWeight: FontWeight.normal,
            )));
  }
}
