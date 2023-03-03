import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:littlefish_smartpos_plugin/models/transaction_models.dart';

import 'littlefish_smartpos_plugin_platform_interface.dart';

/// An implementation of [LittlefishSmartposPluginPlatform] that uses method channels.
class MethodChannelLittlefishSmartposPlugin
    extends LittlefishSmartposPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('littlefish_smartpos_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
        'getPlatformVersion',
        {"deviceType": "A920PRO", "merchantId": "ABC123"});
    return version;
  }

  @override
  Future<bool?> makeSale(Transaction transaction) async {
    final result = await methodChannel.invokeMethod(
      "makePayment",
      transaction.toMap(),
    );

    return result != null;
  }
}
