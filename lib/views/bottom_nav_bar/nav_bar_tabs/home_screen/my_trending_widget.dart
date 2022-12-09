import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../models/trending.dart';

class MyTrendingWidget extends StatefulWidget {
  List<Trending> trendingList;

  MyTrendingWidget({required this.trendingList});

  @override
  State<MyTrendingWidget> createState() => _MyTrendingWidgetState();
}

class _MyTrendingWidgetState extends State<MyTrendingWidget> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Top-7 trending coins searched by users in the last 24 hours",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: controller,
                itemCount: widget.trendingList.length,
                itemBuilder: (_, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.purpleAccent,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          "${widget.trendingList[index].name}",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        CircleAvatar(
                          child: Image.network(
                              "${widget.trendingList[index].small}"),
                        ),
                        Text(
                          "Price BTC: ${widget.trendingList[index].price_btc}",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: widget.trendingList.length,
              effect: ScrollingDotsEffect(
                activeDotColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
