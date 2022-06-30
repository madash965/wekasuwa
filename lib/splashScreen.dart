// ignore: file_names
import 'package:flutter/material.dart';
import 'package:wekasuwa/homePage.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 100.0,
                      child: Image(
                        image: AssetImage('lib/iconsplash.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      // child: Text('Wekasuwa',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 25.0)),
                    )
                  ],
                ),
              ),
              Column(
                children: const [
                  CircularProgressIndicator(color: Colors.white),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Powered by',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('fiska',
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            fontSize: 20.0)),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

// MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: AnimatedSplashScreen(
//           duration: 1200,
//           curve: Curves.bounceInOut,
//           backgroundColor: Colors.white,
//           splash: 'lib/icononly.png',
//           nextScreen: const HomePage(),
//           splashIconSize: 160.0,
//           splashTransition: SplashTransition.sizeTransition,
//         ));
