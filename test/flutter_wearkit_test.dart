import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_wearkit/flutter_wearkit.dart';
import 'package:flutter_wearkit/flutter_wearkit_platform_interface.dart';
import 'package:flutter_wearkit/flutter_wearkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterWearkitPlatform
    with MockPlatformInterfaceMixin
    implements FlutterWearkitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterWearkitPlatform initialPlatform = FlutterWearkitPlatform.instance;

  test('$MethodChannelFlutterWearkit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterWearkit>());
  });

  test('getPlatformVersion', () async {
    FlutterWearKit flutterWearkitPlugin = FlutterWearKit();
    MockFlutterWearkitPlatform fakePlatform = MockFlutterWearkitPlatform();
    FlutterWearkitPlatform.instance = fakePlatform;

    expect(await flutterWearkitPlugin.getPlatformVersion(), '42');
  });
}
