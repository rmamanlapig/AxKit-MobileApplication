//dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = ['USD', 'PHP'];
const List<String> cryptoList = ['AXS', 'ETH', 'SLP'];

const defaultURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '8B10B342-CD49-491B-81ED-52166794B120';

class CoinData {
  Future getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL = '$defaultURL/$crypto/$currency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double price = decodedData['rate'];
        cryptoPrices[crypto] = price.toStringAsFixed(5);
      } else {
        print(response.statusCode);
        throw 'Error within the system';
      }
    }
    return cryptoPrices;
  }
}
