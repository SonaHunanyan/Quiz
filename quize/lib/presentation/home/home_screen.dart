import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quize/constants.dart' as constants;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    fetchAlbum();
    return Container(color: Colors.pink, height: 200);
  }

  Future<void> fetchAlbum() async {
    final queryParameters = {'apiKey': constants.apiKey, 'limit': '10'};
    final uri =
        Uri.parse(constants.endpointUrl).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    print(response);
  }
}
