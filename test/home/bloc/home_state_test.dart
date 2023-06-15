import 'package:flutter_test/flutter_test.dart';
import 'package:onesthrm/res/enum.dart';

main(){
  group('Home State Status', () {
    test('Return NetworkStatus.initial home state', () {
      const status = NetworkStatus.initial;
      expect(true, NetworkStatus.initial == status);
      expect(false, NetworkStatus.loading == status);
      expect(false, NetworkStatus.success == status);
    });
    test('Return NetworkStatus.loading home state',(){
      const status = NetworkStatus.loading;
      expect(false, NetworkStatus.initial == status);
      expect(true, NetworkStatus.loading == status);
      expect(false, NetworkStatus.success == status);
    });
    test('Return NetworkStatus.success home state',(){
      const status = NetworkStatus.success;
      expect(false, NetworkStatus.initial == status);
      expect(false, NetworkStatus.loading == status);
      expect(true, NetworkStatus.success == status);
    });
  });
}