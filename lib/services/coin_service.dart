import 'package:coin_ticker/models/rate_model.dart';
import 'package:coin_ticker/models/rates_model.dart';
import 'package:coin_ticker/services/network_service.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';

abstract interface class ICoinService implements IService {
  Future<RateModel> getRate(String from, String to);
  Future<RatesModel> getRates(
      {required String from, required Iterable<String> to});
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
  Future<RateModel> getRate(String from, String to) async {
    var uri =
        _networkService.getUri('exchangerate/$from/$to', {'apikey': _apiKey});
    var result = await _networkService.getParsedData<RateModel>(
        uri, (json) => RateModel.fromJson(json));

    if (!result.succeed) return RateModel(error: result.error);

    return result.response!;
  }

  @override
  Future<RatesModel> getRates(
      {required String from, required Iterable<String> to}) async {
    var uri = _networkService.getUri('exchangerate/$from', {
      'filter_asset_id': to.join(','),
      'invert': true,
      'apikey': _apiKey,
    });
    var result = await _networkService.getParsedData<RatesModel>(
        uri, (json) => RatesModel.fromJson(json));

    if (!result.succeed) return RatesModel(error: result.error);

    return result.response!;
  }
}
