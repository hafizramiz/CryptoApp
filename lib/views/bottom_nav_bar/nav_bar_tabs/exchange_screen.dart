import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../view_models/helpers/fetch_data_helper.dart';

const List<String> dropList1 = <String>['USD', 'TRY', 'EUR', 'GBP', "CAD"];
const List<String> dropList2 = <String>['TRY','USD', 'EUR', 'GBP', "CAD"];

class ExchangeScreen extends StatefulWidget {
  ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  Future<void> getData() async {
    FetchDataHelper fetchDataHelper = FetchDataHelper();

    String _apiUrl =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=15";
    Response response = await fetchDataHelper.fetchData(_apiUrl);
    String jsonString = response.body;
  }

  String dropdownValue1 = dropList1.first;
  String dropdownValue2 = dropList2.first;
TextEditingController _controller1= TextEditingController();
TextEditingController _controller2= TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller1.text="1";
    _controller2.text="1";
    return Scaffold(
      appBar: AppBar(
        title: Text("Exchange "),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 200, child: TextField(
                  controller: _controller1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),),
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton(
                    value: dropdownValue1,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue1 = value!;
                      });
                      print(value);
                    },
                    items: dropList1.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 200, child: TextField(
                controller: _controller2,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),),
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  value: dropdownValue2,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue2 = value!;
                    });
                    print(value);
                  },
                  items: dropList1.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),

          Align(alignment: Alignment.topRight,
            child: ElevatedButton(
                onPressed: (){
            }, child: SizedBox(width: 130,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.swap_vert),
                  Text("Swap Currencies"),
                ],
              ),
            )),
          )
        ],
      )),
    );
  }
}
