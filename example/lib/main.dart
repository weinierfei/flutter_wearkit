import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_wearkit/flutter_wearkit.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Android';
  final _flutterWearkitPlugin = FlutterWearKit();

  // Status logs
  String _log = "Logs:\n";

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _initListeners();
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
      Permission.contacts,
      Permission.sms,
    ].request();
    debugPrint("Permission statuses: $statuses");
  }

  void _initListeners() {
    // Listen to bluetooth status
    _flutterWearkitPlugin.bleStatusStream.listen((status) {
      _appendLog("BLE Status: $status");
    });

    // Listen to battery status
    _flutterWearkitPlugin.batteryStream.listen((battery) {
      _appendLog("Battery update: ${battery.toJson()}");
    });
  }

  void _appendLog(String message) {
    setState(() {
      _log = "$message\n$_log";
    });
    debugPrint(message);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Example: Connect to a device (Replace MAC with actual device MAC)
                        // Note: Real testing requires a valid MAC and device.
                        _appendLog("Connecting...");
                        await _flutterWearkitPlugin.connectDevice(
                          3, // deviceType
                          0, // authType (Bind)
                          null,
                          "71:AA:DE:4C:0A:4E", // Replace with real MAC
                          "user_123", // userId
                          true, // Sex
                          25, // Age
                          175.0, // Height
                          70.0, // Weight
                        );
                      },
                      child: const Text('Connect Device (Mock MAC)'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _appendLog("Disconnecting...");
                        await _flutterWearkitPlugin.disConnectDevice();
                      },
                      child: const Text('Disconnect'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final info = await _flutterWearkitPlugin
                            .getDeviceInfo();
                        _appendLog("Device Info: ${info?.toJson()}");
                      },
                      child: const Text('Get Device Info'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final battery = await _flutterWearkitPlugin
                            .getDeviceBattery();
                        _appendLog("Device Battery: ${battery?.toJson()}");
                      },
                      child: const Text('Get Battery'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _appendLog("Finding Watch...");
                        await _flutterWearkitPlugin.findWatch();
                      },
                      child: const Text('Find Watch'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _appendLog("Supporting Weather?");
                        final supported = await _flutterWearkitPlugin
                            .isSupportWeather();
                        _appendLog("Weather Supported: $supported");
                      },
                      child: const Text('Check Weather Support'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const Text("Logs:"),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_log),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
