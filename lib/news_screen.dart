import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List _news = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final response = await http.get(
      Uri.parse('https://blog.millerti.me/wp-json/wp/v2/posts?_embed&per_page=3'),
    );
    if (response.statusCode == 200) {
      setState(() {
        _news = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Image.network('https://blog.millerti.me/wp-content/uploads/2021/01/cropped-cropped-icon_m-512-1-192x192.png'),
                Expanded(
                  child: ListView.builder(
                    itemCount: _news.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_news[index]['title']['rendered']),
                        subtitle: Text(_news[index]['excerpt']['rendered'].replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '')),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          _launchURL(_news[index]['link']);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
