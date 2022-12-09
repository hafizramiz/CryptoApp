class MarketCapData {
  String id;
  String name;
  num market_cap;
  num market_cap_change_24h;
  num volume_24h;

  MarketCapData(
      {required this.id,
      required this.name,
      required this.market_cap,
      required this.market_cap_change_24h,
      required this.volume_24h});

  MarketCapData.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"],
        this.market_cap = json["market_cap"],
        this.market_cap_change_24h = json["market_cap_change_24h"],
        this.volume_24h = json["volume_24h"];
}
