import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fap_demo3/coin_data.dart';
import 'package:fap_demo3/constants.dart';
import 'dart:io' show Platform;

class ConversionPage extends StatefulWidget {
  @override
  _ConversionPage createState() => _ConversionPage();
}

class _ConversionPage extends State<ConversionPage> {
  //rgb(134, 225, 194)
  Color bgColor = const Color.fromRGBO(134, 225, 194, 0.75);
  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            //background image
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/conversionBg.png"),
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            //Color Overlay
            color: bgColor,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      'AXS, ETH & SLP CONVERSION',
                      style: kConversionTitle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 8,
                    thickness: 1.5,
                    indent: 10,
                    endIndent: 10,
                  ),
                  makeCards(),
                  Container(
                    height: 100.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.transparent,
                    child: androidDropdown(),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      String currency2 = currency;
      var newItem = DropdownMenuItem<String>(
        child: Text(currency2),
        value: currency2,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      //arrow_downward
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      value: selectedCurrency,
      items: dropdownItems,
      dropdownColor: bgColor,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'FredokaOne',
        fontSize: 18,
      ),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getData();
        });
      },
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto]!,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: kConversionPrice,
          ),
        ),
      ),
    );
  }
}
