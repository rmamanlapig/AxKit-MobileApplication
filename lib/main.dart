// @dart=2.9
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fap_demo3/screens/conversion_page.dart';
import 'package:fap_demo3/screens/counter_page.dart';
import 'package:fap_demo3/screens/card_database_page.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AxKit - Axie Toolkit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CarouselController _controller = CarouselController();
  CarouselSlider carouselSlider;
  int _current = 0;
  List imgList = [
    'assets/cardDatabase.png', //Cards Database
    'assets/cardCounter.png', //Counter
    'assets/cardConversion.png', //Conversion
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ///Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/axie-infinity-site-logo.png"),
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            ///Color Overlay
            //rgb(0, 125, 193)s
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(0, 125, 193, 0.5),

            ///Main Widgets (Cards)
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  carouselSlider = CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: (MediaQuery.of(context).size.height * .8),
                      //height: 546.7428571428571,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      autoPlay: false,
                      reverse: false,
                      enableInfiniteScroll: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 2000),
                      pauseAutoPlayOnTouch: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),

                    /// Cards
                    items: imgList.map(
                      (imgURL) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(imgURL, fit: BoxFit.fill),
                                ),
                                onTap: () {
                                  // print(_current);
                                  // print(MediaQuery.of(context).size.height * .8);
                                  //height on pc emulator = 546.7428571428571
                                  if (_current == 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CardDatabasePage()));
                                  } else if (_current == 1) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CounterPage()));
                                  } else if (_current == 2) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConversionPage()));
                                  }
                                },
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      imgList,
                      (index, url) {
                        return Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? Colors.white
                                : const Color.fromRGBO(0, 125, 193, 1.0),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    "©Axie Infinity. All Rights Reserved",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
