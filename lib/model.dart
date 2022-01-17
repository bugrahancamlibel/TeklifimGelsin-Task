import 'dart:convert';

String requestToJson(Request data) => json.encode(data.toJson());

class Request {
  Request({
    required this.amount,
    required this.monthlyPeriod,
    required this.type,
    required this.n,
  });

  int amount;
  int monthlyPeriod;
  int type;
  int n;

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "monthly_period": monthlyPeriod,
        "type": type,
        "n": n,
      };
}

// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  @override
  String toString() {
    return json.encode(this);
  }

  Response({
    required this.offers,
    required this.totalOffers,
  });

  List<Offer> offers;
  int totalOffers;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        totalOffers: json["total_offers"],
      );

  Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
        "total_offers": totalOffers,
      };
}

class Offer {
  @override
  String toString() {
    return json.encode(this);
  }

  Offer({
    required this.annualExpenseRate,
    required this.bank,
    required this.bankId,
    required this.rate,
  });

  double annualExpenseRate;
  String bank;
  int bankId;
  double rate;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        annualExpenseRate: json["annual_expense_rate"].toDouble(),
        bank: json["bank"],
        bankId: json["bank_id"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "annual_expense_rate": annualExpenseRate,
        "bank": bank,
        "bank_id": bankId,
        "rate": rate,
      };
}
