import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiver/async.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController hourController = TextEditingController();
  TextEditingController minController = TextEditingController();

  var hours;
  var mins;
  String soundValue;
  String soundType;

  int begin = 0;
  String mainImage = 'birds.jpg';
  String mainText = 'Birds chirping';
  String hr = '00';
  String min = '00';
  List hour = [for (var i = 0; i < 25; i += 1) i.toString()];
  List hour2 = [for (var i = 0; i < 60; i += 1) i.toString()];
  String dropdownValue1;
  String dropdownValue2;
  int selectedIndex = 0;
  PageController _pageController = PageController();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  int _start = 0;
  int _start2 = 0;
  int _start3 = 0;
  int _current = 0;
  int _current2 = 0;
  int _current3 = 0;
  // use to stop timer
  int stopTimer = 0;
  int reload = 0;

  void startTimer() {
    void timer1() {
      CountdownTimer countDownTimer = CountdownTimer(
        Duration(seconds: _start3),
        Duration(seconds: 1),
      );
      var sub = countDownTimer.listen(null);
      if (stopTimer == 0) {
        sub.onData((duration) {
          setState(() {
            _current3 = _start3 - duration.elapsed.inSeconds;
            if (_current3 == 0 && _current2 != 0) {
              timer1();
            }
            if (_current == 0 && _current2 == 0 && _current3 == 0) {
              advancedPlayer.stop();
            }
          });
        });
        sub.onDone(() {
          print("Done");
          sub.cancel();
          stopTimer = 0;
        });
      } else {
        sub.cancel();
      }
    }

    timer1();

    void timer2() {
      CountdownTimer countDownTimer2 = CountdownTimer(
        Duration(minutes: _start2),
        Duration(minutes: 1),
      );
      var sub2 = countDownTimer2.listen(null);
      if (stopTimer == 0) {
        sub2.onData((duration2) {
          setState(() {
            _current2 = _start2 - duration2.elapsed.inMinutes;
            if (_current2 == 0 && _current != 0) {
              _current2 = 59;
              _start2 = 59;
              print('here');
              timer2();
            }
            if (_current2 == 0) {
              _current3 = 59;
              timer1();
            }
          });
        });
        sub2.onDone(() {
          print("Done");
          sub2.cancel();
          stopTimer = 0;
        });
      } else {
        sub2.cancel();
      }
    }

    if (_current2 < 1) {
      return;
    } else {
      timer2();
    }

    void timer3() {
      CountdownTimer countDownTimer3 = CountdownTimer(
        Duration(seconds: _start),
        Duration(hours: 1),
      );
      var sub3 = countDownTimer3.listen(null);
      if (stopTimer == 0) {
        sub3.onData((duration3) {
          setState(() {
            _current3 = _start3 - duration3.elapsed.inHours;
          });
        });
        sub3.onDone(() {
          print("Done");
          sub3.cancel();
          stopTimer = 0;
        });
      } else {
        sub3.cancel();
      }
    }

    if (_current <= 1) {
      timer3();
    }
  }

  bool onPressed() {
    if (!_formKey.currentState.validate()) {
      print('fields cannot be empty');
      return false;
    } else if (reload == 1) {
      return false;
    } else {
      setState(() {
        if (stopTimer == 0) {
          _current = hours;
          _start = hours;
          _current3 = 59;
          _start3 = 59;
          _current2 = mins - 1;
          _start2 = _current2;
        }
        if (soundValue == null) {
          return;
        } else if (soundValue == 'Birds') {
          soundType = 'birds.wav';
        } else if (soundValue == 'River') {
          soundType = 'river.wav';
        } else if (soundValue == 'Grazing') {
          soundType = 'cow.wav';
        } else if (soundValue == 'Fireworks') {
          soundType = 'fireworks.wav';
        }
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          title: Text(
            'Dayie',
            style: GoogleFonts.alata(fontSize: 25),
          ),
        ),
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Image.asset('assets/images/ring.png'),
                      Text(
                        '$hr : $min',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DropdownButton(
                        hint: Text('Hrs'),
                        value: dropdownValue1,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue1 = newValue;
                            hr = newValue;
                          });
                        },
                        items: hour.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Text(
                        ':',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                        hint: Text('Mins'),
                        value: dropdownValue2,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.red,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                            min = newValue;
                          });
                        },
                        items: hour2.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Image.asset(
                      'assets/images/checked.png',
                      height: 60,
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Image.asset(
                                'assets/images/$mainImage',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: InkWell(
                              onTap: () {
                                if (begin == 0) {
                                  audioCache.loop('birds.wav');
                                  begin++;
                                }
                                advancedPlayer.resume();
                              },
                              child: Icon(
                                Icons.play_circle_outline,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              mainText,
                              style: GoogleFonts.alata(
                                  textStyle: TextStyle(
                                      color: Colors.red, fontSize: 20)),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                advancedPlayer.stop();
                              },
                              child: Icon(
                                Icons.stop,
                                color: Colors.deepOrangeAccent,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mainImage = 'birds.jpg';
                                  mainText = 'Birds chirping';
                                });
                                advancedPlayer.stop();
                                audioCache.loop('birds.wav');
                              },
                              child: SecondaryList(
                                size: screenWidth / 2,
                                text: 'Birds chirping',
                                image: 'birds.jpg',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mainImage = 'river.jpg';
                                  mainText = 'River sound';
                                });
                                advancedPlayer.stop();
                                audioCache.loop('river.wav');
                                begin++;
                              },
                              child: SecondaryList(
                                size: screenWidth / 2,
                                text: 'River sound',
                                image: 'river.jpg',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mainImage = 'cow.jpg';
                                  mainText = 'Grazing';
                                });
                                advancedPlayer.stop();
                                audioCache.loop('cow.wav');
                                begin++;
                              },
                              child: SecondaryList(
                                size: screenWidth / 2,
                                text: 'Grazing',
                                image: 'cow.jpg',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mainImage = 'fireworks.jpg';
                                  mainText = 'Fireworks';
                                });
                                advancedPlayer.stop();
                                audioCache.loop('fireworks.wav');
                                begin++;
                              },
                              child: SecondaryList(
                                size: screenWidth / 2,
                                text: 'Fireworks',
                                image: 'fireworks.jpg',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Center(
                                child: Text(
                                  "$_current",
                                  style: GoogleFonts.alata(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 30.0)),
                                ),
                              ),
                              color: Colors.black,
                              width: 50.0,
                              height: 80.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  "$_current2",
                                  style: GoogleFonts.alata(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 30.0)),
                                ),
                              ),
                              color: Colors.black,
                              width: 50.0,
                              height: 80.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  "$_current3",
                                  style: GoogleFonts.alata(
                                      textStyle: TextStyle(
                                          color: Colors.white, fontSize: 30.0)),
                                ),
                              ),
                              color: Colors.black,
                              width: 50.0,
                              height: 80.0,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              color: Colors.red,
                              onPressed: () {
                                onPressed();
                                if (onPressed()) {
                                  startTimer();
                                  stopTimer = 1;
                                  if (soundType == null) {
                                    return;
                                  } else {
                                    audioCache.loop(soundType);
                                  }
                                } else {
                                  return;
                                }
                              },
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RaisedButton(
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  stopTimer = 1;
                                  reload = 1;
                                  startTimer();
                                  stopTimer = 0;
                                  reload = 0;
                                  hours = 0;
                                  mins = 0;
                                  _start3 = 0;
                                  _current3 = 0;
                                  onPressed();
                                  if (!onPressed()) advancedPlayer.stop();
                                });
                              },
                              child: Icon(
                                Icons.refresh,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      // controller enables to interact with a field at a time
                                      controller: hourController,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.0,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      // gives effect on select of a field
                                      enableInteractiveSelection: true,
                                      decoration: InputDecoration(
                                        labelText: 'Hours',
                                        labelStyle: TextStyle(
                                          color: Colors.red,
                                        ),
                                        alignLabelWithHint: true,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        contentPadding: EdgeInsets.only(
                                            right: 15.0,
                                            left: 15.0,
                                            top: 15.0,
                                            bottom: 5.0),
                                        hasFloatingPlaceholder: true,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'field cannot be empty';
                                        } else {
                                          hours = int.parse(value);
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType:
                                          TextInputType.numberWithOptions(),
                                      // controller enables to interact with a field at a time
                                      controller: minController,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.0,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      maxLines: 1,
                                      // gives effect on select of a field
                                      enableInteractiveSelection: true,
                                      decoration: InputDecoration(
                                        labelText: 'Mins',
                                        labelStyle: TextStyle(
                                          color: Colors.red,
                                        ),
                                        alignLabelWithHint: true,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        contentPadding: EdgeInsets.only(
                                            right: 15.0,
                                            left: 15.0,
                                            top: 15.0,
                                            bottom: 5.0),
                                        hasFloatingPlaceholder: true,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.purple),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'field cannot be empty';
                                        } else {
                                          mins = int.parse(value);
                                          return null;
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    onPressed();
                                  },
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                RaisedButton(
                                  onPressed: () {},
                                  color: Colors.white,
                                  child: DropdownButton(
                                    hint: Icon(
                                      Icons.audiotrack,
                                      color: Colors.red,
                                    ),
                                    value: soundValue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.red,
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        soundValue = newValue;
                                        //hr = newValue;
                                      });
                                    },
                                    items: [
                                      'Birds',
                                      'River',
                                      'Grazing',
                                      'Fireworks'
                                    ].map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: selectedIndex,
          onItemSelected: (index) => setState(() {
            advancedPlayer.stop();
            selectedIndex = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.alarm),
                title: Text('Alarm'),
                activeColor: Colors.red),
            BottomNavyBarItem(
              icon: Icon(Icons.library_music),
              title: Text('Sleep'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.timer),
                title: Text('Timer'),
                activeColor: Colors.red),
          ],
        ));
  }
}

class SecondaryList extends StatelessWidget {
  final size;
  final text;
  final image;

  const SecondaryList({
    Key key,
    @required this.size,
    @required this.text,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.asset(
                  'assets/images/$image',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.play_circle_outline),
              title: Text(
                text,
                style: GoogleFonts.alata(
                    textStyle: TextStyle(color: Colors.red, fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
