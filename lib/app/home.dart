import 'dart:convert';

import 'package:avenue_interview/app/usd_to_brl_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
            FutureBuilder(
              future: getListOfUsdBy15(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (snapshot.hasData) {
                  final data = snapshot.data as ListOfUsdToBrlModel;
                  final list = data.list;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final item = list[index];
                        final timestamp = int.parse(item.timestamp ?? '0');
                        final date =
                            DateTime.fromMillisecondsSinceEpoch(timestamp);
                        final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
                        final formattedDate = dateFormat.format(date);
                        return ListTile(
                          title: Text(
                            'USD to BRL: ${item.ask}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          subtitle: Text(
                            'Date: $formattedDate',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          onTap: () async {
                            showBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'USD to BRL: ${item.ask}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                      Text(
                                        'Date: $formattedDate',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                            ),
                                      ),
                                      ElevatedButton(
                                        child: Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      OutlinedButton(
                                        child: Text('Ir para o Site'),
                                        onPressed: () {
                                          launchUrl(
                                            Uri.parse('https://avenue.us/cambio/'),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
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
