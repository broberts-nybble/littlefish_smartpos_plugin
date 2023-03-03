import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:littlefish_smartpos_plugin/littlefish_smartpos_plugin.dart';
import 'package:littlefish_smartpos_plugin_example/tools/pos_util.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  String? _terminal = "Unknown";

  bool isLoading = false;

  final _littlefishSmartposPlugin = LittlefishSmartposPlugin();

  get onSearch => null;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await _getPlatformVersion();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(background: Theme.of(context).primaryColor),
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('LittleFish SMART POS - Test App'),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            children: [
              Text('Running on: $_platformVersion\n'),
              DropdownButton<String>(
                enableFeedback: true,
                value: _terminal,
                items: const [
                  DropdownMenuItem(
                    value: "Unknown",
                    child: Text("Unknown Terminal"),
                  ),
                  DropdownMenuItem(
                    value: "A920PRO",
                    child: Text("A920 Pro"),
                  ),
                ],
                onChanged: (String? value) {
                  //This is purely used to help select the device version
                  if (mounted) {
                    setState(() {
                      _terminal = value;
                    });
                  } else {
                    _terminal = value;
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("REFRESH PLATFORM VERSION"),
                  onPressed: () async {
                    _getPlatformVersion();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("PRINT RECEIPT"),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("MAKE SALE"),
                  onPressed: () {
                    _makeSale();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("VOID SALE"),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text("CLOSE BATCH"),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getPlatformVersion() async {
    _setLoading(true);

    try {
      String platformVersion;
      // Platform messages may fail, so we use a try/catch PlatformException.
      // We also handle the message potentially returning null.
      try {
        platformVersion =
            await _littlefishSmartposPlugin.getPlatformVersion() ??
                'Unknown platform version';
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

      _showMessage("Platform version : $_platformVersion");
    } catch (e) {
      log(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  _setLoading(bool value) {
    if (mounted) {
      setState(() {
        isLoading = value;
      });
    } else {
      isLoading = value;
    }
  }

  _showMessage(String message) {
    toast(message);
  }

  _makeSale() async {
    var result = await POSUtil().makeSale(_terminal ?? "");

    if (result) {
      _showMessage("Payment was successful");
    } else {
      _showMessage("Payment failed");
    }
  }
}
