import 'package:dpl_ecommerce/models/product.dart';

class ProductRepo {
  List<Product>? list = [
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: DateTime(2023, 11, 4),
      description: "This is a clothe",
      id: "productID01",
      images: [
        "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
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
      updatedAt: DateTime.now(),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: DateTime(2023, 11, 4),
      description: "This is a clothe",
      id: "productID02",
      images: [
        "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
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
      updatedAt: DateTime.now(),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: DateTime(2023, 11, 4),
      description: "This is a clothe",
      id: "productID03",
      images: [
        "https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png",
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
      updatedAt: DateTime.now(),
    ),
    Product(
      availableQuantity: 100,
      categoryID: "cacd",
      colors: ["Red", "Yellow"],
      createdAt: DateTime(2023, 11, 4),
      description: "This is a clothe",
      id: "productID04",
      images: [
        "https://t3.ftcdn.net/jpg/06/49/51/82/360_F_649518247_J27irz9TezhqqHS6EpF0AQY7bFdVAIn8.jpg",
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
      updatedAt: DateTime.now(),
    ),
  ];
}
