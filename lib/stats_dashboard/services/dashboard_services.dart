import 'dart:convert';

import 'package:http/http.dart' as http;

class DashboardService {
  String chartFromApi;

  static final String _baseUrl =
      'https://proyecto.codigoi.com.ar/appenia/enia-api-tableros';

  Future<String> loadChartFromApi(String chartNumber) async {
    final url = '$_baseUrl/dashboard0/?chart=${chartNumber}';

    var response = await http.get(url);

    var _source = Utf8Decoder().convert(response.bodyBytes);

    if (response.statusCode == 200) {
      chartFromApi = _source;
      return chartFromApi;
    } 
    return null;
  }
}
