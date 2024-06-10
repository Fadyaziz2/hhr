import 'package:core/core.dart';

import 'domain.dart';

class UseCaseInjection{
  Future<void> initInjection() async {
    instance.registerSingleton<HomeDatLoadUseCase>(HomeDatLoadUseCase(hrmCoreBaseService: instance()));
    instance.registerSingleton<SettingsDataLoadUseCase>(SettingsDataLoadUseCase(hrmCoreBaseService: instance()));
  }
}