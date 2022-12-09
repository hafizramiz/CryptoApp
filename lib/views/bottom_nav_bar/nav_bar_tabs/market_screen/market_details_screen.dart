import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../models/chart_data.dart';
import '../../../../models/currency.dart';
import '../../../../view_models/helpers/fetch_data_helper.dart';

class MarketDetailScreen extends StatefulWidget {
  Currency currency;

  MarketDetailScreen({required this.currency});

  @override
  _MarketDetailScreenState createState() => _MarketDetailScreenState();
}

class _MarketDetailScreenState extends State<MarketDetailScreen> {
  late CrosshairBehavior _crosshairBehavior;
  List<ChartData> chartDataList = [];

  Future<Response> fetchChartData() async {
    FetchDataHelper fetchDataHelper = FetchDataHelper();
    String _apriUrl =
        "https://api.coingecko.com/api/v3/coins/${widget.currency
        .id}/market_chart?vs_currency=usd&days=1";
    Response response = await fetchDataHelper.fetchData(_apriUrl);
    return response;
  }

  Future<void> setChartDataList() async {
    Response response = await fetchChartData();
    String jsonString = response.body;
    Map mapData = jsonDecode(jsonString);
    List listData = mapData["prices"];

    for (int i = 0; i < listData.length; i++) {
      ///Burada daha sonra round islemi yapcam
      num yy = listData[i][1];
      double y = yy.roundToDouble();
      ChartData chartData = ChartData(x: i, y: listData[i][1]);
      chartDataList.add(chartData);
    }
  }

  @override
  void initState() {
    setChartDataList();
    _crosshairBehavior = CrosshairBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${widget.currency.name}"),),
        body: FutureBuilder(
          future: fetchChartData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MyChartWidget(chartDataList: chartDataList,
                crosshairBehavior: _crosshairBehavior,
                currency: widget.currency,);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

class MyChartWidget extends StatelessWidget {
  final List<ChartData> chartDataList;
  final CrosshairBehavior crosshairBehavior;
  final Currency currency;

  MyChartWidget({required this.chartDataList,
    required this.crosshairBehavior,
    required this.currency});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 500,
            child: SfCartesianChart(
              crosshairBehavior: crosshairBehavior,
              series: <LineSeries<ChartData, num>>[
                LineSeries<ChartData, num>(
                    animationDuration: 2500,
                    dataSource: chartDataList,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    enableTooltip: true,
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside))
              ],
            ),
          ),
           ListTile(title: Text("Current Price: ${currency.current_price}",style: TextStyle(fontSize: 20))),
           ListTile(title: Text("Price Change in 24 hours: ${currency.price_change_24h}",style: TextStyle(fontSize: 20))),
           ListTile(title: Text("Low Price in 24 hours: ${currency.low_24h}",style: TextStyle(fontSize: 20))),
           ListTile(title: Text("High Price in 24 hours: ${currency.high_24h}",style: TextStyle(fontSize: 20))),
        ], 
      ),
    );
  }
}
