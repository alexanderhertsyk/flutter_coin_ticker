import 'package:coin_ticker/coin_data.dart';
import 'package:coin_ticker/services/coin_service.dart';
import 'package:coin_ticker/services/network_service.dart';
import 'package:coin_ticker/utils/service_dispatcher.dart';
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
  double _rate = 0.0;
  String? _currency = currenciesList.first;

  void onCurrencyChanged(String currency) {
    setCurrency(currency);
    setRate(currency);
  }

  void setCurrency(String currency) => setState(() => _currency = currency);

  void setRate(String currency) async {
    // TODO: add loading indicator
    var rateModel = await _coinService.getRate('BTC', currency);
    setState(() {
      if (rateModel.hasError) {
        //TODO: show error
        _rate = -1;
      } else {
        _rate = rateModel.rate;
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = ${_rate.round()} $_currency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
