import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  String urlApi;
  NetworkHelper(this.urlApi);
  Future getData() async {
    var url = Uri.parse(urlApi);
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
