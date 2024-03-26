import 'package:coin_ticker/services/coin_service.dart';
import 'package:coin_ticker/services/network_service.dart';

abstract class IService {}

class ServiceDispatcher {
  static final List<IService> _services = [];
  static final ServiceDispatcher instance = ServiceDispatcher._internal();

  // TODO: add lazy loading
  ServiceDispatcher._internal();

  void init() {
    _services.add(ApiService(baseUrl: CoinService.baselUrl));
    _services.add(CoinService());
  }

  // TODO: think out how to specify parameter for the same interface (mb inner generic?)
  TService getService<TService extends IService>() =>
      _services.whereType<TService>().first;
}
