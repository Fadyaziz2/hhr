import 'package:get_it/get_it.dart';
import 'package:hrm_framework/hrm_framework.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerFactory<DeviceInfoService>(() => DeviceInfoServiceImpl());
  instance.registerFactory<GetDeviceIdUseCase>(() => GetDeviceIdUseCase(deviceInfoService: instance()));
}