import 'package:flutter/material.dart';
class ReusableCard extends StatelessWidget {
  const ReusableCard({
    Key key,
    @required this.price,
    @required this.selectedCurrency,
    @required this.crypto,
  }) : super(key: key);

  final String price;
  final String selectedCurrency;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text( price!=null?
        '1 $crypto = $price $selectedCurrency':'1 $crypto = Fetching Data Select Currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

