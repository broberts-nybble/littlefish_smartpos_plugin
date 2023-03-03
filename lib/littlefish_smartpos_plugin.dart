import 'package:littlefish_smartpos_plugin/models/transaction_models.dart';

import 'littlefish_smartpos_plugin_platform_interface.dart';

class LittlefishSmartposPlugin {
  Future<String?> getPlatformVersion() {
    return LittlefishSmartposPluginPlatform.instance.getPlatformVersion();
  }

  Future<bool?> makeSale(Transaction transaction) {
    return LittlefishSmartposPluginPlatform.instance.makeSale(transaction);
  }
}
