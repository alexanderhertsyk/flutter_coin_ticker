import 'package:coin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? _currency = currenciesList.first;

  DropdownButton<String> _getAndroidPicker() => DropdownButton<String>(
        value: _currency,
        onChanged: (selectedCurrency) =>
            setState(() => _currency = selectedCurrency),
        items: currenciesList
            .map<DropdownMenuItem<String>>((currency) =>
                DropdownMenuItem(value: currency, child: Text(currency)))
            .toList(),
      );

  CupertinoPicker _getIOSPicker() => CupertinoPicker(
        backgroundColor: Colors.lightBlueAccent,
        itemExtent: 32,
        onSelectedItemChanged: (i) =>
            setState(() => _currency = currenciesList[i]),
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
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
