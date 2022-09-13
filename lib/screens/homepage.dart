import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                      "/icons/fa_sun-o.svg",
                      color: clrPrimary,
                      cacheColorFilter: false,
                      height: 46,
                      width: 46,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "31,9°",
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
                      "Billisi, Geogia",
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 26,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        width: double.infinity,
                        // height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: clrPrimary,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "18:00",
                              style: myfont(
                                13,
                                clrWhite000,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              "/icons/fa_sun-o.svg",
                              color: clrWhite000,
                              cacheColorFilter: false,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "12°",
                              style: myfont(
                                16,
                                clrWhite000,
                                FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        width: double.infinity,
                        // height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xffB46490),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "18:00",
                              style: myfont(
                                13,
                                clrWhite000,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              "/icons/ion_rainy-outline.svg",
                              color: clrWhite000,
                              cacheColorFilter: false,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "12°",
                              style: myfont(
                                16,
                                clrWhite000,
                                FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 20,
                        ),
                        width: double.infinity,
                        // height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xff49577A),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "18:00",
                              style: myfont(
                                13,
                                clrWhite000,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SvgPicture.asset(
                              "/icons/moon-line.svg",
                              color: clrWhite000,
                              cacheColorFilter: false,
                              height: 30,
                              width: 30,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "12°",
                              style: myfont(
                                16,
                                clrWhite000,
                                FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                                "12 m/h",
                                style: myfont(
                                  14,
                                  clrBlack100,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "25 m/h",
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Humidity",
                                style: myfont(14),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "UV",
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
                                "55%",
                                style: myfont(
                                  14,
                                  clrBlack100,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "1",
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
