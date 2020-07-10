import 'package:common_ui/module/service_locator.dart';
import 'package:common_ui/navigation/bottom_sheet_service.dart';
import 'package:common_ui/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:web_test/bottomsheet.dart';
import 'package:web_test/ppp.dart';
import 'package:web_test/services/navigation/router.dart';
import 'package:web_test/sss.dart';

import 'bottomsheet.dart';

void main() {
  setUpServices();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      title: 'Flutter Demo',
      builder: getBuilder,
      theme: ThemeData(
//        primaryColor: primaryColor,
//        accentColor: primaryColor,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController textEditingController = TextEditingController();
  String myToken;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: page1()),
            RaisedButton(
              child: Text("Fetch token"),
              color: Colors.red,
              onPressed: () {
                BounceDart.fetchToken(allowInterop(_showToken));
//                js.context.callMethod('printName', ["sumit"]);
//                myFunction();
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => page2()),
//                );
              },
            ),
            Text(
              myToken == null ? 'Token:' : 'Token: $myToken',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void myFunction() {
    postMessage("Hey hi hello");
  }

  _showToken(String string) async {
    print('My Token: ' + string);
    setState(() {
      myToken = string;
    });
  }
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
//  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Container();
//    return WillPopScope(
////      onWillPop: () => _handleBack(context),
////      child: WebView(
////        onWebViewCreated: (WebViewController webViewController) {
////          _controller = webViewController;
////        },
////        javascriptChannels: <JavascriptChannel>[
////          JavascriptChannel(
////              name: 'Print',
////              onMessageReceived: (JavascriptMessage message) {
////                print(message.message);
////              }),
//////          JavascriptChannel(
//////              name: 'Roopesh',
//////              onMessageReceived: (JavascriptMessage message) {
//////                print(message.message);
//////              })
////        ].toSet(),
////        initialUrl: " http://192.168.0.106:8080",
////        onPageStarted: (msg) {
////          print(msg);
////        },
////        javascriptMode: JavascriptMode.unrestricted,
////        // onPageStarted: (url) {
////        //   onPageStarted(url);
////        // },
////        // onPageFinished: (url) {
////        //   onPageLoaded(url);
////        // },
////      ),
//    );
  }

//  Future<void> _handleBack(context) async {
////    var status = await _controller.canGoBack();
//    if (status) {
////      _controller.goBack();
//    } else {
//      showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//                title: Text('Do you want to exit'),
//                actions: <Widget>[
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: Text('No'),
//                  ),
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: Text('Yes'),
//                  ),
//                ],
//              ));
//    }
//  }
}

class page1 extends StatelessWidget {
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: RaisedButton(
            child: Text("Open Bottom sheet"),
            color: Colors.red,
            onPressed: () async {
              await _bottomSheetService.showDismissibleBottomSheet(
                  child: Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      color: Colors.blue,
                      child: Center(
                          child: Text(
                        "Hey this is a bottom sheet",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )),
                    ),
                  ),
                  dismissible: false);

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => page2()),
              // );
            },
          ),
        ),
      ],
    ));
  }
}

Widget getBuilder(BuildContext context, Widget widget) {
  return Navigator(
    onGenerateRoute: (settings) => MaterialPageRoute(
      builder: (context) => BottomSheetManager(
        child: widget,
      ),
    ),
  );
}

class page2 extends StatelessWidget {
  @override
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () => _bottomSheetService.showDismissibleBottomSheet(
                dismissible: false,
                child: Container(
                  height: 200,
                  color: Colors.yellow,
                )),
            child: Center(child: Text("Page2"))));
  }
}
