import 'package:test/test.dart';
import 'package:saia_mobile_app/exceptions/custom_exceptions.dart';

  final ValidationService validationService = ValidationService();

void main() {
  test('Validating the qr code', () {
    expect( validationService.checkQRTest(
      "NO0340770312961606MY2022112800004D1350202305280618112179980"),
      
      "El código es válido.");
  });
}
