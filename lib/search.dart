import 'package:flutter/material.dart';
import 'result.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
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
          divisions: 100,
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
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ResultWidget()));
          },
          child: const Text('TeklifimGelsin'),
        ),
      ],
    );
  }
}
