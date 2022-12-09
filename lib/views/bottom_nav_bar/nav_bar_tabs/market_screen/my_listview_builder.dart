import 'package:flutter/material.dart';
import '../../../../models/currency.dart';
import 'market_details_screen.dart';

enum SetterState { successed, notSuccessed }
SetterState setterState = SetterState.notSuccessed;

List<dynamic> diffirentList = [];
List<dynamic> beforeList = [];
List<dynamic> refreshList = [];
List<Currency> filteredList = [];
List<Currency> myList=[];

class MyListViewBuilder extends StatefulWidget {
  final List<Currency> currencyList;

  MyListViewBuilder({required this.currencyList});

  @override
  State<MyListViewBuilder> createState() => _MyListViewBuilderState();
}

class _MyListViewBuilderState extends State<MyListViewBuilder> {
  TextEditingController _searchController = TextEditingController();
  bool isFiltering = false;

  @override
  Widget build(BuildContext context) {
    isFiltering==false?
    myList=widget.currencyList:
        myList=filteredList;
    refreshList = [];
    for (int i = 0; i < myList.length; i++) {
      refreshList.add(myList[i].current_price);
    }

    if (setterState == SetterState.notSuccessed) {
      beforeList = refreshList;
      setterState = SetterState.successed;
    }

    if (beforeList != refreshList) {
      diffirentList = [];
      for (int i = 0; i < myList.length; i++) {
        var itemPrice = beforeList[i] - refreshList[i];
        diffirentList.add(itemPrice);
      }
      beforeList = refreshList;
    }
    print(diffirentList);
    print(myList[2].image);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            onChanged: (_) {
              if (_searchController.text != null ||
                  _searchController.text.isNotEmpty) {
                isFiltering = true;
                filteredList = myList
                    .where((currency) => currency.name
                    .contains(_searchController.text))
                    .toList();
              }
              setState(() {});
            },
            controller: _searchController,
            decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: "Search"),
          ),
        ),


        Flexible(
          child: ListView.builder(
              itemCount: myList.length,
              itemBuilder: (context, int index) {
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarketDetailScreen(currency: myList[index],)));
                    },
                    child: ListTile(
                      leading: Image.network("${myList[index].image}"),
                      title: Text("${myList[index].name}"),
                      subtitle: Text("${myList[index].symbol}"),
                      trailing: Column(
                        children: [
                          Text(
                            "${myList[index].current_price} USD",
                            overflow: TextOverflow.ellipsis,
                          ),
                          diffirentList.isNotEmpty
                              ? double.parse(
                              ((diffirentList[index] * 100) /
                                  beforeList[index])
                                  .toStringAsFixed(2)) >= 0 ?

                          Text(
                                  "up: ${double.parse(((diffirentList[index] * 100) / beforeList[index]).toStringAsFixed(2))} %",
                                  style: TextStyle(
                                      color:   Colors.green),
                                ):Text(
                            "down: ${double.parse(((diffirentList[index] * 100) / beforeList[index]).toStringAsFixed(2))} %",
                            style: TextStyle(
                                color:   Colors.red),
                          )
                              : Text("${0}"),
                        ],
                      ),
                    ),
                  ),
                );
                ;
              }),
        ),
      ],
    );
  }
}
