class UsdToBrlModel {
  final String? code;
  final String? codein;
  final String? name;
  final String? high;
  final String? low;
  final String? varBid;
  final String? pctChange;
  final String? bid;
  final String? ask;
  final String? timestamp;
  final String? create_date;

  UsdToBrlModel({
    this.code,
    this.codein,
    this.name,
    this.high,
    this.low,
    this.varBid,
    this.pctChange,
    this.bid,
    this.ask,
    this.timestamp,
    this.create_date,
  });

  factory UsdToBrlModel.fromJson(Map<String, dynamic> json) {
    return UsdToBrlModel(
      code: json['code'],
      codein: json['codein'],
      name: json['name'],
      high: json['high'],
      low: json['low'],
      varBid: json['varBid'],
      pctChange: json['pctChange'],
      bid: json['bid'],
      ask: json['ask'],
      timestamp: json['timestamp'],
      create_date: json['create_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'codein': codein,
      'name': name,
      'high': high,
      'low': low,
      'varBid': varBid,
      'pctChange': pctChange,
      'bid': bid,
      'ask': ask,
      'timestamp': timestamp,
      'create_date': create_date,
    };
  }
}