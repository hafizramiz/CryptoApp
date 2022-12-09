class Currency {
  String id;
  String symbol;
  String name;
  String image;
  var current_price;
  var high_24h;
  var low_24h;
  var price_change_24h;

  Currency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.current_price,
    required this.high_24h,
    required this.low_24h,
    required this.price_change_24h,
  });

  Currency.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.symbol = json["symbol"],
        this.name = json["name"],
        this.image = json["image"],
        this.current_price = json["current_price"],
        this.high_24h = json["high_24h"],
        this.low_24h = json["low_24h"],
        this.price_change_24h = json["price_change_24h"];
}
