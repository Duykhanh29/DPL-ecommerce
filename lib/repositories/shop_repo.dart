import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/category_chart.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/daily_revenue.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';

class ShopRepo {
  FirestoreDatabase _shopFirestoreDB = FirestoreDatabase();
  Future<Shop?> getShopByID(String id) async {
    return await _shopFirestoreDB.getSHopByID(id);
  }

  Future<List<Shop>?> getListShop() async {
    return await _shopFirestoreDB.getListShop();
  }

  Future<List<Product>?> getListProductByShopID(String shopID) async {
    return await _shopFirestoreDB.getProductListByShop(shopID);
  }

  Future<void> sendVerificationForm(
      {required VerificationForm verificationForm}) async {
    await _shopFirestoreDB.sendVerificationForm(
        verificationForm: verificationForm);
  }

  Future<void> updateRatingCountForShop(
      {required String shopID, required double rating}) async {
    await _shopFirestoreDB.updateRatingCountForShop(
        shopID: shopID, rating: rating);
  }

  Future<void> updateShop(
      {required String shopID,
      String? name,
      String? logo,
      int? rating,
      int? shopView,
      String? contactPhone,
      AddressInfor? addressInfor,
      String? shopDescription}) async {
    await _shopFirestoreDB.updateShop(
        shopID: shopID,
        addressInfor: addressInfor,
        contactPhone: contactPhone,
        logo: logo,
        name: name,
        rating: rating,
        shopDescription: shopDescription,
        shopView: shopView);
  }

  Future<void> updateShopView(String shopID) async {
    await _shopFirestoreDB.updateShopView(shopID);
  }

  Future<List<CategoryChart>?> getTotalProductOfEachCategoryByShop(
      String shopID) async {
    return await _shopFirestoreDB.getTotalProductOfEachCategoryByShop(shopID);
  }

  Future<List<Shop>?> searchShopByName(String name) async {
    return await _shopFirestoreDB.searchShopByName(name);
  }

  Future<void> dispose() async {
    await _shopFirestoreDB.dispose();
  }

