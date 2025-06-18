class CryptoData {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? high24h;
  double? low24h;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool isFavourite = false;

  CryptoData({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.circulatingSupply,
    this.ath,
    this.atl,
  });

  CryptoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = double.parse(json['current_price'].toString());
    marketCap = double.parse(json['market_cap'].toString());
    marketCapRank = json['market_cap_rank'];
    high24h = double.parse(json['high_24h'].toString());
    low24h = double.parse(json['low_24h'].toString());
    priceChange24h = double.parse(json['price_change_24h'].toString());
    priceChangePercentage24h = double.parse(
      json['price_change_percentage_24h'].toString(),
    );
    circulatingSupply = double.parse(json['circulating_supply'].toString());
    ath = double.parse(json['ath'].toString());
    atl = double.parse(json['atl'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    data['high_24h'] = this.high24h;
    data['low_24h'] = this.low24h;
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    data['circulating_supply'] = this.circulatingSupply;
    data['ath'] = this.ath;
    data['atl'] = this.atl;
    return data;
  }
}
