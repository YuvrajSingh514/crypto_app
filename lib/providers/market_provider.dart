

import 'package:crypto_app/models/crypto_data.dart';
import 'package:crypto_app/network/api_network.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoData> marketList = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> markets = await ApiNetwork.getMarket();

    List<CryptoData> temp = [];
    for (var market in markets) {
      CryptoData newCrypto = CryptoData.fromJson(market);
      temp.add(newCrypto);
    }
    marketList = temp;
    isLoading = false;
    notifyListeners();

    
  }

  CryptoData fetchCryptoById(String id) {
    CryptoData cryptoId =
      marketList.where((element) => element.id == id).toList()[0];
    return cryptoId;
  }
}
