const kTime = 'time';
const kCoin = 'asset_id_base';
const kCurrency = 'asset_id_quote';
const kRate = 'rate';

class BaseModel {
  final String? errorMessage;
  get hasError => errorMessage != null;

  BaseModel({this.errorMessage});
}

class RateModel extends BaseModel {
  final DateTime dateTime;
  final String? coinId;
  final String? currencyId;
  final double rate;

  RateModel({
    required this.dateTime,
    this.coinId,
    this.currencyId,
    this.rate = 0.0,
    super.errorMessage,
  });

  RateModel.fromJson(Map<String, dynamic> json)
      : dateTime = DateTime.parse(json[kTime]),
        coinId = json[kCoin] as String?,
        currencyId = json[kCurrency] as String?,
        rate = json[kRate] as double;

  Map<String, dynamic> toJson() {
    var rateJson = <String, dynamic>{
      kTime: dateTime.toIso8601String(),
      kRate: rate,
    };
    // TODO: check how encode serializes nullable items
    if (coinId != null) rateJson[kCoin] = coinId;
    if (currencyId != null) rateJson[kCurrency] = currencyId;

    return rateJson;
  }
}
