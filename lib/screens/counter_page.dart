import 'package:fap_demo3/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ENERGY + CARD COUNTER SCREEN
class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int energyCounter = 3;
  int cardCounter = 6;
  int roundCounter = 1;
  int eUsed = 0;
  int eGained = 0;
  int eDestroyed = 0;
  int cUsed = 0;
  int cDraw = 0;
  int cDiscard = 0;
  int bloodmoonDamage = 50;
  Color bgColor = Color.fromRGBO(255, 151, 34, 0.5);

  @override
  Widget build(BuildContext context) {
    ///Computations
    void bloodmoonDamageIncrement() {
      bloodmoonDamage = bloodmoonDamage + 30;
    }

    void checkAction(String action) {
      setState(
        () {
          if (action == "reset") {
            energyCounter = 3;
            cardCounter = 6;
            roundCounter = 1;
            eUsed = 0;
            eGained = 0;
            eDestroyed = 0;
            cUsed = 0;
            cDraw = 0;
            cDiscard = 0;
            bgColor = Color.fromRGBO(255, 151, 34, 0.5);
          }
          if (action == "endTurn") {
            if (cardCounter < 12 && energyCounter < 10) {
              if (roundCounter > 9) {
                bloodmoonDamageIncrement();
              }
              if (energyCounter + 2 > 10) {
                energyCounter = energyCounter + 1;
              } else {
                energyCounter = energyCounter + 2;
                roundCounter = roundCounter + 1;
                cardCounter = cardCounter + 3;
                eUsed = 0;
                eGained = 0;
                eDestroyed = 0;
                cUsed = 0;
                cDraw = 0;
                cDiscard = 0;
              }
            } else if (energyCounter == 10) {
              if (roundCounter > 9) {
                bloodmoonDamageIncrement();
              }
              roundCounter = roundCounter + 1;
              if (cardCounter < 10) {
                cardCounter = cardCounter + 3;
              } else if (cardCounter == 10) {
                cardCounter = cardCounter + 2;
              } else if (cardCounter == 11) {
                cardCounter = cardCounter + 1;
              }
              eUsed = 0;
              eGained = 0;
              eDestroyed = 0;
              cUsed = 0;
              cDraw = 0;
              cDiscard = 0;
            } else if (cardCounter == 12) {
              if (roundCounter > 9) {
                bloodmoonDamageIncrement();
              }
              if (energyCounter + 2 > 10) {
                energyCounter = energyCounter + 1;
              } else
                energyCounter = energyCounter + 2;
              roundCounter = roundCounter + 1;
              eUsed = 0;
              eGained = 0;
              eDestroyed = 0;
              cUsed = 0;
              cDraw = 0;
              cDiscard = 0;
            }
          }
          if (action == "eUsedText") {
            if (eUsed == 0) {
            } else {
              energyCounter = energyCounter + 1;
              eUsed = eUsed - 1;
            }
          }
          if (action == "eUsedPlus") {
            if (energyCounter > 0) {
              energyCounter = energyCounter - 1;
              eUsed = eUsed + 1;
            }
          }
          if (action == "eGainedText") {
            if (eGained == 0) {
            } else if (energyCounter != 0) {
              energyCounter = energyCounter - 1;
              eGained = eGained - 1;
            }
          }
          if (action == "eGainedPlus") {
            energyCounter = energyCounter + 1;
            eGained = eGained + 1;
          }
          if (action == "eDestroyedText") {
            if (eDestroyed == 0) {
            } else {
              energyCounter = energyCounter + 1;
              eDestroyed = eDestroyed - 1;
            }
          }
          if (action == "eDestroyedPlus") {
            if (energyCounter > 0) {
              energyCounter = energyCounter - 1;
              eDestroyed = eDestroyed + 1;
            }
          }
          if (action == "cUsedText") {
            if (cUsed == 0) {
            } else {
              cUsed = cUsed - 1;
              cardCounter = cardCounter + 1;
            }
          }
          if (action == "cUsedPlus") {
            if (cardCounter > 0) {
              cardCounter = cardCounter - 1;
              cUsed = cUsed + 1;
            }
          }
          if (action == "cDrawText") {
            if (cDraw == 0) {
            } else if (cardCounter != 0) {
              cardCounter = cardCounter - 1;
              cDraw = cDraw - 1;
            }
          }
          if (action == "cDrawPlus") {
            cDraw = cDraw + 1;
            cardCounter = cardCounter + 1;
          }
          if (action == "cDiscardText") {
            if (cDiscard > 0) {
              cDiscard = cDiscard - 1;
              cardCounter = cardCounter + 1;
            }
          }
          if (action == "cDiscardPlus") {
            if (cardCounter == 0) {
            } else {
              cardCounter = cardCounter - 1;
              cDiscard = cDiscard + 1;
            }
          }
        },
      );
    }

    return MaterialApp(
      title: 'Counter Page',
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              //background image
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/axie-land-bg.jpg"),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .005,
                    ),

                    ///Round Counter
                    Text(
                      "Round $roundCounter",
                      style: kRoundTextStyle,
                    ),

                    ///Energy Left, Cards Right Group
                    FittedBox(
                      child: Row(
                        children: <Widget>[
                          ///Energy Group
                          Column(
                            children: <Widget>[
                              ///Enemy Energy Title
                              Text(
                                "Enemy Energy",
                                style: kCommonTextStyle,
                              ),

                              ///Enemy Energy Counter
                              Text(
                                '$energyCounter',
                                style: TextStyle(
                                  fontFamily: 'FredokaOne',
                                  fontSize: 55,
                                  color: Colors.white,
                                ),
                              ),

                              ///Energy Used Group
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ///Energy Used Title
                                  Text(
                                    "Energy Used",
                                    style: kCommonTextStyle,
                                  ),

                                  ///Energy Used Functionality
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          // print(MediaQuery.of(context).size.width * 0.16);
                                          // print(MediaQuery.of(context).size.height *
                                          //     0.096321);
                                          // width on pc emulator (MediaQuery.of(context).size.width * 0.16) = 65.82857142857144
                                          // height on pc emulator (MediaQuery.of(context).size.height * 0.096321) = 65.82852342857143
                                          checkAction("eUsedText");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          //height: 65.82852342857143,
                                          //width: 65.82857142857144,
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              left: 8,
                                              right: 8,
                                              bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kRedButtonColor,
                                            border: Border.all(
                                                color: kBrownBorderColor,
                                                width: 5), //#10EB99
                                          ),
                                          child: FittedBox(
                                            //fit: BoxFit.scaleDown,
                                            child: Text(
                                              "$eUsed",
                                              style: TextStyle(
                                                fontFamily: 'FredokaOne',
                                                fontSize: 300,
                                                //     MediaQuery.of(context)
                                                //             .size
                                                //             .height *
                                                //         0.096321,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //rgb(139, 232, 201)
                                          color: kGreenButtonColor,
                                          border: Border.all(
                                              color: kBrownBorderColor,
                                              width: 5), //#10EB99
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            checkAction("eUsedPlus");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              ///Energy Gained Group
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ///Energy Gained Title
                                  Text(
                                    "Energy Gained",
                                    style: kCommonTextStyle,
                                  ),

                                  ///Energy Gained Functionality
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          checkAction("eGainedText");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              left: 8,
                                              right: 8,
                                              bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kRedButtonColor,
                                            border: Border.all(
                                                color: kBrownBorderColor,
                                                width: 5), //#10EB99
                                          ),
                                          child: FittedBox(
                                            child: Text("$eGained",
                                                style: kButtonTextStyle2),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //rgb(139, 232, 201)
                                          color: kGreenButtonColor,
                                          border: Border.all(
                                              color: kBrownBorderColor,
                                              width: 5), //#10EB99
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            checkAction("eGainedPlus");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              ///Energy Destroyed Group
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ///Energy Destroyed Title
                                  Text(
                                    "Energy Destroyed",
                                    style: kCommonTextStyle,
                                  ),

                                  ///Energy Destroyed Functionality
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          checkAction("eDestroyedText");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              left: 8,
                                              right: 8,
                                              bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kRedButtonColor,
                                            border: Border.all(
                                                color: kBrownBorderColor,
                                                width: 5), //#10EB99
                                          ),
                                          child: FittedBox(
                                            child: Text("$eDestroyed",
                                                style: kButtonTextStyle2),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //rgb(139, 232, 201)
                                          color: kGreenButtonColor,
                                          border: Border.all(
                                              color: kBrownBorderColor,
                                              width: 5), //#10EB99
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            checkAction("eDestroyedPlus");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .05,
                          ),

                          ///Cards Group
                          Column(
                            children: <Widget>[
                              ///Enemy Cards Title
                              Text(
                                "Enemy Cards",
                                style: kCommonTextStyle,
                              ),

                              ///Enemy Card Counter
                              Text(
                                '$cardCounter',
                                style: TextStyle(
                                  fontFamily: 'FredokaOne',
                                  fontSize: 55,
                                  color: Colors.white,
                                ),
                              ),

                              ///Cards Used Group
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ///Enemy Cards Used Title
                                  Text(
                                    "Cards Used",
                                    style: kCommonTextStyle,
                                  ),

                                  ///Enemy Cards Used Functionality
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          checkAction("cUsedText");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              left: 8,
                                              right: 8,
                                              bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kBrownButtonColor,
                                            border: Border.all(
                                                color: kBrownBorderColor,
                                                width: 5),
                                          ),
                                          child: FittedBox(
                                            child: Text("$cUsed",
                                                style: kButtonTextStyle2),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //rgb(139, 232, 201)
                                          color: kRedButtonColor,
                                          border: Border.all(
                                              color: kBrownBorderColor,
                                              width: 5), //#10EB99
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            checkAction("cUsedPlus");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              ///Draw Cards Group
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ///Enemy Draw Cards Title
                                  Text(
                                    "Draw Card",
                                    style: kCommonTextStyle,
                                  ),

                                  ///Enemy Draw Cards Functionality
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          checkAction("cDrawText");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          margin: const EdgeInsets.all(4.0),
                                          padding: const EdgeInsets.only(
                                              top: 0,
                                              left: 8,
                                              right: 8,
                                              bottom: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kBrownButtonColor,
                                            border: Border.all(
                                                color: kBrownBorderColor,
                                                width: 5), //#10EB99
                                          ),
                                          child: FittedBox(
                                            child: Text("$cDraw",
                                                style: kButtonTextStyle2),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //rgb(139, 232, 201)
                                          color: kGreenButtonColor,
                                          border: Border.all(
                                              color: kBrownBorderColor,
                                              width: 5), //#10EB99
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            checkAction("cDrawPlus");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              ///Discard Cards Group
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ///Enemy Discard Card Title
                                  Text(
                                    "Discard Cards",
                                    style: kCommonTextStyle,
                                  ),

                                  ///Enemy Discard Card Functionality
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          checkAction("cDiscardText");
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.096321,
                                          margin: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: kBrownButtonColor,
                                            border: Border.all(
                                                color: kBrownBorderColor,
                                                width: 5), //#10EB99
                                          ),
                                          child: FittedBox(
                                            child: Text("$cDiscard",
                                                style: kButtonTextStyle2),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.096321,
                                        margin: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          //rgb(139, 232, 201)
                                          color: kRedButtonColor,
                                          border: Border.all(
                                              color: kBrownBorderColor,
                                              width: 5), //#10EB99
                                        ),
                                        child: IconButton(
                                          icon: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            checkAction("cDiscardPlus");
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),

                    ///End Turn  + Reset Button
                    Column(
                      children: [
                        if (roundCounter > 9) ...[
                          Text("Bloodmoon Damage: $bloodmoonDamage",
                              style: kCommonTextStyle2),
                        ],

                        ///End Turn Button
                        FittedBox(
                          child: GestureDetector(
                            onTap: () {
                              checkAction("endTurn");
                              if (roundCounter > 9) {
                                bgColor = Color.fromRGBO(219, 70, 71, 0.5);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 12),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kEndTurnButtonColor,
                                border: Border.all(
                                    color: kBrownBorderColor, width: 5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      MdiIcons.swordCross,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    onPressed: () {},
                                  ),
                                  const Text(
                                    'END TURN',
                                    style: kCommonTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),

                        ///Reset Button
                        FittedBox(
                          child: GestureDetector(
                            onTap: () {
                              checkAction("reset");
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 14),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * .55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kRedButtonColor,
                                border: Border.all(
                                    color: kBrownBorderColor, width: 5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      MdiIcons.repeat,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    onPressed: () {},
                                  ),
                                  const Text(
                                    'RESET',
                                    style: kCommonTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
