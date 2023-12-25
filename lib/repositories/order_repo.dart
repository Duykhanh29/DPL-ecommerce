import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';

class OrderRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Future<List<Order>?> getListOrderByUserID(String uid) async {
    return await firestoreDatabase.getListOrderByUserID(uid);
  }

  Stream<List<Order>?> getAllOrderByUser(String uid) {
    return firestoreDatabase.getAllOrderByUserID(uid);
  }

  Future<void> addAnOrder(Order order) async {
    await firestoreDatabase.addAnOrder(order);
  }

  Future<Order?> getOrderByID(String id) async {
    return await firestoreDatabase.getOrderByID(id);
  }

  Future<void> updateOrderingProductStatus(
      {required String orderID,
      required String orderingProductID,
      required DeliverStatus status}) async {
    await firestoreDatabase.updateOrderingProductStatus(
        orderID: orderID, orderingProductID: orderingProductID, status: status);
  }

  Future<List<OrderingProduct>?> getListOrderingProductByOrder(
      String orderID) async {
    return await firestoreDatabase.getListOrderingProductByOrder(orderID);
  }

  final listorder = List.generate(
      15,
      (index) => Order(
          deliverServiceID: "deliverID01",
          // deliverStatus: DeliverStatus.delivering,
          id: "orderID01",
          orderingProductsID: [
            OrderingProduct(
                id: "orderingProductID01",
                price: 120000,
                productID: "productID01",
                realPrice: 100000,
                userID: "userID01",
                voucherID: "voucherID01"),
            OrderingProduct(
                id: "orderingProductID02",
                price: 130000,
                productID: "productID02",
                realPrice: 110000,
                userID: "userID02",
                voucherID: "voucherID02"),
            OrderingProduct(
                id: "orderingProductID03",
                price: 140000,
                productID: "productID03",
                realPrice: 120000,
                userID: "userID03",
                voucherID: "voucherID03"),
            OrderingProduct(
                id: "orderingProductID04",
                price: 150000,
                productID: "productID04",
                realPrice: 130000,
                userID: "userID04",
                voucherID: "voucherID04"),
            OrderingProduct(
                id: "orderingProductID05",
                price: 160000,
                productID: "productID05",
                realPrice: 140000,
                userID: "userID05",
                voucherID: "voucherID05"),
            OrderingProduct(
                id: "orderingProductID06",
                price: 170000,
                productID: "productID06",
                realPrice: 150000,
                userID: "userID06",
                voucherID: "voucherID06"),
            OrderingProduct(
                id: "orderingProductID07",
                price: 180000,
                productID: "productID07",
                realPrice: 160000,
                userID: "userID07",
                voucherID: "voucherID07"),
            OrderingProduct(
                id: "orderingProductID08",
                price: 190000,
                productID: "productID08",
                realPrice: 170000,
                userID: "userID08",
                voucherID: "voucherID08"),
            OrderingProduct(
                id: "orderingProductID09",
                price: 200000,
                productID: "productID09",
                realPrice: 180000,
                userID: "userID09",
                voucherID: "voucherID09"),
            OrderingProduct(
                id: "orderingProductID10",
                price: 210000,
                productID: "productID10",
                realPrice: 190000,
                userID: "userID10",
                voucherID: "voucherID10"),
            OrderingProduct(
                id: "orderingProductID11",
                price: 220000,
                productID: "productID11",
                realPrice: 200000,
                userID: "userID11",
                voucherID: "voucherID11"),
            OrderingProduct(
                id: "orderingProductID12",
                price: 230000,
                productID: "productID12",
                realPrice: 210000,
                userID: "userID12",
                voucherID: "voucherID12"),
            OrderingProduct(
                id: "orderingProductID13",
                price: 240000,
                productID: "productID13",
                realPrice: 220000,
                userID: "userID13",
                voucherID: "voucherID13"),
            OrderingProduct(
                id: "orderingProductID14",
                price: 250000,
                productID: "productID14",
                realPrice: 230000,
                userID: "userID14",
                voucherID: "voucherID14"),
            OrderingProduct(
                id: "orderingProductID15",
                price: 260000,
                productID: "productID15",
                realPrice: 240000,
                userID: "userID15",
                voucherID: "voucherID15"),
          ],
          paymentTypeID: "paymentTypeID01",
          receivedAddress: AddressInfor(
              city: City(id: 8, name: "Tuyen Quang"),
              country: "Viet Nam",
              latitude: 120.12,
              longitude: 120.12,
              isDefaultAddress: true,
              name: "Home",
              district: District(id: 123, name: "Hoang Mai"))));
  final Order order = Order(
      deliverServiceID: "deliverID01",
      // deliverStatus: DeliverStatus.delivering,
      id: "orderID01",
      orderingProductsID: [
        OrderingProduct(
            id: "orderingProductID01",
            price: 120000,
            productID: "productID01",
            realPrice: 100000,
            userID: "userID01",
            voucherID: "voucherID01"),
        OrderingProduct(
            id: "orderingProductID02",
            price: 130000,
            productID: "productID02",
            realPrice: 110000,
            userID: "userID02",
            voucherID: "voucherID02"),
        OrderingProduct(
            id: "orderingProductID03",
            price: 140000,
            productID: "productID03",
            realPrice: 120000,
            userID: "userID03",
            voucherID: "voucherID03"),
        OrderingProduct(
            id: "orderingProductID04",
            price: 150000,
            productID: "productID04",
            realPrice: 130000,
            userID: "userID04",
            voucherID: "voucherID04"),
        OrderingProduct(
            id: "orderingProductID05",
            price: 160000,
            productID: "productID05",
            realPrice: 140000,
            userID: "userID05",
            voucherID: "voucherID05"),
        OrderingProduct(
            id: "orderingProductID06",
            price: 170000,
            productID: "productID06",
            realPrice: 150000,
            userID: "userID06",
            voucherID: "voucherID06"),
        OrderingProduct(
            id: "orderingProductID07",
            price: 180000,
            productID: "productID07",
            realPrice: 160000,
            userID: "userID07",
            voucherID: "voucherID07"),
        OrderingProduct(
            id: "orderingProductID08",
            price: 190000,
            productID: "productID08",
            realPrice: 170000,
            userID: "userID08",
            voucherID: "voucherID08"),
        OrderingProduct(
            id: "orderingProductID09",
            price: 200000,
            productID: "productID09",
            realPrice: 180000,
            userID: "userID09",
            voucherID: "voucherID09"),
        OrderingProduct(
            id: "orderingProductID10",
            price: 210000,
            productID: "productID10",
            realPrice: 190000,
            userID: "userID10",
            voucherID: "voucherID10"),
        OrderingProduct(
            id: "orderingProductID11",
            price: 220000,
            productID: "productID11",
            realPrice: 200000,
            userID: "userID11",
            voucherID: "voucherID11"),
        OrderingProduct(
            id: "orderingProductID12",
            price: 230000,
            productID: "productID12",
            realPrice: 210000,
            userID: "userID12",
            voucherID: "voucherID12"),
        OrderingProduct(
            id: "orderingProductID13",
            price: 240000,
            productID: "productID13",
            realPrice: 220000,
            userID: "userID13",
            voucherID: "voucherID13"),
        OrderingProduct(
            id: "orderingProductID14",
            price: 250000,
            productID: "productID14",
            realPrice: 230000,
            userID: "userID14",
            voucherID: "voucherID14"),
        OrderingProduct(
            id: "orderingProductID15",
            price: 260000,
            productID: "productID15",
            realPrice: 240000,
            userID: "userID15",
            voucherID: "voucherID15"),
      ],
      paymentTypeID: "paymentTypeID01",
      receivedAddress: AddressInfor(
          city: City(id: 8, name: "Tuyen Quang"),
          country: "Viet Nam",
          latitude: 120.12,
          longitude: 120.12,
          isDefaultAddress: true,
          name: "Home",
          district: District(id: 123, name: "Hoang Mai")));
}
