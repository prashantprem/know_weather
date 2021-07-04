import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:know_weather/main_screen.dart';
import 'location.dart';
import 'networking.dart';
import 'loading_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), getLocation);
  }
  // () =>   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
  // return MainScreen(
  // locationWeather: weatherData,
  // nextdayWeather: nextDayWeatherData,
  // );
  // }))

  double cityLatitude, cityLongitude;
  var weatherData, nextDayWeatherData;

  void getLocation() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    cityLatitude = myLocation.latitude;
    cityLongitude = myLocation.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=$cityLatitude&lon=$cityLongitude&appid=257842d39a3783089f32e764f1e74a7a&units=metric');
    weatherData = await networkHelper.getData();
    NetworkHelper nextdayNetworkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/onecall?lat=$cityLatitude&lon=$cityLongitude&exclude=minutely,hourly&appid=257842d39a3783089f32e764f1e74a7a&units=metric');
    nextDayWeatherData = await nextdayNetworkHelper.getData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        locationWeather: weatherData,
        nextdayWeather: nextDayWeatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.orange, Colors.pink])),
        child: SpinKitWave(
          color: Colors.yellowAccent,
          size: 90.0,
        ),
      ),
    );
  }
}
