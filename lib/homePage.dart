import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: const Text("hello"));
  }
}

// // ignore_for_file: file_names

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();

//     // if (Platform.isAndroid) {
//     //   AndroidInAppWebViewController.setWebContentsDebuggingEnabled(
//     //       true); // <<== THIS
//     // }

//     @override
//     Widget build(BuildContext context) {
//       SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         statusBarColor: Colors.white,
//         statusBarBrightness: Brightness.light,
//         statusBarIconBrightness: Brightness.dark,
//         systemNavigationBarColor: Colors.white,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ));
//       return Scaffold(
//         appBar: AppBar(title: const Text("Hallo")),
//       );
//     }
//   }
// }

// child: Scaffold(
//           body: SafeArea(
//             child: WebviewScaffold(
//               url: "https://www.wekasuwa.com",
//               withLocalStorage: true,
//               withLocalUrl: true,
//               withJavascript: true,
//               geolocationEnabled: true,
//               withZoom: true,
//               hidden: false,
//               initialChild: Container(
//                 color: Colors.transparent,
//                 child: const Center(
//                   child: Text(
//                     'Waiting.....',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.0,
//                         fontSize: 20.0),
//                   ),
//                 ),
//               ),
//               bottomNavigationBar: BottomAppBar(
//                 elevation: 10.0,
//                 child: ElevatedButton(
//                   child: const Icon(
//                     Icons.cached,
//                     size: 34.0,
//                   ),
//                   onPressed: () {
//                     flutterWebViewPlugin.reload();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.orange[700],
//                     fixedSize: const Size(50, 50),
//                     shape: const CircleBorder(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//   }

// child: Scaffold(
//         body: SafeArea(
//           child: ModalProgressHUD(
//             progressIndicator: const CircularProgressIndicator(
//               color: Colors.orange,
//             ),
//             inAsyncCall: spinner,
//             child: WebView(
//                 initialUrl: 'https://www.wekasuwa.com/',
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onPageFinished: (finished) {
//                   setState(() {
//                     spinner = false;
//                   });
//                 },
//                 onWebViewCreated: (controller) {
//                   this.controller = controller;
//                 }),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const FaIcon(
//             FontAwesomeIcons.retweet,
//             size: 24,
//           ),
//           backgroundColor: Colors.orange[700],
//           foregroundColor: Colors.white,
//           splashColor: Colors.red,
//           onPressed: () => controller.reload(),
//         ),
//       ),

// child: FloatingActionButton(
//             child: FaIcon(
//               FontAwesomeIcons.retweet,
//               size: 24,
//             ),
//             backgroundColor: Colors.orange[700],
//             foregroundColor: Colors.white,
//             splashColor: Colors.red,
//             onPressed: () => controller.reload(),
//           ),

// floatingActionButton: SpeedDial(
//             animatedIcon: AnimatedIcons.menu_close,
//             backgroundColor: Colors.orange[800],
//             overlayOpacity: 0.5,
//             spacing: 10.0,
//             spaceBetweenChildren: 8.0,
//             openCloseDial: isDialOpen,
//             children: [
//               SpeedDialChild(
//                 child: const Icon(Icons.cached),
//                 label: 'Refresh',
//                 onTap: () => controller.reload(),
//               ),
//               SpeedDialChild(
//                 child: const Icon(Icons.clear_all_outlined),
//                 label: 'Cache & Cookies',
//                 onTap: () {
//                   controller.clearCache();
//                   CookieManager().clearCookies();
//                 },
//               ),
//             ]),
