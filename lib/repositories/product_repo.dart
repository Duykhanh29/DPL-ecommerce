import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/product_firestore_data.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/review.dart';

class ProductRepo {
  FirestoreDatabase productFirestoreDatabase = FirestoreDatabase();
  Stream<List<Product>?> getListActiveProduct() async* {
    productFirestoreDatabase.getListActiveProduct();
  }

  Future<List<Product>?> getActiveProducts() async {
    await productFirestoreDatabase.getActiveProducts();
  }

  Future<List<Product>?> getListRelatedProduct(String categoryID) async {
    return await productFirestoreDatabase.getRelatedProduct(categoryID);
  }

  Future<Product?> getProductByID(String id) async {
    return await productFirestoreDatabase.getProductByID(id);
  }

  Future<void> addProduct(Product product) async {
    await productFirestoreDatabase.postProduct(product);
  }

  Future<void> deleteProduct({required String productID}) async {}
  Future<void> updateProduct({
    required String productID,
    int? quantity,
    int? cost,
    List<String>? colors,
    List<String>? types,
    List<String>? sizes,
    List<String>? images,
    List<String>? videos,
    String? description,
    int? ratingCount,
    int? purchasingCount,
  }) async {
    // await productFirestoreDatabase.updateProduct(
    //   productID: productID,
    // );
  }
  Future<List<Product>?> searchProductByName(String name) async {
    return await productFirestoreDatabase.searchProductByName(name);
  }

  Future<List<Product>?> searchProductByNameAndRating(
      {required String name, required double rating}) async {
    return await productFirestoreDatabase.searchProductByNameAndRating(
        name: name, rating: rating);
  }

  Future<List<Product>?> searchProductByNameAndPriceRange(
      {required String name,
      required int maxPrice,
      required int minPrice}) async {
    return await productFirestoreDatabase.searchProductByNameAndPriceRange(
        maxPrice: maxPrice, minPrice: minPrice, name: name);
  }

  Future<List<Product>?> searchProductByNameAndNewestProduct(
      {required String name, required DateTime dateTime}) async {
    return await productFirestoreDatabase.searchProductByNameAndNewestProduct(
        dateTime: dateTime, name: name);
  }

  Future<List<Product>?> searchProductByNameAndCategory(
      {required String name, required String categoryID}) async {
    return await productFirestoreDatabase.searchProductByNameAndCategory(
        categoryID: categoryID, name: name);
  }

  Future<List<Product>?> filterMixedConditions({
    String? name,
    String? categoryID,
    int? minPrice,
    int? maxPrice,
    DateTime? dateTime,
    double? rating,
  }) async {
    return await productFirestoreDatabase.filterMixedConditions(
        categoryID: categoryID,
        name: name,
        dateTime: dateTime,
        maxPrice: maxPrice,
        minPrice: minPrice,
        rating: rating);
  }

  Future<void> addNewReview(Review review) async {
    await productFirestoreDatabase.addNewReview(review);
  }

  Future<void> deleteReview(String reviewID) async {
    await productFirestoreDatabase.deleteReview(reviewID);
  }

  Future<void> editReview() async {}

  Future<void> dispose() async {
    await productFirestoreDatabase.dispose();
  }

  List<Product>? list = [
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID01",
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Cloth",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID01",
        "reviewID02",
        "reviewID03",
      ],
      shopID: "shopID01",
      shopLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpJQq_-DhuwRXiRIHcypaS8QpphdlR_4nJW-mlHakPX5JiJLqLQI18ypV-8vxLkfqS4D8&usqp=CAU",
      shopName: "DK",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID02",
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Cloth",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID04",
      ],
      shopID: "shopID04",
      shopLogo:
          "https://www.cnrs.fr/sites/default/files/styles/article/public/image/M87polarimetricimageSMOL.jpg?itok=fKHtm7EW",
      shopName: "Astronomers",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID03",
      images: [
        // "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Shoes",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID05",
        "reviewID06",
      ],
      shopID: "shopID06",
      shopLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWAA2F_8Wnf9R0jW22aHqSbqP_xDMCuO4x5Q&usqp=CAU",
      shopName: "World",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID01",
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Cloth",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID01",
        "reviewID02",
        "reviewID03",
      ],
      shopID: "shopID01",
      shopLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpJQq_-DhuwRXiRIHcypaS8QpphdlR_4nJW-mlHakPX5JiJLqLQI18ypV-8vxLkfqS4D8&usqp=CAU",
      shopName: "DK",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID02",
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Cloth",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID04",
      ],
      shopID: "shopID04",
      shopLogo:
          "https://www.cnrs.fr/sites/default/files/styles/article/public/image/M87polarimetricimageSMOL.jpg?itok=fKHtm7EW",
      shopName: "Astronomers",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID03",
      images: [
        // "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Shoes",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID05",
        "reviewID06",
      ],
      shopID: "shopID06",
      shopLogo:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWAA2F_8Wnf9R0jW22aHqSbqP_xDMCuO4x5Q&usqp=CAU",
      shopName: "World",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: Timestamp.fromDate(DateTime(2023, 11, 4)),
      description: "This is a clothe",
      id: "productID04",
      images: [
        // "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
        "https://images.unsplash.com/photo-1541963463532-d68292c34b19?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D",
        "https://images.pexels.com/photos/11061877/pexels-photo-11061877.jpeg?cs=srgb&dl=pexels-bailey-dill-11061877.jpg&fm=jpg"
      ],
      name: "Hat",
      price: 12345,
      purchasingCount: 123,
      rating: 4.3,
      ratingCount: 100,
      reviewIDs: [
        "reviewID07",
        "reviewID08",
        "reviewID09",
      ],
      shopID: "shopID01",
      shopLogo:
          "https://www.techsmith.com/blog/wp-content/uploads/2022/03/resize-image.png",
      shopName: "SHOP HERE",
      updatedAt: Timestamp.fromDate(DateTime.now()),
    ),
  ];
}
