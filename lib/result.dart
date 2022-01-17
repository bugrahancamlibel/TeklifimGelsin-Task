import 'package:flutter/material.dart';
import 'model.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget( {Key? key, required this.responseData}) : super(key: key);
  final Response responseData;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Gelsin")),
      body: Center(
        child: ListView.builder(
          itemCount: responseData.offers.length,
          itemBuilder: (BuildContext context, int index){
            return BankOffer(index: index, bankOffer: responseData.offers[index],);
          },
        ),
      )
    );
  }
}

class BankOffer extends StatelessWidget {
  const BankOffer({Key? key, required this.index, required this.bankOffer}) : super(key: key);

  final int index;
  final Offer bankOffer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Clicked on it");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFEFEF),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          //color: Colors.grey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bankOffer.bank,style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Text(bankOffer.annualExpenseRate.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("YILLIK GİDER"),
                          Text(bankOffer.annualExpenseRate.toString()),
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
