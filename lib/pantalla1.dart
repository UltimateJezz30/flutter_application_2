import 'package:flutter/material.dart';
import 'pantalla2.dart';
import 'pantalla3.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedUnitFrom = 'Metros';
  String _selectedUnitTo = 'Kilómetros';
  String _result = '';

  final Map<String, double> _conversionRates = {
    'Metros': 1.0,
    'Kilómetros': 0.001,
    'Millas': 0.000621371,
    'Pulgadas': 39.3701,
    'Pies': 3.28084,
    'Yardas': 1.09361,
  };

  void _convert() {
    double? input = double.tryParse(_inputController.text);
    if (input == null) {
      setState(() {
        _result = 'Por favor, ingresa un número válido';
      });
      return;
    }

    double rateFrom = _conversionRates[_selectedUnitFrom]!;
    double rateTo = _conversionRates[_selectedUnitTo]!;
    double result = input * rateTo / rateFrom;

    setState(() {
      _result = '$input $_selectedUnitFrom son ${result.toStringAsFixed(2)} $_selectedUnitTo';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convertidor de Longitud"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese la cantidad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _selectedUnitFrom,
                  items: _conversionRates.keys
                      .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitFrom = value!;
                    });
                  },
                ),
                const Icon(Icons.swap_horiz),
                DropdownButton<String>(
                  value: _selectedUnitTo,
                  items: _conversionRates.keys
                      .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUnitTo = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _convert();
              },
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pantalla2()),
                );
              },
              child: const Text('Ir a Historial de Conversiones'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Pantalla3()),
                );
              },
              child: const Text('Ir a Mensaje de Agradecimiento'),
            ),
          ],
        ),
      ),
    );
  }
}
