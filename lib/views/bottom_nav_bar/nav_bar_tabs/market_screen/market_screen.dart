import 'dart:async';
import 'dart:convert';

import 'package:cryptocurrency/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../../view_models/helpers/fetch_data_helper.dart';
import 'my_listview_builder.dart';

class MarketScreen extends StatefulWidget {
  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final StreamController _streamController = StreamController();

  ///Creating My method
  Future<void> getAllCurrencyData() async {
    FetchDataHelper fetchDataHelper = FetchDataHelper();
    String _apiUrl =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=15";
    Response response = await fetchDataHelper.fetchData(_apiUrl);
    String jsonString = response.body;
    List<dynamic> listData = jsonDecode(jsonString);
    List<Currency> currencyList = listData.map((json) {
      Currency currency = Currency.fromJson(json);
      return currency;
    }).toList();

    if (!_streamController.isClosed) {
      _streamController.sink.add(currencyList);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCurrencyData();
    Timer.periodic(const Duration(seconds: 350), (timer) {
      getAllCurrencyData();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Review"),
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot snaphot) {
          switch (snaphot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snaphot.hasError) {
                return Text("Please Wait....");
              } else {
                List<Currency> currencyList = snaphot.data!;
                return MyListViewBuilder(
                  currencyList:  currencyList,
                );
              }
          }
        },
      ),
    );
  }
}
