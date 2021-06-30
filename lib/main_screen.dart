import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'location.dart';
import 'package:http/http.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location myLocation = Location();
    await myLocation.getCurrentLocation();
    print(myLocation.latitude);
    print(myLocation.longitude);
  }

  void getData() async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=26.594594594594593&lon=81.30506516476466&appid=257842d39a3783089f32e764f1e74a7a');
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Column(
        children: [
          Container(
            // constraints: BoxConstraints.expand(),
            height: 575.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/night2.jpg'),
              fit: BoxFit.fill,
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
                      TextButton(
                          onPressed: () {},
                          child: Icon(
                            FontAwesomeIcons.locationArrow,
                            color: Colors.white,
                          )),
                      Text(
                        'Los Angeles',
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
                    'clear',
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
                    '25°',
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
            color: Color(0xff3a287e),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'today, Mon 4',
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'humidity: 10%',
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'feels: 27°',
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
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tuesday 5',
                        style: TextStyle(
                          fontFamily: 'lightMontserrat',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sunny, 31°',
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
