import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trip Cost Calculator',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  _FuelFormState createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = "";
  final double _formDistance = 5.0;
  final _currencies = ['Dollars', 'Euro', 'Pounds'];
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String _currency = 'Dollars';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Cost Calculator"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                    hintText: "Trip distance, e.g 125",
                    labelStyle: textStyle,
                    labelText: 'Distance (Kms)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1.0))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: _formDistance,
                bottom: _formDistance,
              ),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                    hintText: "Distance covered by one litre of fuel",
                    labelStyle: textStyle,
                    labelText: 'Kilometres per litre',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1.0))),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  top: _formDistance,
                  bottom: _formDistance,
                ),
                child: Row(children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                        hintText: "Price per litre of fuel",
                        labelStyle: textStyle,
                        labelText: 'Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1.0))),
                    keyboardType: TextInputType.number,
                  )),
                  Container(width: _formDistance * 5),
                  Expanded(
                      child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currency,
                          onChanged: (String value) {
                            _onDropDownChanged(value);
                          }))
                ])),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: () {
                      setState(() {
                        result = _calculate();
                      });
                    },
                    child: Text(
                      'Calculate',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            Text(result),
          ],
        ),
      ),
    );
  }

  _onDropDownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelcost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalcost = _distance / _consumption * _fuelcost;
    String _finalcost = _totalcost.toStringAsFixed(2);
    String _result = "The total cost for your trip is $_finalcost $_currency ";
    return _result;
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';

    setState(() {
      result = '';
    });
  }
}
