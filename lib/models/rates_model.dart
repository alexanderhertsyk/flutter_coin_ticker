import 'package:coin_ticker/models/rate_model.dart';
import 'dart:convert';
import 'base_model.dart';

const kRates = 'rates';

final class RatesModel extends BaseModel {
  final String from;
  final List<RateModel> rates;

  RatesModel({
    this.from = '',
    List<RateModel>? rates,
    super.error,
  }) : rates = rates ?? [];

  static RatesModel fake() =>
      RatesModel(rates: [RateModel(), RateModel(), RateModel()]);

  RatesModel.fromJson(Map<String, dynamic> json)
      : from = json[kFrom] as String,
        rates = _parseRates(json[kRates] as List);

  static List<RateModel> _parseRates(List? rateListJson) {
    List<RateModel> rates = rateListJson != null
        ? rateListJson.map((rateJson) => RateModel.fromJson(rateJson)).toList()
        : List.empty();

    return rates;
  }

  Map<String, dynamic> toJson() {
    var ratesJson = <String, dynamic>{
      kTo: from,
      // TODO: Not implemented
      kRates: jsonEncode(rates),
    };

    return ratesJson;
  }
}
