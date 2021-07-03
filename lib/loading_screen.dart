import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location.dart';
import 'networking.dart';
import 'main_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    // updateUI();
    print('bfvhjbdhvbd');
  }

  double cityLatitude, cityLongitude;
  var weatherData;

  void getLocation() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    cityLatitude = myLocation.latitude;
    cityLongitude = myLocation.longitude;
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=$cityLatitude&lon=$cityLongitude&appid=257842d39a3783089f32e764f1e74a7a&units=metric');
    weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen(
        locationWeather: weatherData,
      );
    }));
    print(weatherData);
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
          duration: Duration(milliseconds: 1200),
        ),
      ),
    );
  }
}
