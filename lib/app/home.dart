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
        return ConvertedModel.fromJson(data).USDBRL;
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

  Future<ListOfUsdToBrlModel?> getListOfUsdBy15() async {
    try {
      final response = await http.get(
        Uri.parse('https://economia.awesomeapi.com.br/json/daily/USD-BRL/15'),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = jsonDecode(response.body);
        return ListOfUsdToBrlModel.fromJson(data);
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
    return SizedBox.expand(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getCurrencyData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data as UsdToBrlModel;
                  return Text(
                    'USD to BRL: ${data.ask}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
