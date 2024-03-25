import 'package:coin_ticker/utils/service_dispatcher.dart';
import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() {
  ServiceDispatcher.instance.init();
  runApp(const CoinTickerApp());
}

class CoinTickerApp extends StatelessWidget {
  const CoinTickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
}
