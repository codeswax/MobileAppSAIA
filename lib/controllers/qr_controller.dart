class QRScannerController {
  String _bottomText = "";

  String get bottomText => _bottomText;

  void updateText(String text) {
    _bottomText = text;
  }
}
