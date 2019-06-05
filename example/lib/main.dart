import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

void main() => runApp(MyMainApp());

class MyMainApp extends StatefulWidget {
  @override
  _MyMainAppState createState() => _MyMainAppState();
}

class _MyMainAppState extends State<MyMainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/app': (ctx)=>MyApp(),
        },
        home: MyApp()
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    //
    FlutterPaypal.register(
      sandbox:
      "AU4zQhs9G_nyYAvnNh64quK8UpUrrFZVbEom7ygmr2FwzmjEkLflcDV0Yso2cXhSjZRxfpKp4D6Lt53c",
      production:
      "AS_cHzhWtzdQE1GFPjix2c_l8Ga7Jp_8BDhc0g5IsO8qvWobZkT_RXdtEmenZpN0PrXOwR0oJE5oSYh7",
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterPaypal.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text('Running on: $_platformVersion\n'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FlutterPaypal.payment("100", "充值").then((data) {
          print(data);
        });
      }),
    );
  }
}
