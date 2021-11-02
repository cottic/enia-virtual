import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class DashboardService {
  String chartFromApi;

  static final String _baseUrl = dotenv.env['APISERVER'];

  Future<String> loadChartFromApi(String chartNumber) async {
    final url =
        'https://$_baseUrl/appenia/enia-api-tableros/dashboard0/?chart=${chartNumber}';

    var response = await http.get(url);

    var _source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      chartFromApi = _source;
      return chartFromApi;
    }
    return null;
  }
}
