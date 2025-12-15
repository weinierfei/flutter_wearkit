import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_wearkit_method_channel.dart';

abstract class FlutterWearkitPlatform extends PlatformInterface {
  /// Constructs a FlutterWearkitPlatform.
  FlutterWearkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterWearkitPlatform _instance = MethodChannelFlutterWearkit();

  /// The default instance of [FlutterWearkitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterWearkit].
  static FlutterWearkitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterWearkitPlatform] when
  /// they register themselves.
  static set instance(FlutterWearkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
