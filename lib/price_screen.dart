import 'dart:convert';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'reusableCard.dart';

class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  CoinData coinData = CoinData();
  void initState() {
    super.initState();
    getinitialData();
  }

 void getinitialData()async{
   priceBTC = await coinData.getData(selectedCurrency, 'BTC');
 }
  String priceBTC;
  String priceETH;
  String priceXRP;
  String selectedCurrency = 'USD';
  int index = 0;
  DropdownButton<String> androidPicker() {
    String myCurrency;
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
     myCurrency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(myCurrency),
        value: myCurrency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value)async{
          String n = await coinData.getData(myCurrency, 'BTC');
          String e = await coinData.getData(myCurrency, 'ETH');
          String x= await coinData.getData(myCurrency, 'XRP');
          setState(() {
            selectedCurrency = value;
            priceBTC = n;
            priceETH = e;
            priceXRP = x;
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> myText = [];
    String myCurrency;
    for (int i = 0; i < currenciesList.length; i++) {
      myCurrency = currenciesList[i];
      var newItem = Text(
        myCurrency,
        style: TextStyle(color: Colors.white),
      );
      myText.add(newItem);
    }
    return CupertinoPicker(
      itemExtent: 30.0,
      onSelectedItemChanged: (selectedIndex) async{
        String n = await coinData.getData(currenciesList[selectedIndex], 'BTC');
        String e = await coinData.getData(currenciesList[selectedIndex], 'ETH');
        String x= await coinData.getData(currenciesList[selectedIndex], 'XRP');
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          priceBTC = n;
          priceETH = e;
          priceXRP = x;
        });
      },
      children: myText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: <Widget>[
                ReusableCard(price: priceBTC, selectedCurrency: selectedCurrency,crypto: 'BTC',),
                ReusableCard(price: priceETH, selectedCurrency: selectedCurrency,crypto: 'ETH',),
                ReusableCard(price: priceXRP, selectedCurrency: selectedCurrency,crypto: 'XRP',),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
//              if you wanna use platform specific style dropdown
//            Platform.isIOS ? iosPicker() : androidPicker(),
//          but i choose ios style picker
              iosPicker()
          ),
        ],
      ),
    );
  }
}
