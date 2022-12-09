import 'dart:async';
import 'dart:convert';
import 'package:cryptocurrency/models/trending.dart';
import 'package:cryptocurrency/view_models/helpers/fetch_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'my_trending_widget.dart';

class MyTrendingStream extends StatefulWidget {
  @override
  State<MyTrendingStream> createState() => _MyTrendingStreamState();
}

class _MyTrendingStreamState extends State<MyTrendingStream> {
  StreamController _streamController = StreamController();

  Future<void> fetchTrending() async {
    String _apiUrl = "https://api.coingecko.com/api/v3/search/trending";
    FetchDataHelper fetchDataHelper = FetchDataHelper();
    Response response = await fetchDataHelper.fetchData(_apiUrl);
    String jsonString = response.body;
    Map<String, dynamic> mapData = jsonDecode(jsonString);
    List<dynamic> coinsList = mapData["coins"];

    List<Trending> trendindList = coinsList.map((json) {
      Trending trending = Trending.fromJson(json["item"]);
      return trending;
    }).toList();
    if (!_streamController.isClosed) {
      _streamController.sink.add(trendindList);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     fetchTrending();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
            stream: _streamController.stream,
            builder: (context, AsyncSnapshot snaphot) {
              switch (snaphot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snaphot.hasError) {
                    return Text("Please Wait....");
                  } else {
                    List<Trending> trendingList = snaphot.data!;
                    return MyTrendingWidget(trendingList: trendingList);
                  }
              }
            },
          );
  }
}




