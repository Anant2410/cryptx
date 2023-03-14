class Coin {
  final String code;
  final double price;
  final DateTime dateTime;
  Coin({
    required this.code,
    required this.price,
    required this.dateTime,
  });
}

const List<Map> coinTypes = [
  {
    "name": "Bitcoin",
    "code": "btc",
  },
  {
    "name": "Ethereum",
    "code": "eth",
  },
  {
    "name": "Ripple",
    "code": "xrp",
  },
];
