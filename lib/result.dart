import 'dart:math';

import 'package:flutter/material.dart';
import 'model.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget(
      {Key? key,
      required this.responseData,
      required this.amount,
      required this.maturity})
      : super(key: key);
  final Response responseData;
  final int amount;
  final int maturity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(maturity.toString() +
                ' ay vadeli ' +
                amount.toString() +
                'TL için')),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 60,
          //color: Colors.deepOrange,
          child: Center(
              child: Text(
            responseData.totalOffers.toString() + " teklif daha",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          )),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: responseData.offers.length,
            itemBuilder: (BuildContext context, int index) {
              return BankOffer(
                index: index,
                bankOffer: responseData.offers[index],
                amount: amount,
                maturity: maturity,
              );
            },
          ),
        ));
  }
}

class BankOffer extends StatelessWidget {
  const BankOffer(
      {Key? key,
      required this.index,
      required this.bankOffer,
      required this.amount,
      required this.maturity})
      : super(key: key);

  final int index;
  final Offer bankOffer;
  final int amount;
  final int maturity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(bankOffer.bank.toString()),
          content: Text(
            'Yıllık Gider: ' +
                bankOffer.annualExpenseRate.toString() +
                '\n'
                    'Faiz Oranı: ' +
                bankOffer.rate.toString() +
                '\n'
                    'Miktar: ' +
                amount.toString() +
                '\n'
                    'Vade: ' +
                maturity.toString(),
            style: const TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
              color: Color(0xFFEFEFEF),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          //color: Colors.grey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bankOffer.bank,
                style:
                    const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("ORAN"),
                        Text(bankOffer.rate.toString()),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("YILLIK GİDER"),
                        Text(bankOffer.annualExpenseRate.toStringAsFixed(3)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("AYLIK ÖDEME"),
                        Text(monthlyPayment(bankOffer.rate, amount, maturity)
                            .round()
                            .toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


double monthlyPayment(double rate, int amount, int expiry) {
  double totalInterestRate = rate * 0.012;
  num monthlyPayment = amount *
      totalInterestRate *
      pow((1 + totalInterestRate), expiry) /
      (pow((1 + totalInterestRate), expiry) - 1);
  return monthlyPayment.toDouble();
}