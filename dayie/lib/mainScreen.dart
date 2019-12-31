import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
                                  advancedPlayer.stop();
                                  audioCache.loop('cow.wav');
                                });
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
                                  advancedPlayer.stop();
                                  audioCache.loop('fireworks.wav');
                                });
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
              color: Colors.white,
            )
          ],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: selectedIndex,
          onItemSelected: (index) => setState(() {
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
