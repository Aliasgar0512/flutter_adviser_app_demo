import 'dart:convert';
import 'dart:io';
import 'package:flutter_adviser/0_data/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;

import '../models/advice_model.dart';

abstract class AdviceRemoteDataSources {
  /// request random advice from api
  /// returns [AdviceModel] if successful
  /// returns Server-Exception if status code is not 200
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourcesImpl implements AdviceRemoteDataSources {
  /*
   TODO : HTTP 
   * 
   * - read it online, in course we didn't get much info about this.
   * 
   * - https://pub.dev/packages/http 
   * - above link has good explanation about the package.
   * 
   * 
   */
  final http.Client client;
  AdviceRemoteDataSourcesImpl({required this.client});

  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    // Await the http get response, then decode the json-formatted response.
    final response = await client.get(
        Uri.parse('https://api.flutter-community.com/api/v1/advice'),
        headers: {
          'content-type': 'application/json ',
        });
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      // decoding of json-formatted response.
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJson(responseBody);
    }
  }
}
