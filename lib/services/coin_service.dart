import 'package:coin_ticker/models/rate_model.dart';
import 'package:coin_ticker/services/network_service.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';

abstract interface class ICoinService implements IService {
  Future<RateModel> getRate(String coinId, String currencyId);
}

class CoinService implements ICoinService {
  static const baselUrl = 'https://rest.coinapi.io/v1';
  static final CoinService _instance = CoinService._internal();

  final _apiKey = '109B2832-0F1B-4FC8-8289-687E951371F9';
  final IApiService _networkService =
      ServiceDispatcher.instance.getService<IApiService>();

  CoinService._internal();

  factory CoinService() => _instance;

  @override
  Future<RateModel> getRate(String coinId, String currencyId) async {
    var uri = _networkService
        .getUri('exchangerate/$coinId/$currencyId', {'apikey': _apiKey});
    var result = await _networkService.getParsedData<RateModel>(
        uri, (json) => RateModel.fromJson(json));

    if (!result.succeed) {
      return RateModel(
        dateTime: DateTime.now(),
        error: result.response?.error ?? result.error,
      );
    }

    return result.response!;
  }
}
