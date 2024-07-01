import 'package:flutter/material.dart';

class AgePredictionScreen extends StatefulWidget {
  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String _image = '';

  void _determineAge() {
    int age = int.tryParse(_controller.text) ?? 0;
    setState(() {
      if (age < 18) {
        _result = 'Joven';
        _image = 'assets/young.png';
      } else if (age < 65) {
        _result = 'Adulto';
        _image = 'assets/adult.png';
      } else {
        _result = 'Anciano';
        _image = 'assets/elderly.png';
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Introduce tu edad',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _determineAge,
          child: Text('Determinar Edad'),
        ),
        Text(
          _result,
          style: TextStyle(fontSize: 24),
        ),
        if (_image.isNotEmpty) Image.asset(_image),
      ],
    );
  }
}
