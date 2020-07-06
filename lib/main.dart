import 'dart:async';
import 'package:common_ui/module/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:common_ui/navigation/bottom_sheet_service.dart';

void main() {
  setUpServices();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
            RaisedButton(
              child: Text("Move to page 1 "),
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page1()),
                );
              },
            ),
            RaisedButton(
              child: Text("Move to page 2 "),
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page2()),
                );
              },
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBack(context),
      child: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        initialUrl: "https://roopeshlr-bounce.github.io/ltr_test/#/",
        javascriptMode: JavascriptMode.unrestricted,
        // onPageStarted: (url) {
        //   onPageStarted(url);
        // },
        // onPageFinished: (url) {
        //   onPageLoaded(url);
        // },
      ),
    );
  }

  Future<void> _handleBack(context) async {
    var status = await _controller.canGoBack();
    if (status) {
      _controller.goBack();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Do you want to exit'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              ));
    }
  }
}

class page1 extends StatelessWidget {
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        RaisedButton(
          child: Text("move to new screen page 2"),
          color: Colors.red,
          onPressed: () {
            _bottomSheetService.showDismissibleBottomSheet(
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Text("its a bottom sheet "),
                ),
                dismissible: true,
                isScrollControlled: false);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => page2()),
            // );
          },
        ),
        Center(child: Text("Page1")),
      ],
    ));
  }
}

class page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Page2")));
  }
}
