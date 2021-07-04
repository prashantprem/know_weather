import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:know_weather/search_city.dart';
import 'location.dart';
import 'package:http/http.dart';
import 'weather.dart';
import 'networking.dart';
import 'dart:convert';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.locationWeather, this.nextdayWeather})
      : super(key: key);
  final locationWeather, nextdayWeather;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String cityName, todayDate, tomorrowDate;
  String weatherDescription;
  double cityTemp, tomTemp;
  int cityHumidity, date, date2;
  double cityFeels;
  var nightImage = AssetImage('assets/images/ic_night.jpg');
  var morningImage = AssetImage('assets/images/ic_morning2.png');
  var eveningImage = AssetImage('assets/images/ic_evening.jpg');
  var nightColour = Color(0xff090611),
      morningColour = Color(0xFF315F50),
      eveningColour = Color(0xFF875B24);
  var mImage, mColour;
  var today, tomorrow, tomWeatherdes;
  dynamic dayData =
      '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';

  dynamic monthData =
      '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May", "6" : "June", "7" : "Jul", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" }';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather, widget.nextdayWeather);
    print(widget.locationWeather);
  }

  void updateUI(dynamic weatherData, dynamic nextDay) {
    cityName = weatherData['name'];
    weatherDescription = weatherData['weather'][0]['main'];
    cityTemp = weatherData['main']['temp'];
    cityHumidity = weatherData['main']['humidity'];
    cityFeels = weatherData['main']['feels_like'];
    date = weatherData['dt'];
    today = new DateTime.fromMillisecondsSinceEpoch(date * 1000);
    // print(today.hour);
    todayDate = (json.decode(dayData)['${today.weekday}'] +
            " " +
            today.day.toString() +
            " " +
            json.decode(monthData)['${today.month}'])
        .toString();

    print(todayDate);
    date2 = nextDay['daily'][1]['dt'];
    tomWeatherdes = nextDay['daily'][1]['weather'][0]['description'];
    tomTemp = nextDay['daily'][1]['temp']['day'];
    print(tomWeatherdes);
    print(tomTemp);
    tomorrow = new DateTime.fromMillisecondsSinceEpoch(date2 * 1000);
    tomorrowDate = (json.decode(dayData)['${tomorrow.weekday}'] +
            " " +
            tomorrow.day.toString() +
            " " +
            json.decode(monthData)['${tomorrow.month}'])
        .toString();
    if (today.hour > 5 && today.hour <= 11) {
      mImage = morningImage;
      mColour = morningColour;
    }
    if (today.hour >= 12 && today.hour < 18) {
      mImage = eveningImage;
      mColour = eveningColour;
    }
    if ((today.hour >= 18 && today.hour <= 24) ||
        (today.hour >= 1 && today.hour <= 5)) {
      mImage = nightImage;
      mColour = nightColour;
    }
  }

  @override
  Widget build(BuildContext context) {
    // updateUI();
    return Scaffold(
      body: Column(
        children: [
          Container(
            // constraints: BoxConstraints.expand(),
            height: 580.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: mImage,
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchCity();
                            }));
                          },
                          icon: Icon(
                            FontAwesomeIcons.search,
                            color: Colors.white,
                          )),
                      Text(
                        cityName,
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    weatherDescription,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'extralightMontserrat',
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    cityTemp.toInt().toString() + '°',
                    style: TextStyle(
                        fontSize: 80.0, fontFamily: 'extralightMontserrat'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Recommendation',
                    style: TextStyle(
                      fontFamily: 'extralightMontserrat',
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'speed a cozy evening outdoor',
                    style: TextStyle(
                      fontFamily: 'extralightMontserrat',
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            color: mColour,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'today, ' + todayDate,
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'humidity: ' + cityHumidity.toString() + '%',
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'feels:  ' + cityFeels.toInt().toString() + '°',
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 40.0,
                  color: Colors.white,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tomorrowDate,
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        tomWeatherdes + ", " + tomTemp.toInt().toString() + '°',
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
