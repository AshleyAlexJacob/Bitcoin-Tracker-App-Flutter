import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

class CoinData {
  static final apiKey = '5bc569c10dd361f79bc471bdf0821e73';
  static String currency;
  static String coinType;
  static final url = 'https://api.nomics.com/v1/currencies/ticker?key=';
  String requestURL ;
  String price;
  Future<String> getData(curr,coin)async{
    requestURL='$url$apiKey&ids=$coin&interval=1d&quote-currency=$curr';
    Response response = await get(requestURL);
    if (response.statusCode==200){
      var data = response.body;
//      0.price
      var decodedData = jsonDecode(data)[0]['price'];
     price = decodedData;
     double myPrice=double.parse(price);
     String finalRes = myPrice.toStringAsFixed(0);
      print(finalRes);
      return finalRes;
    }
    else
      print(response.statusCode);
  }

}
