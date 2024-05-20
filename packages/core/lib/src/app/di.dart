import 'package:get_it/get_it.dart';
import 'package:hrm_framework/hrm_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPref = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPref);
  instance.registerLazySingleton<StorageHelper>(
      () => StorageHelperImpl(pref: instance()));
  instance.registerFactory<DeviceInfoService>(() => DeviceInfoServiceImpl());
  instance.registerFactory<AppVersionService>(() => AppVersionServiceImpl());
  instance.registerFactory<GetAppNameUseCase>(
      () => GetAppNameUseCase(appVersionService: instance()));
  instance.registerFactory<GetAppVersionUseCase>(
      () => GetAppVersionUseCase(appVersionService: instance()));
  instance.registerFactory<GetDeviceIdUseCase>(
      () => GetDeviceIdUseCase(deviceInfoService: instance()));
  instance.registerFactory<GetDeviceNameUseCase>(
      () => GetDeviceNameUseCase(deviceInfoService: instance()));
}
