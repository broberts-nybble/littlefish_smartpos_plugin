import 'package:littlefish_smartpos_plugin/models/transaction_models.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'littlefish_smartpos_plugin_method_channel.dart';

abstract class LittlefishSmartposPluginPlatform extends PlatformInterface {
  /// Constructs a LittlefishSmartposPluginPlatform.
  LittlefishSmartposPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static LittlefishSmartposPluginPlatform _instance =
      MethodChannelLittlefishSmartposPlugin();

  /// The default instance of [LittlefishSmartposPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelLittlefishSmartposPlugin].
  static LittlefishSmartposPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LittlefishSmartposPluginPlatform] when
  /// they register themselves.
  static set instance(LittlefishSmartposPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> makeSale(Transaction transaction) {
    throw UnimplementedError('makeSale() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
