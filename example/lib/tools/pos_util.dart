import 'package:littlefish_smartpos_plugin/littlefish_smartpos_plugin.dart';
import 'package:littlefish_smartpos_plugin/models/transaction_models.dart';

class POSUtil {
  final _littlefishSmartposPlugin = LittlefishSmartposPlugin();

  Future<bool> makeSale(String deviceType) async {
    Transaction transaction = Transaction()
      ..amount = 50
      ..description = "description"
      ..reference = "reference"
      ..transactionType = TransactionType.sale
      ..tenderType = TenderType.credit
      ..deviceType = deviceType
      ..merchantId = "merchantId";

    var result = await _littlefishSmartposPlugin.makeSale(transaction) ?? false;

    return result;
  }
}
