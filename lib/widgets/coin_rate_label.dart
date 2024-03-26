import 'package:flutter/material.dart';

class CoinRateLabel extends StatelessWidget {
  const CoinRateLabel({
    super.key,
    required this.coin,
    required this.currency,
    required this.rate,
  });

  final String? coin;
  final double rate;
  final String? currency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 28.0,
          ),
          child: Text(
            '1 ${defaultIfNull(coin)} = ${rate.round()} ${defaultIfNull(currency)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String defaultIfNull(String? s, {String defaultString = '?'}) =>
      s ?? defaultString;
}
