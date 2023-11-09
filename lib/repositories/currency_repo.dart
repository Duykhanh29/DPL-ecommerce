import 'package:dpl_ecommerce/models/currency_infor.dart';

class CurrencyRepo {
  final List<CurrencyInfor> listCurrency = [
    CurrencyInfor(
        code: "VND",
        id: "704",
        name: "Việt Nam đồng",
        isDefault: true,
        symbol:
            "https://static.vecteezy.com/system/resources/previews/006/060/067/original/dong-icon-vietnamese-currency-symbol-illustration-coin-symbol-free-vector.jpg"),
    CurrencyInfor(
        code: "USD",
        id: "840",
        isDefault: false,
        name: "US Dollar",
        symbol: "https://cdn-icons-png.flaticon.com/512/33/33007.png")
  ];
}
