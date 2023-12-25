import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/payment_type.dart';

class PayMentRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Future<List<PaymentType>?> getListPayment() async {
    return await firestoreDatabase.getListPayment();
  }

  Future<PaymentType?> getPaymentByID(String id) async {
    return await firestoreDatabase.getPaymentByID(id);
  }

  Future<void> deletePayment(String id) async {
    await firestoreDatabase.deletePaymentByID(id);
  }

  final List<PaymentType> listPayment = [
    PaymentType(
        id: "PaymentTypeID01",
        name: "Cash",
        symbol:
            "https://img.freepik.com/premium-vector/three-dollar-icon-american-money-symbol-sign-cash-vector_744955-33.jpg?w=2000")
  ];
}
