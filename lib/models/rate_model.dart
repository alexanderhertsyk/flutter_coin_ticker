import 'base_model.dart';

const kTime = 'time';
const kFrom = 'asset_id_base';
const kTo = 'asset_id_quote';
const kRate = 'rate';

final class RateModel extends BaseModel {
  final DateTime dateTime;
  final String? from;
  final String? to;
  final double rate;

  RateModel({
    DateTime? dateTime,
    this.from,
    this.to,
    this.rate = 0.0,
    super.error,
  }) : dateTime = dateTime ?? DateTime.now();

  RateModel.fromJson(Map<String, dynamic> json)
      : dateTime = DateTime.parse(json[kTime]),
        from = json[kFrom] as String?,
        to = json[kTo] as String?,
        rate = json[kRate] as double;

  Map<String, dynamic> toJson() {
    var rateJson = <String, dynamic>{
      kTime: dateTime.toIso8601String(),
      kRate: rate,
    };
    // TODO: check how encode serializes nullable items
    if (from != null) rateJson[kFrom] = from;
    if (to != null) rateJson[kTo] = to;

    return rateJson;
  }
}
