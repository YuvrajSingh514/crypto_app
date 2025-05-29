import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiNetwork {
  static Future<List<dynamic>> getMarket() async {
    Uri requestPath = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr',
    );
    var response = await http.get(requestPath);
    var decodedResponse = jsonDecode(response.body);

    List<dynamic> market = decodedResponse as List<dynamic>;
    return market;
  }
}
