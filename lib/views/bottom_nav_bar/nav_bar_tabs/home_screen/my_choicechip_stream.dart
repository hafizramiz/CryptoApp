import 'dart:async';
import 'dart:convert';
import 'package:cryptocurrency/models/market_cap_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../../view_models/helpers/fetch_data_helper.dart';


class MyChoiceChipStream extends StatefulWidget {
  const MyChoiceChipStream({Key? key}) : super(key: key);

  @override
  State<MyChoiceChipStream> createState() => _MyChoiceChipStreamState();
}

class _MyChoiceChipStreamState extends State<MyChoiceChipStream> {
  final List<String> labelList = [
    'market_cap_desc',
    'market_cap_change_24h_desc'
  ];
  int? _value = 0;

  final StreamController _streamController = StreamController();

  Future<void> fetchMarketCapData(String apiUrl) async {
    FetchDataHelper fetchDataHelper = FetchDataHelper();
    Response response = await fetchDataHelper.fetchData(apiUrl);
    String jsonString = response.body;
    List<dynamic> listData = jsonDecode(jsonString);

    List descendingList = listData.map((json) {
      MarketCapData marketCapData = MarketCapData.fromJson(json);
      return marketCapData;
    }).toList();

    if (!_streamController.isClosed) {
      _streamController.sink.add(descendingList);
    }
  }

  @override
  void initState() {
    fetchMarketCapData(
        "https://api.coingecko.com/api/v3/coins/categories?order=market_cap_desc");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _streamController.stream,
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text("Please Wait....");
              } else {
                List<MarketCapData> descendingList = snapshot.data!;
                return Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Wrap(
                          spacing: 12,
                          children: List.generate(
                            labelList.length,
                            (index) => ChoiceChip(
                              selectedColor: Colors.green,
                              label: Text("${labelList[index]}"),
                              selected: _value == index,
                              onSelected: (bool selected) {
                                setState(() {
                                  _value = selected ? index : null;
                                });

                                switch (_value) {
                                  case 0:
                                    fetchMarketCapData(
                                        "https://api.coingecko.com/api/v3/coins/categories?order=market_cap_desc");
                                    break;
                                  case 1:
                                    fetchMarketCapData(
                                        "https://api.coingecko.com/api/v3/coins/categories?order=market_cap_change_24h_desc");
                                    break;
                                }
                              },
                            ),
                          ).toList()),
                    ]),
                    SizedBox(
                      height: 350,
                      child: _value == 0
                          ? ListView.builder(
                          itemCount: descendingList.length,
                          itemBuilder: (context, int index) {
                            return Card(
                                child: ListTile(
                                  subtitle: Text("${descendingList[index].volume_24h}"),
                                  trailing: Text(
                                    "${descendingList[index].market_cap_change_24h}",
                                    style: TextStyle(
                                      color: descendingList[index].market_cap_change_24h>=0?Colors.green:Colors.red,
                                    ),
                                  ),
                                  title: Text("${descendingList[index].name}"),
                                ));
                          })
                          : ListView.builder(
                          itemCount: descendingList.length,
                          itemBuilder: (context, int index) {
                            return Card(
                                child: ListTile(
                                  trailing: Text(
                                    "${descendingList[index].market_cap_change_24h}",
                                    style: TextStyle(
                                      color: descendingList[index].market_cap_change_24h>=0?Colors.green:Colors.red,
                                    ),
                                  ),
                                  title: Text("${descendingList[index].name}"),
                                ));
                          })
                    ),
                  ],
                );
              }
          }
        });
  }
}


