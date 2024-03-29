import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/category.dart';

class CategoryRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Future<List<Category>?> getListCategory() async {
    final result = await firestoreDatabase.getListCategory();
    return result;
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }

  List<Category>? list = [
    Category(
        id: "Cate1",
        name: "Clothe",
        logo:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1245px-Logo_of_Twitter.svg.png"),
    Category(
        id: "Cate2",
        name: "Clothe2",
        logo:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1245px-Logo_of_Twitter.svg.png"),
    Category(
        id: "Cate3",
        name: "Clothe3",
        logo:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1245px-Logo_of_Twitter.svg.png"),
    Category(
        id: "Cate4",
        name: "Clothe4",
        logo:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1245px-Logo_of_Twitter.svg.png"),
    Category(
        id: "Cate5",
        name: "Clothe5",
        logo:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1245px-Logo_of_Twitter.svg.png"),
    Category(
        id: "Cate6",
        name: "Clothe6",
        logo:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/1245px-Logo_of_Twitter.svg.png"),
  ];
}
