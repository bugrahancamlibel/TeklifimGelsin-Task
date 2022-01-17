import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'result.dart';
import 'model.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final url = "https://teklifimgelsin.com/api/BriefLoanOffer";
  double _amountSliderValue = 20000;
  double _maturitySliderValue = 36;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Text(
          "KREDİ HESAPLAMA",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        const Spacer(),
        const Text(
          "Toplam Tutar",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        //Card(child: Text(_currentSliderValue.round().toString(),style: const TextStyle(fontSize: 20),),color: Colors.grey.shade100,shadowColor:Colors.transparent,),
        ListTile(
          title: Text(
            _amountSliderValue.round().toString(),
            style: const TextStyle(fontSize: 20),
          ),
          trailing: const Icon(Icons.pending_actions),
        ),
        Slider(
          value: _amountSliderValue,
          max: 100000,
          min: 1000,
          divisions: 99,
          label: _amountSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _amountSliderValue = value;
            });
          },
        ),
        const Spacer(),
        const Text(
          "Vade Süresi",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        ListTile(
          title: Text(
            _maturitySliderValue.round().toString(),
            style: const TextStyle(fontSize: 20),
          ),
          trailing: const Icon(Icons.pending_actions),
        ),
        Slider(
          value: _maturitySliderValue,
          max: 36,
          min: 3,
          divisions: 33,
          label: _maturitySliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _maturitySliderValue = value;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _amountSliderValue.round().toString() +
                " TL  " +
                _maturitySliderValue.round().toString() +
                "Ay vadeli",
            style: const TextStyle(
                fontSize: 20, fontStyle: FontStyle.normal, color: Colors.teal),
          ),
        ),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
          onPressed: () async {
            if (_amountSliderValue < 50000) {
              final responseData = await postData();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ResultWidget(
                        responseData: responseData,
                        amount: _amountSliderValue.toInt(),
                        maturity: _maturitySliderValue.toInt(),
                      )));
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("UYARI"),
                  content: const Text(
                    'Bankacılık Düzenleme ve Denetleme Kurumu(BDDK), 04.09.2020 tarihli kurul kararı ile 50.000 TL üzeri tüketici kredilerinde vade sınırını 36 aydan 24 aya indirmiştir. Lütfen aramanızı güncelleyin.',
                    style: TextStyle(fontSize: 18),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text('TeklifimGelsin'),
        ),
        const Spacer(),
      ],
    );
  }

  Future<Response> postData() async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: requestToJson(
            Request(amount: 20000, monthlyPeriod: 24, n: 3, type: 0)),
      );

      final apiResponse = responseFromJson(response.body);
      return apiResponse;
    } catch (er) {
      return Response(totalOffers: -1, offers: []);
    }
  }
}
