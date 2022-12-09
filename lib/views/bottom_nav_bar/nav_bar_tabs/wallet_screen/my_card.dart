import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  String title;
  String price;
  String picture;

  MyCard({
    Key? key,
    required this.title,
    required this.picture,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      height: MediaQuery.of(context).size.width * 0.46,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("${picture}"),
            backgroundColor: Colors.transparent,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          Expanded(
              child: Text(price,
                  style: TextStyle(color: Colors.grey[300], fontSize: 20),
                  maxLines: 1))
        ],
      ),
    );
  }
}
