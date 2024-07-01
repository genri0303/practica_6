import 'package:flutter/material.dart';

class GenderPredictionScreen extends StatefulWidget {
  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _predictGender() {
    setState(() {
      if (_controller.text.toLowerCase().endsWith('a')) {
        _result = 'Femenino';
      } else {
        _result = 'Masculino';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Introduce un nombre',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _predictGender,
          child: Text('Predecir Género'),
        ),
        Text(
          _result,
          style: TextStyle(
            color: _result == 'Femenino' ? Colors.pink : Colors.blue,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
