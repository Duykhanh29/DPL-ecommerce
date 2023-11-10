import 'package:dpl_ecommerce/models/flash_sale.dart';

class FlashSaleRepo {
  List<FlashSale>? list = [
    FlashSale(
        id: "fdasf",
        coverImage:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Twitter_t_Logo.svg/640px-Twitter_t_Logo.svg.png",
        discountPercent: 4,
        expDate: DateTime(2023, 11, 11),
        releasedDate: DateTime(2023, 11, 5),
        name: "Event1"),
    FlashSale(
        id: "fdasf",
        coverImage:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Twitter_t_Logo.svg/640px-Twitter_t_Logo.svg.png",
        discountPercent: 4,
        expDate: DateTime(2023, 11, 11),
        releasedDate: DateTime(2023, 11, 5),
        name: "Event2"),
    FlashSale(
        id: "fdasf",
        coverImage:
            "https://thietkewebwio.com/wp-content/uploads/website/logo-website-3.jpg",
        discountPercent: 4,
        expDate: DateTime(2023, 11, 11),
        releasedDate: DateTime(2023, 11, 5),
        name: "Event3"),
    FlashSale(
        id: "fdasf",
        coverImage:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Facebook_logo_36x36.svg/1024px-Facebook_logo_36x36.svg.png",
        discountPercent: 4,
        expDate: DateTime(2023, 11, 11),
        releasedDate: DateTime(2023, 11, 6),
        name: "Event4"),
  ];
}
