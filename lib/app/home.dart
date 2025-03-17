import 'dart:convert';

import 'package:avenue_interview/app/usd_to_brl_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<UsdToBrlModel?> getCurrencyData() async {
    try {
      final response = await http.get(
        Uri.parse('https://economia.awesomeapi.com.br/last/USD-BRL'),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = jsonDecode(response.body);
        return UsdToBrlModel.fromJson(data);
      } else {
        throw Exception('Failed to load currency data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCurrencyData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error'));
        } else if (snapshot.hasData) {
          final data = snapshot.data as UsdToBrlModel;
          return Scaffold(
            appBar: AppBar(
              title: const Text('USD to BRL'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'USD to BRL: ${data.ask}',
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
