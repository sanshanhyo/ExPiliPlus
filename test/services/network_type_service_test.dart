import 'package:ex_piliplus/services/network_type_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkTypeService', () {
    test('maps only supported cellular labels', () {
      expect(NetworkTypeService.fromCellularName('4G'), NetworkType.fourG);
      expect(NetworkTypeService.fromCellularName('5G'), NetworkType.fiveG);
      expect(NetworkTypeService.fromCellularName('LTE'), NetworkType.unknown);
      expect(NetworkTypeService.fromCellularName(null), NetworkType.unknown);
    });

    test('uses stable user-facing labels', () {
      expect(NetworkTypeService.label(NetworkType.wifi), 'Wi‑Fi');
      expect(NetworkTypeService.label(NetworkType.fourG), '4G');
      expect(NetworkTypeService.label(NetworkType.fiveG), '5G');
      expect(NetworkTypeService.label(NetworkType.unknown), '未知');
    });
  });
}
