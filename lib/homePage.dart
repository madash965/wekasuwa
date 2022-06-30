// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final GlobalKey webViewKey = GlobalKey();
  double _progress = 0;
  String url = "https://www.wekasuwa.com";
  late InAppWebViewController webViewController;
  late PullToRefreshController pullToRefreshController;
  final isDialOpen = ValueNotifier(false);
  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.orange,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController.reload();
        } else if (Platform.isIOS) {
          webViewController.loadUrl(
              urlRequest: URLRequest(url: await webViewController.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= const Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (await webViewController.canGoBack()) {
            webViewController.goBack();
            // Stay in app
            return false;
          } else if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else if (isExitWarning) {
            const message = 'Press back again to exit!';
            Fluttertoast.showToast(msg: message, fontSize: 10);

            return false;
          } else {
            // exit from app
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  pullToRefreshController: pullToRefreshController,
                  initialUrlRequest: URLRequest(
                    url: Uri.parse("https://www.wekasuwa.com"),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        useOnDownloadStart: true,
                        mediaPlaybackRequiresUserGesture: false,
                      ),
                      ios: IOSInAppWebViewOptions(
                        allowsInlineMediaPlayback: true,
                      ),
                      android: AndroidInAppWebViewOptions(
                          useHybridComposition: true)),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (webViewController, url) {
                    setState(() {
                      this.url = url.toString();
                    });
                  },
                  onProgressChanged: (webViewController, progress) {
                    if (progress == 100) {
                      pullToRefreshController.endRefreshing();
                    }
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  androidOnPermissionRequest:
                      (webViewController, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  onLoadStop: (webViewController, url) async {
                    pullToRefreshController.endRefreshing();
                    setState(() {
                      this.url = url.toString();
                    });
                  },
                  // onDownloadStartRequest: (webViewController, url) async {

                  //   final taskId = await FlutterDownloader.enqueue(
                  //     url: "https://www.wekasuwa.com",
                  //     savedDir: (await getExternalStorageDirectory())!.path,
                  //     showNotification:
                  //         true, // show download progress in status bar (for Android)
                  //     openFileFromNotification:
                  //         true, // click on notification to open downloaded file (for Android)
                  //   );
                  // },
                ),
                _progress < 1
                    ? SizedBox(
                        height: 3,
                        child: LinearProgressIndicator(
                          value: _progress,
                          color: Colors.black,
                          backgroundColor: Colors.orange,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: FaIcon(
              FontAwesomeIcons.retweet,
              size: 24,
            ),
            backgroundColor: Colors.orange[700],
            foregroundColor: Colors.white,
            splashColor: Colors.red,
            onPressed: () => webViewController.reload(),
          ),
        ));
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late WebViewController controller;
//   final isDialOpen = ValueNotifier(false);
//   bool showSpinner = true;

// @override
// void initState() {
//   super.initState();
//   if (Platform.isAndroid) {
//     WebView.platform = SurfaceAndroidWebView();
//   } // <<== THIS
// }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.white,
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.dark,
//       systemNavigationBarColor: Colors.white,
//       systemNavigationBarIconBrightness: Brightness.dark,
//     ));
// return WillPopScope(
//   onWillPop: () async {
//     if (await controller.canGoBack()) {
//       controller.goBack();
//       // Stay in app
//       return false;
//     } else if (isDialOpen.value) {
//       isDialOpen.value = false;
//       return false;
//     } else {
//       // exit from app
//       return true;
//     }
//   },
//       child: Scaffold(
//         body: SafeArea(
//           child: ModalProgressHUD(
//             progressIndicator: const CircularProgressIndicator(
//               color: Colors.orange,
//             ),
//             inAsyncCall: showSpinner,
//             child: WebView(
//                 initialUrl: 'https://www.wekasuwa.com/',
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onPageFinished: (finished) {
//                   setState(() {
//                     showSpinner = false;
//                   });
//                 },
//                 onWebViewCreated: (controller) {
//                   this.controller = controller;
//                 }),
//           ),
//         ),
//         floatingActionButton: SpeedDial(
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
//       ),
//     );
//   }
// }

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

// final difference = DateTime.now().difference(timeBackPressed);
//           final isExitWarning = difference >= const Duration(seconds: 2);

//           timeBackPressed = DateTime.now();

//           if (isExitWarning) {
//             const message = 'Press back again to exit!';
//             Fluttertoast.showToast(msg: message, fontSize: 10);

//             return false;
//           } else {
//             Fluttertoast.cancel();
//             return true;
//           }
