import 'package:http/http.dart';
import 'main_screen.dart';
import 'dart:convert';

class Weather {
  String cityName, weatherDescription, data;
  int cityTemp, cityHumidity, cityFeels;

  Future<void> getCityName() async {
    cityName = jsonDecode(data)['name'];
  }

  Future<void> getWeatherDescription() async {
    weatherDescription = jsonDecode(data)['weather'][0]['main'];
  }

  Future<void> getTemp() async {
    cityTemp = (jsonDecode(data)['main']['temp']);
  }

  Future<void> getHumidity() async {
    cityHumidity = jsonDecode(data)['main']['humidity'];
  }

  Future<int> getFells() async {
    cityFeels = jsonDecode(data)['main']['feels_likes'];
  }
}
