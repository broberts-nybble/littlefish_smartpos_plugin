import 'package:flutter_test/flutter_test.dart';
import 'package:littlefish_smartpos_plugin/littlefish_smartpos_plugin.dart';
import 'package:littlefish_smartpos_plugin/littlefish_smartpos_plugin_platform_interface.dart';
import 'package:littlefish_smartpos_plugin/littlefish_smartpos_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLittlefishSmartposPluginPlatform
    with MockPlatformInterfaceMixin
    implements LittlefishSmartposPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LittlefishSmartposPluginPlatform initialPlatform = LittlefishSmartposPluginPlatform.instance;

  test('$MethodChannelLittlefishSmartposPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLittlefishSmartposPlugin>());
  });

  test('getPlatformVersion', () async {
    LittlefishSmartposPlugin littlefishSmartposPlugin = LittlefishSmartposPlugin();
    MockLittlefishSmartposPluginPlatform fakePlatform = MockLittlefishSmartposPluginPlatform();
    LittlefishSmartposPluginPlatform.instance = fakePlatform;

    expect(await littlefishSmartposPlugin.getPlatformVersion(), '42');
  });
}
