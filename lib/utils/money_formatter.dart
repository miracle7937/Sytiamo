
import 'package:intl/intl.dart';

moneyFormatter(String money) {
  final oCcy = NumberFormat("#,###", "en_US");
  return oCcy.format(money);
}
