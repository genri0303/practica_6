import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UniversitiesScreen extends StatefulWidget {
  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final TextEditingController _controller = TextEditingController();
  List _universities = [];

  Future<void> _fetchUniversities() async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=${_controller.text}'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _universities = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load universities');
    }
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
              labelText: 'Introduce un país',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _fetchUniversities,
          child: Text('Buscar Universidades'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _universities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_universities[index]['name']),
                subtitle: Text(_universities[index]['web_pages'][0]),
                onTap: () => _launchURL(_universities[index]['web_pages'][0]),
              );
            },
          ),
        ),
      ],
    );
  }

  void _launchURL(String url) {
    // Implementación para abrir URL
  }
}
