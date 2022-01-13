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
        const Text("KREDİ HESAPLAMA"),
        const Text("Toplam Tutar"),
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
        const Text("Toplam Tutar"),
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
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
          onPressed: () async {
            final responseData = await postData();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ResultWidget(responseData: responseData)));
          },
          child: const Text('TeklifimGelsin'),
        ),
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
      print(apiResponse);
      print(apiResponse.totalOffers);
      print("peki bu???");
      print(apiResponse.offers[0]);
      return apiResponse;

    } catch (er) {
      print(er);
      print("olmadı be!");
      return Response(totalOffers: -1, offers: []);
    }
  }
}
