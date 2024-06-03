import 'package:core/core.dart';

class HTTPServiceInjection{
  Future<void> initInjection() async {
    instance.registerSingleton<HttpService>(HttpServiceImpl());
  }
}