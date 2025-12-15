import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_wearkit_platform_interface.dart';

/// An implementation of [FlutterWearkitPlatform] that uses method channels.
class MethodChannelFlutterWearkit extends FlutterWearkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_wearkit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
