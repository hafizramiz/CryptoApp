import 'package:flutter/material.dart';

const List<String> dropList = <String>['TRY', 'USD', 'EUR', 'GBP', "CAD"];
TextEditingController controller = TextEditingController();

class AlertCreateScreen extends StatefulWidget {
  const AlertCreateScreen({Key? key}) : super(key: key);

  @override
  State<AlertCreateScreen> createState() => _AlertCreateScreenState();
}

class _AlertCreateScreenState extends State<AlertCreateScreen> {
  String dropDownValue = dropList.first;

  @override
  Widget build(BuildContext context) {
    controller.text = "18,75";
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'ADD PRICE ALERT',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Get notified when a coin goes above or below a price target.",
            style: TextStyle(
                color: Colors.yellowAccent[700],
                fontSize: 15,
                fontWeight: FontWeight.bold,),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "USD",
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      " 18,57",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 120,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Alert me when...",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "1 USD",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "=",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                                controller: controller,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                dropdownColor: Colors.grey,
                                underline: Container(
                                  height: 3,
                                  color: Colors.white, //<-- SEE HERE
                                ),
                                value: dropDownValue,
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                                elevation: 16,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropDownValue = value!;
                                  });
                                },
                                items: dropList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "When the price will hits the target price, app will send notification alert",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.notification_add),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "ALERT ONCE",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.12,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(Icons.repeat),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "RECURRING",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                          child: SizedBox(
                        height: 150,
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.width * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40))),
                          child: Center(
                              child: Text(
                            "SAVE ALERT",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
