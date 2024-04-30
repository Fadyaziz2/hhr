import 'package:get_it/get_it.dart';
import 'package:hrm_framework/hrm_framework.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerFactory<DeviceInfoService>(() => DeviceInfoServiceImpl());
  instance.registerFactory<AppVersionService>(() => AppVersionServiceImpl());
  instance.registerFactory<GetAppNameUseCase>(() => GetAppNameUseCase(appVersionService: instance()));
  instance.registerFactory<GetAppVersionUseCase>(() => GetAppVersionUseCase(appVersionService: instance()));
  instance.registerFactory<GetDeviceIdUseCase>(() => GetDeviceIdUseCase(deviceInfoService: instance()));
}
