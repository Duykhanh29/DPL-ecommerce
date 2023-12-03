import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';

class FlashSaleRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Future<List<FlashSale>?> getActiveFlashSale() async {
    List<FlashSale>? result = await firestoreDatabase.getActiveFlashSales();
    return result;
  }

  List<FlashSale>? list = [
    // FlashSale(
    //     id: "flashSaleID01",
    //     coverImage:
    //         "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Twitter_t_Logo.svg/640px-Twitter_t_Logo.svg.png",
    //     discountPercent: 4,
    //     expDate:
    //         Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
    //     releasedDate: Timestamp.fromDate(DateTime(2023, 11, 5)),
    //     name: "Event1"),
    // FlashSale(
    //     id: "flashSaleID02",
    //     coverImage:
    //         "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Twitter_t_Logo.svg/640px-Twitter_t_Logo.svg.png",
    //     discountPercent: 4,
    //     expDate:
    //         Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
    //     releasedDate: Timestamp.fromDate(DateTime(2023, 11, 5)),
    //     name: "Event2"),
    // FlashSale(
    //     id: "flashSaleID03",
    //     coverImage:
    //         "https://thietkewebwio.com/wp-content/uploads/website/logo-website-3.jpg",
    //     discountPercent: 4,
    //     expDate:
    //         Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
    //     releasedDate: Timestamp.fromDate(DateTime(2023, 11, 5)),
    //     name: "Event3"),
    // FlashSale(
    //     id: "flashSaleID04",
    //     coverImage:
    //         "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Facebook_logo_36x36.svg/1024px-Facebook_logo_36x36.svg.png",
    //     discountPercent: 4,
    //     expDate:
    //         Timestamp.fromDate(DateTime.now().add(const Duration(days: 1))),
    //     releasedDate: Timestamp.fromDate(DateTime(2023, 11, 6)),
    //     name: "Event4"),
  ];
}
