class Trending {
  String id;
  int coin_id;
  String name;
  String symbol;
  String small;
  var price_btc;
  int score;

  Trending(
      {required this.id,
      required this.coin_id,
      required this.name,
      required this.symbol,
      required this.small,
      required this.price_btc,
      required this.score});

  Trending.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.coin_id = json["coin_id"],
        this.name = json["name"],
        this.symbol = json["symbol"],
        this.small = json["small"],
        this.price_btc = json["price_btc"],
        this.score = json["score"];
}
