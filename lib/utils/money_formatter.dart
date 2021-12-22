import 'package:flutter_money_formatter/flutter_money_formatter.dart';

moneyFormatter(String money) {
  FlutterMoneyFormatter fmf =
      FlutterMoneyFormatter(amount: double.tryParse(money));
  return fmf.output.nonSymbol;
}
