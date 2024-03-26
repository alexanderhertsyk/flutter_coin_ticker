import 'package:coin_ticker/coin_data.dart';
import 'package:coin_ticker/models/rates_model.dart';
import 'package:coin_ticker/services/coin_service.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';
import 'package:coin_ticker/widgets/coin_rate_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  final ICoinService _coinService =
      ServiceDispatcher.instance.getService<ICoinService>();
  RatesModel _rateModel = RatesModel.fake();
  String? _currency = currenciesList.first;

  void onCurrencyChanged(String currency) {
    setCurrency(currency);
    setRate(currency);
  }

  void setCurrency(String currency) => setState(() => _currency = currency);

  void setRate(String currency) async {
    // TODO: add loading indicator
    var rateModel = await _coinService.getRates(from: currency, to: cryptoList);
    setState(() {
      if (rateModel.hasError) {
        _rateModel = RatesModel.fake();
      } else {
        _rateModel = rateModel;
      }
    });
  }

  DropdownButton<String> _getAndroidPicker() => DropdownButton<String>(
        value: _currency,
        onChanged: (currency) => onCurrencyChanged(currency!),
        items: currenciesList
            .map<DropdownMenuItem<String>>((currency) =>
                DropdownMenuItem(value: currency, child: Text(currency)))
            .toList(),
      );

  CupertinoPicker _getIOSPicker() => CupertinoPicker(
        backgroundColor: Colors.lightBlueAccent,
        itemExtent: 32,
        onSelectedItemChanged: (i) => onCurrencyChanged(currenciesList[i]),
        children:
            currenciesList.map<Text>((currency) => Text(currency)).toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CoinRateLabel(
                  coin: _rateModel.rates[0].to,
                  currency: _rateModel.from,
                  rate: _rateModel.rates[0].rate),
              CoinRateLabel(
                  coin: _rateModel.rates[1].to,
                  currency: _rateModel.from,
                  rate: _rateModel.rates[1].rate),
              CoinRateLabel(
                  coin: _rateModel.rates[2].to,
                  currency: _rateModel.from,
                  rate: _rateModel.rates[2].rate),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? _getIOSPicker() : _getAndroidPicker(),
          ),
        ],
      ),
    );
  }
}
