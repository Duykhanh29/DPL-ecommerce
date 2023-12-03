import 'package:dpl_ecommerce/helpers/validators.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:intl/intl.dart';

class CommondMethods {
  CommondMethods._();
  static List<ProductInCartModel> sortByTime(List<ProductInCartModel> list) {
    List<ProductInCartModel> result = list;
    result.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    return result;
  }

  static Voucher? getVoucherFromID(List<Voucher> list, String id) {
    for (var element in list) {
      if (element.id == id) {
        return element;
      }
    }
  }

  static Product? getProductByID(List<Product> list, String id) {
    for (var element in list) {
      if (element.id == id) {
        return element;
      }
    }
  }

  static bool hasConversation(String userID1, String userID2, List<Chat> list) {
    for (var element in list) {
      if ((userID1 == element.sellerID || userID1 == element.userID) &&
          (userID2 == element.sellerID || userID2 == element.userID)) {
        return true;
      }
    }
    return false;
  }

  static Chat? getChatByuserAndSeller(
      String sellerID, String userID, List<Chat> list) {
    for (var element in list) {
      if ((sellerID == element.sellerID && userID == element.userID)) {
        return element;
      }
    }
  }

  static UserModel? getUserModelByShopID(String shopID, List<UserModel> list) {
    for (var element in list) {
      if (element.userInfor!.sellerInfor != null) {
        if (element.userInfor!.sellerInfor!.shopIDs!.contains(shopID)) {
          return element;
        }
      }
    }
  }

  // for groupHeaderBuilder in chatting page
  static String showHeaderTime(DateTime dateTime) {
    if (Validators.compareDate(dateTime)) {
      if (Validators.compareHour(dateTime)) {
        return DateFormat.Hm().format(dateTime);
      } else {
        return "Today";
      }
    } else if (Validators.isSameWeek(DateTime.now(), dateTime)) {
      return DateFormat.EEEE().format(dateTime);
    } else {
      return DateFormat.yMd().format(dateTime);
    }
  }

  static Shop? getShopByID(String id, List<Shop> list) {
    for (var element in list) {
      if (element.id == id) {
        return element;
      }
    }
  }

  static Review? getReviewByID(String id, List<Review> list) {
    for (var element in list) {
      if (element.id == id) {
        return element;
      }
    }
  }

  static List<Review>? getListReview(List<String> listID, List<Review> list) {
    List<Review>? result = [];
    for (var id in listID) {
      for (var review in list) {
        if (review.id == id) {
          Review? rv = getReviewByID(id, list);
          if (rv != null) {
            result.add(rv);
          }
        }
      }
    }
    return result;
  }

  static AddressInfor? getAddressInforByID(String id, List<AddressInfor> list) {
    for (var element in list) {
      if (id == element.id) {
        return element;
      }
    }
  }

  static List<Voucher>? getListVoucherForUser(
      VoucherForUser voucher, List<Voucher> list) {
    List<Voucher> result = [];
    for (var element in voucher.vouchers!) {
      if (CommondMethods.getVoucherFromID(list, element) != null) {
        Voucher voucher = CommondMethods.getVoucherFromID(list, element)!;
        result.add(voucher);
      }
    }
  }
}
