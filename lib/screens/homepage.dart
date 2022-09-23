import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/theme/theme.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? position;

  Map<String, dynamic>? weatherMap;
  Map<String, dynamic>? forecastMap;

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    print("position is ${position!.latitude} ${position!.longitude}");
    fetchWeatherData();
  }

  fetchWeatherData() async {
    String weatherApi =
        "https://api.openweathermap.org/data/2.5/weather?lat=${position!.latitude}&lon=${position!.longitude}&appid=f79464db0b72d0fcdf098da8dd8dc27a";

    String forecastApi =
        "https://api.openweathermap.org/data/2.5/forecast?lat=${position!.latitude}&lon=${position!.longitude}&appid=f79464db0b72d0fcdf098da8dd8dc27a";

    var weatherDataResponse = await http.get(Uri.parse(weatherApi));
    var forecastDataResponse = await http.get(Uri.parse(forecastApi));
    print(weatherDataResponse.body);

    setState(
      () {
        weatherMap =
            Map<String, dynamic>.from(jsonDecode(weatherDataResponse.body));
        forecastMap =
            Map<String, dynamic>.from(jsonDecode(forecastDataResponse.body));
      },
    );
  }

  tempCelsius(value) {
    double tempFahrenheit = value;
    double tempCelsius = (tempFahrenheit - 32) * 0.5556;
    String temp = tempCelsius.toStringAsFixed(2);
    return temp;
  }

  CoOrdinates(CoOrd) {
    double coord = CoOrd;
    String coordString = coord.toStringAsFixed(2);
    return coordString;
  }

  // weather icon according to weather data
  weatherImage(weatherStatus) {
    String weatherImg =
        "${weatherStatus == "haze" ? "/icons/haze-fill.svg" : weatherStatus == "light rain" ? "/icons/ion_rainy.svg" : weatherStatus == "clear sky" ? "/icons/fa_sun-o.svg" : "/icons/fa_sun-o.svg"}";

    return weatherImg;
  }

  @override
  void initState() {
    // TODO: implement initState
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: weatherMap == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      color: clrWhite100,
                    ),
                  ),
                ),
                ListView(
                  children: [
                    // appbar

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: Icon(
                          Icons.menu_rounded,
                          color: clrBlack000,
                          size: 20,
                        ),
                        title: Text(
                          "Weather Forecast",
                          style: myfont(15),
                        ),
                        centerTitle: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "${weatherImage(weatherMap!["weather"][0]["description"])}",
                            // color: clrPrimary,
                            cacheColorFilter: false,
                            height: 46,
                            width: 46,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${tempCelsius(weatherMap!["main"]["temp"])}°c",
                            style: myfont(
                              36,
                              clrBlack000,
                              FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "${Jiffy(DateTime.now()).format("h:mm a, MMM d, yyyy")}",
                            style: myfont(14, clrBlack100),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "${weatherMap!["name"]}",
                            style: myfont(14, clrBlack100),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          Text(
                            "Today",
                            style: myfont(14),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                      ),
                      height: 150,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 20,
                            ),
                            width: MediaQuery.of(context).size.width * 0.3 - 12,
                            // height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: index == 0
                                  ? clrPrimary
                                  : index == 1
                                      ? Color(0xffB46490)
                                      : Color(0xff49577A),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${Jiffy(forecastMap!["list"][index * 2]["dt_txt"]).format("h:mm a")}",
                                  style: myfont(
                                    13,
                                    clrWhite000,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SvgPicture.asset(
                                  "${weatherImage(forecastMap!["list"][index * 2]["weather"][0]["description"])}",
                                  color: clrWhite000,
                                  cacheColorFilter: false,
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "${tempCelsius(forecastMap!["list"][index * 2]["main"]["temp"])}°c",
                                  style: myfont(
                                    16,
                                    clrWhite000,
                                    FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8,
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Additional Info",
                            style: myfont(16),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Wind",
                                      style: myfont(14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Visibility",
                                      style: myfont(14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Humidity",
                                      style: myfont(14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Sea Level",
                                      style: myfont(14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${weatherMap!["wind"]["speed"]}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${weatherMap!["visibility"]}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${weatherMap!["main"]["humidity"]}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${weatherMap!["main"]["sea_level"]}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Clouds",
                                      style: myfont(14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Pressure",
                                      style: myfont(14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "lat",
                                      style: myfont(14),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "lon",
                                      style: myfont(14),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${weatherMap!["clouds"]["all"]}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${weatherMap!["main"]["pressure"]}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${CoOrdinates(weatherMap!["coord"]["lat"])}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${CoOrdinates(weatherMap!["coord"]["lon"])}",
                                      style: myfont(
                                        14,
                                        clrBlack100,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
