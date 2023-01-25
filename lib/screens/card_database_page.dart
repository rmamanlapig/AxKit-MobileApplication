import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fap_demo3/constants.dart';
import 'package:after_layout/after_layout.dart';

// CARDS SCREEN
class CardDatabasePage extends StatefulWidget {
  @override
  _CardDatabasePage createState() => _CardDatabasePage();
}

class _CardDatabasePage extends State<CardDatabasePage>
    with AfterLayoutMixin<CardDatabasePage> {
  String dropMenu = 'ALL';
  String cardRoute = 'ALL';
  String cardFile = 'ALL';
  List<Hero> printImages = [];
  int cardNum = 0;
  //rgb(99, 30, 111)
  //rgb(88, 46, 12)
  Color bgColor = const Color.fromRGBO(192, 127, 92, 0.5);

//TODO MAKE THIS FUNCTION ADD THE IMAGES TO THE GRIDVIEW
  void main(int start, int end) {
    int starts = start;
    int ends = end;
    for (int i = starts; i <= ends; i++) {
      String cards = i.toString();
      String tag = i.toString();
      //TODO MAKE THIS FUNCTION ADD IMAGES DYNAMICALLY INSIDE A GRIDVIEW
      printImages.add(
        Hero(
          tag: tag,
          child: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CardHover(
                  cardTag: tag,
                  cardRoute: cardFile.toString(),
                  cardNum: cards,
                );
              }));
              //print('the value is: $cardFile');
            },
            icon: Image.asset('assets/images/$cardFile/$i.png'),
            iconSize: 230,
          ),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // Calling the same function "after layout" to resolve the issue.
    setState(() {
      main(1, 132);
    });
    //print('this will run first');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Database',
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                //background image
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/databaseBg.jpeg"),
                    colorFilter:
                        ColorFilter.mode(Colors.black, BlendMode.dstATop),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white),
              ),
            ],
          ),
          title: Center(
            child: Column(
              children: [
                Stack(
                  children: <Widget>[
                    // Text(
                    //   'Cards Database',
                    //   style: TextStyle(
                    //     fontFamily: 'FredokaOne',
                    //     fontSize: 25,
                    //     foreground: Paint()
                    //       ..style = PaintingStyle.stroke
                    //       ..strokeWidth = 5
                    //       ..color = Colors.black,
                    //   ),
                    // ),
                    const Text('Cards Database', style: kTitleTextStyle),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                  height: 8,
                  thickness: 1.5,
                  indent: 10,
                  endIndent: 10,
                ),
                //DROP DOWN BUTTON HERE===============================================================================
//TODO DROPDOWN FILTERS THE IMAGES
                DropdownButton<String>(
                  value: dropMenu,
                  dropdownColor: Color.fromRGBO(192, 127, 92, 1),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'FredokaOne',
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropMenu = newValue!;
                      cardFile = newValue;
                      //TODO WHEN USER PRESSED A DIFFERENT CLASS, PRINTIMAGES SHOULD BE CLEARED AND BE REPLACED BY THE IMAGES INSIDE THE CLASS

                      if (cardFile == 'ALL') {
                        if (printImages.isEmpty) {
                          main(1, 132);
                        } else {
                          printImages.clear();
                          main(1, 132);
                        }
                      } else if (cardFile == 'AQUA') {
                        if (printImages.isEmpty) {
                          main(1, 22);
                        } else {
                          printImages.clear();
                          main(1, 22);
                        }
                      } else if (cardFile == 'BEAST') {
                        if (printImages.isEmpty) {
                          main(23, 44);
                        } else {
                          printImages.clear();
                          main(23, 44);
                        }
                      } else if (cardFile == 'BIRD') {
                        if (printImages.isEmpty) {
                          main(45, 66);
                        } else {
                          printImages.clear();
                          main(45, 66);
                        }
                      } else if (cardFile == 'BUG') {
                        if (printImages.isEmpty) {
                          main(67, 88);
                        } else {
                          printImages.clear();
                          main(67, 88);
                        }
                      } else if (cardFile == 'PLANT') {
                        if (printImages.isEmpty) {
                          main(89, 110);
                        } else {
                          printImages.clear();
                          main(89, 110);
                        }
                      } else if (cardFile == 'REPTILE') {
                        if (printImages.isEmpty) {
                          main(111, 132);
                        } else {
                          printImages.clear();
                          main(111, 132);
                        }
                      }
                    });
                    //print(values);
                  },
                  items: <String>[
                    'ALL',
                    'AQUA',
                    'BEAST',
                    'BIRD',
                    'BUG',
                    'PLANT',
                    'REPTILE'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              //background image
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/databaseBg.jpeg"),
                  colorFilter:
                      ColorFilter.mode(Colors.black, BlendMode.dstATop),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              //Color Overlay
              color: bgColor,
              child: SafeArea(
                child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: [...printImages]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//A SECOND SCREEN IF USER TAPS THE PICTURE=================================================
//TODO FIX HERO DUPLICATE TAG
class CardHover extends StatelessWidget {
  CardHover(
      {required this.cardRoute, required this.cardTag, required this.cardNum});

  final String cardRoute;
  final String cardNum;
  final String cardTag;

//  final String cardName;

  @override
  Widget build(BuildContext context) {
    //print('the link is $cardRoute and $cardNum plus the tags are $cardTag');
    Color bgColor = Color.fromRGBO(192, 127, 92, 0.5);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        //TODO RESIZE THE PICTURE
        child: Center(
          child: Hero(
            tag: 'Cards',
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  //background image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/databaseBg.jpeg"),
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.dstATop),
                      fit: BoxFit.cover,
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  //Color Overlay
                  color: bgColor,
                  child: Center(
                    child: Image.asset(
                      'assets/images/$cardRoute/$cardNum.png',
                      fit: BoxFit.cover,
                      height: 350.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
