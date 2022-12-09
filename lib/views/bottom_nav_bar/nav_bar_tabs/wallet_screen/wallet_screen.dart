import 'package:cryptocurrency/views/bottom_nav_bar/nav_bar_tabs/wallet_screen/my_card.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  String picture0="https://assets.coingecko.com/coins/images/325/large/tether.png?1667873465";
  String picture1="https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 80, right: 10, left: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Center(
                child: Text(
              'Current Wallet Ballance',
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                '\$4,849.56',
                style: TextStyle(
                    color: Colors.yellowAccent[700],
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontFamily: ''),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.width * 0.17,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text(
                    "Buy",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.width * 0.17,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Center(
                      child: Text(
                    "Sell",
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "FAVORITES CURRENCIES",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'See all',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
                SizedBox(height: 170,
                  child: PageView.builder(
                    itemCount: 4,
                    controller: controller,
                    itemBuilder: (context,int index){
                      return SizedBox(
                        height: MediaQuery.of(context).size.width * 0.50,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            height: 150,
                            child: MyCard(title: "Bitcoin", price: "19727 USD",picture: picture1,),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "RECOMMEND TO BUY",
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'See all',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(height: 200,
                  child: PageView.builder(
                    itemCount: 4,
                    controller: controller,
                    itemBuilder: (context,int index){
                      return SizedBox(
                        height: MediaQuery.of(context).size.width * 0.50,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            height: 220,
                            child: MyCard(title: "Tether", price: "1.001 USD",picture: picture0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ]),
        ),
      ),
    );
  }
}