  final List<DailyRevenue> listRevenue = [
    DailyRevenue(date: DateTime.now(), revenue: 123400, shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 1)),
        revenue: 12300,
        shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 2)),
        revenue: 234567,
        shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 3)),
        revenue: 65432,
        shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 4)),
        revenue: 21000,
        shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 5)),
        revenue: 320007,
        shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 6)),
        revenue: 123412,
        shopID: "shopID01"),
    DailyRevenue(
        date: DateTime.now().subtract(Duration(days: 7)),
        revenue: 54321,
        shopID: "shopID01"),
  ];

  final List<Shop> listShop = [
    Shop(
      ratingCount: 123,
      totalProduct: 32,
      name: "DK",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet nam",
          isDefaultAddress: false,
          latitude: 123.12,
          longitude: 123,
          name: "My address",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0987654321",
      id: "shopID01",
      shopDescription:
          "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
      logo:
          "https://cdn.shopify.com/shopifycloud/hatchful_web_two/bundles/4a14e7b2de7f6eaf5a6c98cb8c00b8de.png",
      rating: 4.4,
      shopView: 120,
      totalRevenue: 120000,
      totalOrder: 12,
    ),
    Shop(
      ratingCount: 12,
      totalProduct: 54,
      name: "DK",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 123.12,
          longitude: 123,
          name: "My Address 1",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0987654321",
      id: "shopID02",
      shopDescription:
          "Immerse yourself in the world of literature at Bookworm Haven. Explore our extensive collection of books, from bestsellers to hidden gems, and feed your love for reading",
      logo:
          "https://cdn.shopify.com/shopifycloud/hatchful_web_two/bundles/4a14e7b2de7f6eaf5a6c98cb8c00b8de.png",
      rating: 4.4,
      shopView: 120,
      totalRevenue: 220000,
      totalOrder: 22,
    ),
    Shop(
      name: "ABC Store",
      ratingCount: 123,
      totalProduct: 14,
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: true,
          latitude: 10.776889,
          longitude: 106.700897,
          name: "My Address 2",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0901234567",
      id: "shopID03",
      shopDescription:
          "Transform your living space with Home Harmony Decor. Our curated collection of hom",
      logo:
          "https://kienlongbank.com/Data/Sites/1/media/logo-klb/logo-kienlongbank-favicon.png",
      rating: 3.9,
      shopView: 95,
      totalRevenue: 1230000,
      totalOrder: 42,
    ),
    Shop(
      ratingCount: 51,
      totalProduct: 23,
      name: "XYZ Shop",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 16.047079,
          longitude: 108.206230,
          name: "My Address 3",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0977123456",
      shopDescription: "THis is incredible store for you to try on clothes",
      id: "shopID04",
      logo: "https://www.yiiframework.com/image/design/logo/yii3_sign.png",
      rating: 4.1,
      shopView: 88,
      totalRevenue: 420000,
      totalOrder: 52,
    ),
    Shop(
      ratingCount: 32,
      totalProduct: 21,
      name: "Fashion Haven",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 16.466370,
          longitude: 107.590868,
          name: "My Address 4",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0938888888",
      id: "shopID05",
      shopDescription:
          "Transform your living space with Home Harmony Decor. Our curated collection of hom",
      logo:
          "https://upload.wikimedia.org/wikipedia/commons/3/35/Red_Velvet_Logo.jpg",
      rating: 4.8,
      shopView: 150,
      totalRevenue: 150000,
      totalOrder: 12,
    ),
    Shop(
      ratingCount: 65,
      totalProduct: 2,
      name: "Tech Junction",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: true,
          latitude: 12.238791,
          longitude: 109.196290,
          name: "My Address 5",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0912345678",
      id: "shopID06",
      shopDescription:
          "Transform your living space with Home Harmony Decor. Our curated collection of hom",
      logo: "https://www.yiiframework.com/image/design/logo/yii3_sign.png",
      rating: 4.6,
      shopView: 110,
      totalRevenue: 1230000,
      totalOrder: 12,
    ),
    Shop(
      ratingCount: 123,
      totalProduct: 14,
      name: "Gourmet Delights",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 10.040911,
          longitude: 105.779464,
          name: "My Address 6",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0965432109",
      id: "shopID07",
      logo:
          "https://upload.wikimedia.org/wikipedia/commons/3/35/Red_Velvet_Logo.jpg",
      rating: 4.2,
      shopView: 75,
      totalRevenue: 120000,
      totalOrder: 12,
    ),
    Shop(
      name: "Books Galore",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 10.347652,
          longitude: 107.084789,
          name: "My Address 7",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0987654320",
      id: "shopID08",
      shopDescription:
          "Elevate your workout experience with Fitness Fusion Gear. Find top-quality activewear, fitness equipment, and accessories to help you achieve your health and wellness goals.",
      logo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1I4WzAPniRr3wY54B-bvRgFcQTdqcHA--SK5bvMRKooZpt-mEbszq34h5Z5LevnvY7K4&usqp=CAU",
      rating: 4.5,
      shopView: 95,
      totalRevenue: 120000,
      totalOrder: 12,
    ),
    Shop(
        ratingCount: 76,
        totalProduct: 54,
        name: "Home Essentials",
        addressInfor: AddressInfor(
            city: City(id: "8", name: "Tuyen Quang"),
            country: "Viet Nam",
            isDefaultAddress: true,
            latitude: 11.936457,
            longitude: 108.441129,
            name: "My Address 8",
            district: District(id: "123", name: "Hoang Mai")),
        contactPhone: "0905123456",
        id: "shopID09",
        logo:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1I4WzAPniRr3wY54B-bvRgFcQTdqcHA--SK5bvMRKooZpt-mEbszq34h5Z5LevnvY7K4&usqp=CAU",
        rating: 3.7,
        shopDescription:
            "Explore the cutting-edge world of technology at Gadget Galaxy. We offer a wide range of gadgets, from smartphones to smart home devices, ensuring you stay connected in style.",
        shopView: 80,
        totalRevenue: 120000),
    Shop(
      ratingCount: 67,
      totalProduct: 21,
      name: "Sports World",
      shopDescription:
          "Discover the latest trends and styles at Fashion Haven Boutique. From casual wear to elegant evening dresses, we have everything to keep you in vogue",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 10.931838,
          longitude: 108.103235,
          name: "My Address 9",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0917123456",
      id: "shopID10",
      logo:
          "https://t3.ftcdn.net/jpg/01/22/72/98/360_F_122729880_a4rHgPGiwVktwwsovKfL2iqrd2vM042R.jpg",
      rating: 4.0,
      shopView: 70,
      totalOrder: 12,
    ),
    Shop(
        ratingCount: 123,
        totalProduct: 14,
        name: "Pet Paradise",
        addressInfor: AddressInfor(
            city: City(id: "8", name: "Tuyen Quang"),
            country: "Viet Nam",
            isDefaultAddress: false,
            latitude: 20.862732,
            longitude: 106.683732,
            name: "My Address 10",
            district: District(id: "123", name: "Hoang Mai")),
        contactPhone: "0909654321",
        id: "shopID11",
        shopDescription:
            "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
        logo:
            "https://t3.ftcdn.net/jpg/01/22/72/98/360_F_122729880_a4rHgPGiwVktwwsovKfL2iqrd2vM042R.jpg",
        rating: 4.9,
        shopView: 130),
    Shop(
      name: "Fashionista",
      addressInfor: AddressInfor(
          city: City(id: "8", name: "Tuyen Quang"),
          country: "Viet Nam",
          isDefaultAddress: false,
          latitude: 21.028511,
          longitude: 105.854164,
          name: "My Address 11",
          district: District(id: "123", name: "Hoang Mai")),
      contactPhone: "0987654322",
      id: "shopID12",
      shopDescription:
          "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
      logo:
          "https://kienlongbank.com/Data/Sites/1/media/logo-klb/logo-kienlongbank-favicon.png",
      rating: 4.7,
      shopView: 105,
      totalOrder: 12,
    ),
    Shop(
        name: "Tech Trend",
        addressInfor: AddressInfor(
            city: City(id: "8", name: "Tuyen Quang"),
            country: "Viet Nam",
            isDefaultAddress: false,
            latitude: 10.776889,
            longitude: 106.700897,
            name: "My Address 12",
            district: District(id: "123", name: "Hoang Mai")),
        contactPhone: "0901234568",
        id: "shopID13",
        shopDescription:
            "Cultivate your love for gardening with Green Thumb Nursery. We offer a variety of plants, gardening tools, and expert advice to help you create a vibrant and thriving garden.",
        logo:
            "https://kienlongbank.com/Data/Sites/1/media/logo-klb/logo-kienlongbank-favicon.png",
        rating: 4.3,
        shopView: 88)
  ];
}
