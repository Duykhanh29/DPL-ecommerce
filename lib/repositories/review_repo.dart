import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/review.dart';

class ReviewRepo {
  FirestoreDatabase _reviewFirestoreDB = FirestoreDatabase();
  // Future<List<Review>> getListReviewByProduct(String productID)async{

  // }
  Future<void> dispose() async {
    await _reviewFirestoreDB.dispose();
  }

  final List<Review> listReview = [
    Review(
        id: "reviewID01",
        productID: "product01",
        rating: 4.5,
        resourseType: ResourseType.image,
        text: "You are great",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg",
        userID: "user01"),
    Review(
        id: "reviewID02",
        productID: "product01",
        rating: 4.2,
        resourseType: ResourseType.image,
        text: "Awesome product",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://www.eurojuris.fr/medias/org-224/shared/droit-a-l-image.png",
        userID: "user02"),
    Review(
        id: "reviewID03",
        productID: "product02",
        rating: 4.0,
        resourseType: ResourseType.video,
        text: "Great review",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://www.eurojuris.fr/medias/org-224/shared/droit-a-l-image.png",
        userID: "user03"),
    Review(
        id: "reviewID04",
        productID: "product01",
        rating: 4.7,
        resourseType: ResourseType.image,
        text: "Amazing",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://www.eurojuris.fr/medias/org-224/shared/droit-a-l-image.png",
        userID: "user04"),
    Review(
        id: "reviewID05",
        productID: "product02",
        rating: 3.8,
        resourseType: ResourseType.video,
        text: "Not bad at all",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://huggingface.co/tasks/assets/image-classification/image-classification-input.jpeg",
        userID: "user05"),
    Review(
        id: "reviewID06",
        productID: "product03",
        rating: 4.5,
        resourseType: ResourseType.image,
        text: "Superb",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://img.freepik.com/premium-photo/boy-is-using-laptop-with-word-s-screen_972034-586.jpg",
        userID: "user06"),
    Review(
        id: "reviewID07",
        productID: "product02",
        rating: 4.1,
        resourseType: ResourseType.image,
        text: "Impressive",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://huggingface.co/tasks/assets/image-classification/image-classification-input.jpeg",
        userID: "user07"),
    Review(
        id: "reviewID08",
        productID: "product03",
        rating: 3.7,
        resourseType: ResourseType.video,
        text: "Average",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://huggingface.co/tasks/assets/image-classification/image-classification-input.jpeg",
        userID: "user08"),
    Review(
        id: "reviewID09",
        productID: "product04",
        rating: 4.8,
        resourseType: ResourseType.image,
        text: "Excellent",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://img.freepik.com/premium-photo/boy-is-using-laptop-with-word-s-screen_972034-586.jpg",
        userID: "user09"),
    Review(
        id: "reviewID10",
        productID: "product04",
        rating: 4.9,
        resourseType: ResourseType.image,
        text: "Highly recommended",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://img.freepik.com/premium-photo/cartoon-character-kid-staring-space-book_772785-2908.jpg",
        userID: "user10"),
    Review(
        id: "reviewID11",
        productID: "product05",
        rating: 4.3,
        resourseType: ResourseType.video,
        text: "Decent quality",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://img.freepik.com/premium-photo/cartoon-character-kid-staring-space-book_772785-2908.jpg",
        userID: "user11"),
    Review(
        id: "reviewID12",
        productID: "product06",
        rating: 3.5,
        resourseType: ResourseType.image,
        text: "Needs improvement",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://img.freepik.com/premium-photo/cartoon-character-kid-staring-space-book_772785-2908.jpg",
        userID: "user12"),
    Review(
        id: "reviewID13",
        productID: "product06",
        rating: 4.0,
        resourseType: ResourseType.video,
        text: "Satisfactory",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://huggingface.co/tasks/assets/image-classification/image-classification-input.jpeg",
        userID: "user13"),
    Review(
        id: "reviewID14",
        productID: "product07",
        rating: 4.7,
        resourseType: ResourseType.image,
        text: "Fantastic",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://huggingface.co/tasks/assets/image-classification/image-classification-input.jpeg",
        userID: "user14"),
    Review(
        id: "reviewID15",
        productID: "product08",
        rating: 4.6,
        resourseType: ResourseType.video,
        text: "Well done",
        time: Timestamp.fromDate(DateTime.now()),
        userAvatar:
            "https://img.freepik.com/premium-photo/cartoon-character-kid-staring-space-book_772785-2908.jpg",
        userID: "user15")
  ];
}
