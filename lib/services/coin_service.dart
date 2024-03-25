import 'package:coin_ticker/models/rate_model.dart';
import 'package:coin_ticker/services/network_service.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';

abstract class ICoinService implements IService {
  Future<RateModel> getRate(String coinId, String currencyId);
}

class CoinService implements ICoinService {
  static const baselUrl = 'https://rest.coinapi.io/v1';
  static final CoinService _instance = CoinService._internal();

  final _apiKey = '109B2832-0F1B-4FC8-8289-687E951371F9';
  final INetworkService _networkService =
      ServiceDispatcher.instance.getService<INetworkService>();

  CoinService._internal();

  factory CoinService() => _instance;

  @override
  Future<RateModel> getRate(String coinId, String currencyId) async {
    var uri = _networkService
        .getUri('exchangerate/$coinId/$currencyId', {'apikey': _apiKey});
    var result = await _networkService.getData(uri);
    //TODO: how to make next logic generic? (C# styled)
    if (!result.succeed) {
      var errorMessage =
          result.response['error'] as String? ?? result.errorMessage;
      return RateModel(
        dateTime: DateTime.now(),
        errorMessage: errorMessage,
      );
    }

    var responseMap = result.response as Map<String, dynamic>;

    return RateModel.fromJson(responseMap);
  }
}
