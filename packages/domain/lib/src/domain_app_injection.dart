import 'package:core/core.dart';
import 'package:domain/domain.dart';

class DomainAppInjection{
  Future<void> initInjection() async {
    instance.registerSingleton<LoginWithEmailPasswordUseCase>(LoginWithEmailPasswordUseCase(authenticationRepository: instance()));
  }
}